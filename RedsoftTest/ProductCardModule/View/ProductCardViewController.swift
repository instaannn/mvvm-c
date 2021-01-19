//
//  ProductCardViewController.swift
//  RedsoftTest
//
//  Created by Анна Сычева on 11.01.2021.
//

import UIKit

// MARK: - ProductCardViewController

final class ProductCardViewController: UIViewController {
    
    // MARK: - Public properties
    
    var viewModel: ProductCardViewModel?
    
    // MARK: - Private properties
    
    private var productCardModel: ProductCardModel?
    private let productCardTitle = UILabel()
    private let productCardProducer = UILabel()
    private let productCardImage = UIImageView()
    private let productCardShortDescription = UILabel()
    private let productCardCategoriesStackView = UIStackView()
    private let productCardPrice = UILabel()
    private let shoppingСart = UIButton()
    private let stepperView = StepperView()
    
    private var amount = Int()
    private var id = Int()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVies()
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadStartState()
    }
}

// MARK: - Setup

extension ProductCardViewController {
    
    private func setupVies() {
        addVies()
        addActions()
        productCardTitleLayout()
        productCardProducerLayout()
        productCardImageLayout()
        productCardShortDescriptionLayout()
        productCardCategoriesStackViewLayout()
        productCardPriceLayout()
        shoppingCartLayout()
        stepperViewLayout()
    }
    
    private func setupBinding() {
        viewModel?.didWillappear()
        
        DispatchQueue.main.async {
            self.viewModel?.productCardDidChange = { [weak self] viewModel in
                guard let self = self else { return }
                self.productCardModel = viewModel
                self.setupView()
                self.setupProductCardTitle()
                self.setupProductCardProducer()
                self.setupProductCardImage()
                self.setupProductCardShortDescription()
                self.setupProductCardCategoriesStackView()
                self.setupProductCardPrice()
                self.setupShoppingCart()
                self.setupStepperView()
                self.setupNavigation()
            }
        }
    }
    
    private func loadStartState() {
        
        id = viewModel?.id ?? Constants.indexZero
        
        amount = StorageManager.shared.load(key: String(id))
        
        if amount > Constants.indexZero {
            shoppingСart.isHidden = true
            stepperView.isHidden = false
            stepperView.amountLabel.text = String(amount)
        } else {
            shoppingСart.isHidden = false
            stepperView.isHidden = true
        }
    }
}

// MARK: - Setup Elements

extension ProductCardViewController {
    
