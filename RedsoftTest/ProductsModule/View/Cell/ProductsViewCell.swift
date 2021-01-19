//
//  ProductsViewCell.swift
//  RedsoftTest
//
//  Created by Анна Сычева on 13.01.2021.
//

import UIKit

// MARK: - ProductsViewCell

final class ProductsViewCell: UITableViewCell {
    
    // MARK: Public properties
    
    var amount = Int()
    let shoppingСart = UIButton()
    var stepperView = StepperView()
    
    // MARK: - Private properties
    
    private let productImage = UIImageView()
    private let productDescriptionStackView = UIStackView()
    private let productTitleLabel = UILabel()
    private let productCategorieLabel = UILabel()
    private let productProducerLabel = UILabel()
    private let productPriceLabel = UILabel()
    
    private var id = Int()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupVies()
    }
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImage.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func set(products: Detail) {
        setCategori(products: products)
        setTitle(products: products)
        setProducer(products: products)
        setPrice(products: products)
        setImage(products: products)
        setButtonPlus(products: products)
        setButtonMinus(products: products)
        
        loadStartState(products: products)
    }
    
    // MARK: - Private methods
    
    private func loadStartState(products: Detail) {
        id = products.id
        
        amount = StorageManager.shared.load(key: String(id))
        
        guard amount > Constants.indexZero else { return }
        shoppingСart.isHidden = true
        stepperView.isHidden = false
        stepperView.amountLabel.text = String(amount)
    }
    
    private func setCategori(products: Detail) {
        switch products.categories.count {
        case 0:
            productCategorieLabel.text = Constants.defaultsValue
        default:
            productCategorieLabel.text = products.categories[Constants.indexZero].title
        }
    }
    
    private func setTitle(products: Detail) {
        productTitleLabel.text = products.title
    }
    
    private func setProducer(products: Detail) {
        productProducerLabel.text = products.producer
    }
    
    private func setPrice(products: Detail) {
        productPriceLabel.text = "\(products.price) \(Constants.productPriceLabel)"
    }
    
    private func setImage(products: Detail) {
        let productImageString = products.imageUrl
        guard let url = URL(string: productImageString) else { return }
        productImage.load(url: url)
    }
    
    private func setButtonPlus(products: Detail) {
        stepperView.completionPlus = { [weak self] in
            guard let self = self else { return }
            
            switch self.amount {
            case Constants.indexOne...:
                self.amount += Constants.indexOne
                self.stepperView.amountLabel.text = String(self.amount)
            case products.amount:
                self.stepperView.plusButton.isHidden = true
            default:
                break
            }
            self.saveAmount(key: String(self.id))
        }
    }
    
    private func setButtonMinus(products: Detail) {
        stepperView.completionMinus = {  [weak self] in
            guard let self = self else { return }
            
            if self.amount <= products.amount {
                self.amount -= Constants.indexOne
                self.stepperView.amountLabel.text = String(self.amount)
                self.stepperView.plusButton.isHidden = false
            }
            if self.amount <= Constants.indexZero {
                self.stepperView.isHidden = true
                self.shoppingСart.isHidden = false
            }
            self.saveAmount(key: String(self.id))
        }
    }
    
    public func saveAmount(key: String) {
        StorageManager.shared.save(value: String(amount), for: key)
    }
}

// MARK: - Setup

extension ProductsViewCell {
    
    private func setupVies() {
        addVies()
        addActions()
        
        setupProductImage()
        setupProductDescriptionStackView()
        setupProductPriceLabel()
        setupShoppingCart()
        setupStepperView()
        
        productImageLayout()
        productDescriptionStackViewLayout()
        productPriceLabelLayout()
        shoppingCartLayout()
        stepperViewLayout()
    }
}

// MARK: - Setup Elements

extension ProductsViewCell {
    
