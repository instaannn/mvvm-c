//
//  StepperView.swift
//  RedsoftTest
//
//  Created by Анна Сычева on 14.01.2021.
//

import UIKit

// MARK: - StepperView

final class StepperView: UIView {
    
    // MARK: - Public properties
    
    var completionMinus: (() -> Void)?
    var completionPlus: (() -> Void)?
    
    let amountLabel = UILabel()
    let plusButton = UIButton()
    let minusButton = UIButton()
    
    // MARK: - Private properties
    
    private let stepperStackView = UIStackView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupVies()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup

extension StepperView {
    
    private func setupVies() {
        addVies()
        addActions()
        stepperStackViewLayout()
        setupStepperStackView()
    }
}

// MARK: - Setup Elements

extension StepperView {
    
    private func addVies() {
        addSubview(stepperStackView)
    }
    
    private func addActions() {
        minusButton.addTarget(self, action: #selector(minusActionButton), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusActionButton), for: .touchUpInside)
    }
    
    @objc
    private func minusActionButton() {
        completionMinus?()
    }
    
    @objc
    private func plusActionButton() {
        completionPlus?()
    }
    
    private func setupStepperStackView() {
        stepperStackView.axis = .horizontal
        stepperStackView.distribution = .fillEqually
        stepperStackView.spacing = Constants.stepperStackViewSpacing
        addElementsOnStackView()
    }
    
    private func addElementsOnStackView() {
        stepperStackView.backgroundColor = .systemBlue
        stepperStackView.layer.cornerRadius = Constants.stepperStackViewCornerRadius
        
        minusButton.setImage(UIImage(named: Constants.minusButtonSetImageName), for: .normal)
        minusButton.imageView?.contentMode = .scaleAspectFill
        minusButton.imageEdgeInsets = UIEdgeInsets(top: Constants.edgeInsets,
                                                   left: Constants.edgeInsets,
                                                   bottom: Constants.edgeInsets,
                                                   right: Constants.edgeInsets)
        
        amountLabel.textAlignment = .center
        amountLabel.font = UIFont.boldSystemFont(ofSize: Constants.amountLabelFont)
        amountLabel.textColor = .white
        
        plusButton.setImage(UIImage(named: Constants.plusButtonSetImageName), for: .normal)
        plusButton.imageView?.contentMode = .scaleAspectFill
        plusButton.imageEdgeInsets = UIEdgeInsets(top: Constants.edgeInsets,
                                                  left: Constants.edgeInsets,
                                                  bottom: Constants.edgeInsets,
                                                  right: Constants.edgeInsets)
        
        stepperStackView.addArrangedSubview(minusButton)
        stepperStackView.addArrangedSubview(amountLabel)
        stepperStackView.addArrangedSubview(plusButton)
    }
}

// MARK: - Layout

extension StepperView {
    
    private func stepperStackViewLayout() {
        
        stepperStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [stepperStackView.topAnchor.constraint(
                equalTo: topAnchor),
             stepperStackView.bottomAnchor.constraint(
                equalTo: bottomAnchor),
             stepperStackView.leadingAnchor.constraint(
                equalTo: leadingAnchor),
             stepperStackView.trailingAnchor.constraint(
                equalTo: trailingAnchor)])
    }
}

// MARK: - Constants

extension StepperView {
    
    enum Constants {
        static let edgeInsets: CGFloat = 7
        static let plusButtonSetImageName: String = "plus"
        static let amountLabelFont: CGFloat = 16
        static let minusButtonSetImageName: String = "minus"
        static let stepperStackViewCornerRadius: CGFloat = 5
        static let stepperStackViewSpacing: CGFloat = 10
    }
    
}