    private func addVies() {
        view.addSubview(productCardTitle)
        view.addSubview(productCardProducer)
        view.addSubview(productCardImage)
        view.addSubview(productCardShortDescription)
        view.addSubview(productCardCategoriesStackView)
        view.addSubview(productCardPrice)
        view.addSubview(shoppingСart)
        view.addSubview(stepperView)
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupProductCardTitle() {
        productCardTitle.text = productCardModel?.data.title
        createLabel(namelabel: productCardTitle,
                    ofSize: Constants.labelSizeTwenty,
                    weight: .bold,
                    textAlignment: .left,
                    textcolor: .black)
    }
    
    private func setupProductCardProducer() {
        productCardProducer.text = productCardModel?.data.producer
        createLabel(namelabel: productCardProducer,
                    ofSize: Constants.labelSize,
                    weight: .regular,
                    textAlignment: .left,
                    textcolor: .systemGray)
    }
    
    private func setupProductCardImage() {
        guard let productCardImageString = productCardModel?.data.imageUrl else { return }
        guard let url = URL(string: productCardImageString) else { return }
        productCardImage.load(url: url)
        productCardImage.contentMode = .scaleAspectFill
    }
    
    private func setupProductCardShortDescription() {
        productCardShortDescription.text = productCardModel?.data.shortDescription
        createLabel(namelabel: productCardShortDescription,
                    ofSize: Constants.labelSize,
                    weight: .regular,
                    textAlignment: .left,
                    textcolor: .black)
        productCardShortDescription.numberOfLines = Constants.productCardShortDescriptionNumberOfLines
    }
    
    private func setupProductCardCategoriesStackView() {
        productCardCategoriesStackView.axis = .vertical
        productCardCategoriesStackView.distribution = .fillProportionally
        productCardCategoriesStackView.spacing = Constants.productCardCategoriesStackViewSpacing
        addLabelOnStackView()
    }
    
    private func addLabelOnStackView() {
        guard let categories = productCardModel?.data.categories else { return }
        
        if categories.count > Constants.indexZero {
            for index in Constants.indexZero...categories.count - Constants.indexOne {
                let label = UILabel()
                label.text = categories[index].title
                createLabel(namelabel: label,
                            ofSize: Constants.labelSize,
                            weight: .regular,
                            textAlignment: .left,
                            textcolor: .systemGray3)
                productCardCategoriesStackView.addArrangedSubview(label)
            }
        }
    }
    
    private func setupProductCardPrice() {
        productCardPrice.text = String(productCardModel?.data.price ?? 0)
        createLabel(namelabel: productCardPrice,
                    ofSize: Constants.labelSizeTwenty,
                    weight: .bold,
                    textAlignment: .left,
                    textcolor: .systemBlue)
    }
    
    private func setupShoppingCart() {
        shoppingСart.setImage(UIImage(named: Constants.shoppingСartSetImageName), for: .normal)
        shoppingСart.imageView?.contentMode = .scaleAspectFit
        shoppingСart.imageEdgeInsets = UIEdgeInsets(top: Constants.UIEdgeInsetsFive,
                                                     left: Constants.imageEdgeInsetsLeft,
                                                     bottom: Constants.UIEdgeInsetsFive,
                                                     right: Constants.UIEdgeInsetsFive)
        shoppingСart.setTitle(Constants.shoppingСartSetTitle, for: .normal)
        shoppingСart.titleEdgeInsets = UIEdgeInsets(top: Constants.UIEdgeInsetsFive,
                                                     left: Constants.UIEdgeInsetsZero,
                                                     bottom: Constants.UIEdgeInsetsFive,
                                                     right: Constants.UIEdgeInsetsFifty)
        shoppingСart.layer.cornerRadius = Constants.shoppingСartCornerRadius
        shoppingСart.backgroundColor = .systemBlue
    }
    
    private func addActions() {
        shoppingСart.addTarget(self, action: #selector(actionShoppingButton), for: .touchUpInside)
    }
    
    @objc
    private func actionShoppingButton() {
        amount += Constants.indexOne
        if amount > Constants.indexZero {
            shoppingСart.isHidden = true
            stepperView.isHidden = false
            stepperView.amountLabel.text = String(amount)
            saveAmount(key: String(id))
        }
    }
    
    private func setupNavigation() {
        navigationItem.title = productCardModel?.data.title
    }
    
    
    private func saveAmount(key: String) {
        StorageManager.shared.save(value: String(amount), for: key)
    }
    
    private func setupStepperView() {
        
        stepperView.completionPlus = {
            if self.amount > Constants.indexZero {
                self.amount += Constants.indexOne
                self.stepperView.amountLabel.text = String(self.amount)
            }
            if self.amount == self.productCardModel?.data.amount {
                self.stepperView.plusButton.isHidden = true
            }
            self.saveAmount(key: String(self.id))
        }
        
        stepperView.completionMinus = {
            if self.amount <= self.productCardModel?.data.amount ?? Constants.indexZero {
                self.amount -= Constants.indexOne
                self.stepperView.amountLabel.text = String(self.amount)
                self.stepperView.plusButton.isHidden = false
            }
            if self.amount == Constants.indexZero {
                self.stepperView.isHidden = true
                self.shoppingСart.isHidden = false
            }
            self.saveAmount(key: String(self.id))
        }
        stepperView.amountLabel.text = String(amount)
    }
    
    private func createLabel(namelabel: UILabel,
                             ofSize: CGFloat,
                             weight: UIFont.Weight,
                             textAlignment: NSTextAlignment,
                             textcolor: UIColor) {
        namelabel.font = UIFont.systemFont(ofSize: ofSize, weight: weight)
        namelabel.textAlignment = textAlignment
        namelabel.textColor = textcolor
    }
}

// MARK: - Layout

extension ProductCardViewController {
    
    private func productCardTitleLayout() {
        
        productCardTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [productCardTitle.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: Constants.anchorTwenty),
             productCardTitle.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.anchorTwenty),
             productCardTitle.widthAnchor.constraint(
                equalToConstant: Constants.anchorTwoHundred),
             productCardTitle.heightAnchor.constraint(
                equalToConstant: Constants.anchorTwenty)])
    }
    
    private func productCardProducerLayout() {
        productCardProducer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [productCardProducer.leadingAnchor.constraint(
                equalTo: productCardTitle.leadingAnchor),
             productCardProducer.trailingAnchor.constraint(
                equalTo: productCardTitle.trailingAnchor),
             productCardProducer.topAnchor.constraint(
                equalTo: productCardTitle.bottomAnchor, constant: Constants.productCardTitleBottomAnchor),
             productCardProducer.heightAnchor.constraint(
                equalToConstant: Constants.anchorTwenty)])
    }
    
    private func productCardImageLayout() {
        
        productCardImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [productCardImage.leadingAnchor.constraint(
                equalTo: productCardTitle.leadingAnchor),
             productCardImage.topAnchor.constraint(
                equalTo: productCardProducer.bottomAnchor, constant: Constants.productCardProducerBottomAnchor),
             productCardImage.widthAnchor.constraint(
                equalToConstant: Constants.widthAnchor),
             productCardImage.heightAnchor.constraint(
                equalToConstant: Constants.anchorTwoHundred)])
    }
    
    private func productCardShortDescriptionLayout() {
        
        productCardShortDescription.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [productCardShortDescription.topAnchor.constraint(
                equalTo: productCardImage.topAnchor),
             productCardShortDescription.leadingAnchor.constraint(
                equalTo: productCardImage.trailingAnchor, constant: Constants.anchorTwenty),
             productCardShortDescription.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -Constants.anchorTwenty),
             productCardShortDescription.heightAnchor.constraint(
                equalToConstant: Constants.productCardShortDescriptionHeightAnchor)])
    }
    
    private func productCardCategoriesStackViewLayout() {
        
        productCardCategoriesStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [productCardCategoriesStackView.bottomAnchor.constraint(
                equalTo: productCardImage.bottomAnchor),
             productCardCategoriesStackView.leadingAnchor.constraint(
                equalTo: productCardImage.trailingAnchor, constant: Constants.anchorTwenty),
             productCardCategoriesStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -Constants.anchorTwenty),
             productCardCategoriesStackView.heightAnchor.constraint(
                equalToConstant: Constants.productCardCategoriesStackViewHeightAnchor)])
    }
    
    private func productCardPriceLayout() {
        
        productCardPrice.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [productCardPrice.leadingAnchor.constraint(
                equalTo: productCardImage.leadingAnchor),
             productCardPrice.widthAnchor.constraint(
                equalToConstant: Constants.widthAnchor),
             productCardPrice.topAnchor.constraint(
                equalTo: productCardImage.bottomAnchor, constant: Constants.anchorForty),
             productCardPrice.heightAnchor.constraint(
                equalToConstant: Constants.anchorForty)])
    }
    
    private func shoppingCartLayout() {
        
        shoppingСart.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [shoppingСart.leadingAnchor.constraint(
                equalTo: productCardImage.trailingAnchor, constant: Constants.anchorTwenty),
             shoppingСart.centerYAnchor.constraint(
                equalTo: productCardPrice.centerYAnchor),
             shoppingСart.heightAnchor.constraint(
                equalToConstant: Constants.anchorForty),
             shoppingСart.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -Constants.anchorTwenty)])
    }
    
    private func stepperViewLayout() {
        
        stepperView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [stepperView.leadingAnchor.constraint(
                equalTo: productCardImage.trailingAnchor, constant: Constants.anchorTwenty),
             stepperView.centerYAnchor.constraint(
                equalTo: productCardPrice.centerYAnchor),
             stepperView.heightAnchor.constraint(
                equalToConstant: Constants.anchorForty),
             stepperView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -Constants.anchorTwenty)])
    }
}