    private func addVies() {
        addSubview(productImage)
        addSubview(productDescriptionStackView)
        addSubview(productPriceLabel)
        addSubview(shoppingСart)
        addSubview(stepperView)
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
    
    private func setupProductImage() {
        productImage.contentMode = .scaleAspectFit
    }
    
    private func setupProductPriceLabel() {
        createLabel(namelabel: productPriceLabel,
                    ofSize: Constants.productPriceLabelSize,
                    weight: .bold,
                    textAlignment: .left,
                    textcolor: .systemBlue)
    }
    
    private func setupShoppingCart() {
        shoppingСart.setImage(UIImage(named: Constants.shoppingCartImageName), for: .normal)
        shoppingСart.imageView?.contentMode = .scaleAspectFill
        shoppingСart.imageEdgeInsets = UIEdgeInsets(top: Constants.shoppingСartImageEdgeInsets,
                                                     left: Constants.shoppingСartImageEdgeInsets,
                                                     bottom: Constants.shoppingСartImageEdgeInsets,
                                                     right: Constants.shoppingСartImageEdgeInsets)
        shoppingСart.layer.cornerRadius = Constants.shoppingСartCornerRadius
        shoppingСart.backgroundColor = .systemBlue
        shoppingСart.isHidden = false
    }
    
    private func setupStepperView() {
        stepperView.isHidden = true
    }
    
    private func setupProductDescriptionStackView() {
        productDescriptionStackView.axis = .vertical
        productDescriptionStackView.distribution = .fillProportionally
        productDescriptionStackView.spacing = Constants.productDescriptionStackViewSpacing
        addLabelOnStackView()
    }
    
    private func addLabelOnStackView() {
        createLabel(namelabel: productCategorieLabel,
                    ofSize: Constants.regularLabelSize,
                    weight: .regular,
                    textAlignment: .left,
                    textcolor: .systemGray3)
        createLabel(namelabel: productTitleLabel,
                    ofSize: Constants.boldLabelSize,
                    weight: .bold,
                    textAlignment: .left,
                    textcolor: .black)
        createLabel(namelabel: productProducerLabel,
                    ofSize: Constants.regularLabelSize,
                    weight: .regular,
                    textAlignment: .left,
                    textcolor: .systemGray)
        
        productDescriptionStackView.addArrangedSubview(productCategorieLabel)
        productDescriptionStackView.addArrangedSubview(productTitleLabel)
        productDescriptionStackView.addArrangedSubview(productProducerLabel)
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

extension ProductsViewCell {
    
    private func productImageLayout() {
        
        productImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [productImage.topAnchor.constraint(
                equalTo: topAnchor, constant: Constants.productImageAnchor),
             productImage.bottomAnchor.constraint(
                equalTo: bottomAnchor, constant: -Constants.productImageAnchor),
             productImage.leadingAnchor.constraint(
                equalTo: leadingAnchor, constant: Constants.anchorThirty),
             productImage.widthAnchor.constraint(
                equalToConstant: Constants.widthAnchorHundred)])
    }
    
    private func productDescriptionStackViewLayout() {
        
        productDescriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [productDescriptionStackView.topAnchor.constraint(
                equalTo: productImage.topAnchor),
             productDescriptionStackView.leadingAnchor.constraint(
                equalTo: productImage.trailingAnchor, constant: Constants.anchorThirty),
             productDescriptionStackView.heightAnchor.constraint(
                equalToConstant: Constants.productDescriptionStackViewHeightAnchor),
             productDescriptionStackView.trailingAnchor.constraint(
                equalTo: trailingAnchor, constant: -Constants.anchorThirty)])
    }
    
    private func productPriceLabelLayout() {
        
        productPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [productPriceLabel.leadingAnchor.constraint(
                equalTo: productDescriptionStackView.leadingAnchor),
             productPriceLabel.bottomAnchor.constraint(
                equalTo: productImage.bottomAnchor),
             productPriceLabel.heightAnchor.constraint(
                equalToConstant: Constants.productPriceLabelHeightAnchor),
             productPriceLabel.widthAnchor.constraint(
                equalToConstant: Constants.productPriceLabelWidthAnchor)])
    }
    
    private func shoppingCartLayout() {
        
        shoppingСart.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [shoppingСart.centerYAnchor.constraint(
                equalTo: productPriceLabel.centerYAnchor),
             shoppingСart.widthAnchor.constraint(
                equalToConstant: Constants.anchorThirty),
             shoppingСart.heightAnchor.constraint(
                equalToConstant: Constants.anchorThirty),
             shoppingСart.trailingAnchor.constraint(
                equalTo: trailingAnchor, constant: -Constants.anchorThirty)])
    }
    
    private func stepperViewLayout() {
        
        stepperView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [stepperView.centerYAnchor.constraint(
                equalTo: productPriceLabel.centerYAnchor),
             stepperView.widthAnchor.constraint(
                equalToConstant: Constants.widthAnchorHundred),
             stepperView.heightAnchor.constraint(
                equalToConstant: Constants.anchorThirty),
             stepperView.trailingAnchor.constraint(
                equalTo: trailingAnchor, constant: Constants.stepperViewTrailingAnchor)])
    }
}

//MARK: - Constants

extension ProductsViewCell {
    enum Constants {
        static let defaultsValue: String = ""
        static let productPriceLabel: String = "р."
        static let shoppingCartImageName: String = "shopping-cart"
        static let productPriceLabelSize: CGFloat = 14
        static let shoppingСartImageEdgeInsets: CGFloat = 3
        static let shoppingСartCornerRadius: CGFloat = 5
        static let productDescriptionStackViewSpacing: CGFloat = 10
        static let regularLabelSize: CGFloat = 15
        static let boldLabelSize: CGFloat = 20
        static let productImageAnchor: CGFloat = 10
        static let anchorThirty: CGFloat = 30
        static let widthAnchorHundred: CGFloat = 100
        static let productDescriptionStackViewHeightAnchor: CGFloat = 90
        static let productPriceLabelHeightAnchor: CGFloat = 40
        static let productPriceLabelWidthAnchor: CGFloat = 150
        static let stepperViewTrailingAnchor: CGFloat = -20
        static let indexZero: Int = 0
        static let indexOne: Int = 1
        static let indexTwo: Int = 2
    }
    
}