// MARK: - Constants

extension ProductCardViewController {
    
    enum Constants {
        static let anchorTwenty: CGFloat = 20
        static let anchorForty: CGFloat = 40
        static let widthAnchor: CGFloat = 150
        static let productCardCategoriesStackViewHeightAnchor: CGFloat = 100
        static let productCardShortDescriptionHeightAnchor: CGFloat = 60
        static let anchorTwoHundred: CGFloat = 200
        static let productCardProducerBottomAnchor: CGFloat = 30
        static let productCardTitleBottomAnchor: CGFloat = 10
        static let indexZero: Int = 0
        static let indexOne: Int = 1
        static let shoppingСartCornerRadius: CGFloat = 5
        static let UIEdgeInsetsFive: CGFloat = 5
        static let UIEdgeInsetsFifty: CGFloat = 50
        static let UIEdgeInsetsZero: CGFloat = 0
        static let imageEdgeInsetsLeft: CGFloat = 130
        static let shoppingСartSetTitle: String = "В корзину"
        static let shoppingСartSetImageName: String = "shopping-cart"
        static let labelSizeTwenty: CGFloat = 20
        static let labelSize: CGFloat = 15
        static let productCardCategoriesStackViewSpacing: CGFloat = 10
        static let productCardShortDescriptionNumberOfLines: Int = 0
    }
    
}
