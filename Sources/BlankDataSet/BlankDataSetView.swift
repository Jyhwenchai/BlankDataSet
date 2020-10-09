//
//  BlankDataSetView.swift
//  BlankKit
//
//  Created by 蔡志文 on 2020/8/26.
//

import UIKit


class BlankDataSetView: UIView {
    
    private var contentView: UIView = UIView()
    private var imageView: UIImageView = UIImageView()
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    private var detailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private var button: UIButton = UIButton()
    private var customView: UIView?
    
    private let referenceView = UIView()
    
    weak var owner: DataSetWeakOwner!

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        referenceView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction)))
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        clearConstraints()
        setConstraiants()
    }
    
    private func clearConstraints() {
        
        NSLayoutConstraint.deactivate(button.constraints)
        
        customView?.removeFromSuperview()
        customView = nil
        
        referenceView.removeFromSuperview()
        imageView.removeFromSuperview()
        titleLabel.removeFromSuperview()
        detailLabel.removeFromSuperview()
        button.removeFromSuperview()
    }

    
    private func setConstraiants() {
        guard let dataSource = owner?.blankSetDataSource else { return }

        customView = dataSource.customViewForBlankDataSet()
        if let customView = customView {
            customView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(customView)
            
            NSLayoutConstraint.activate([
                customView.topAnchor.constraint(equalTo: contentView.topAnchor),
                customView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            ])

            let verticalOffset = dataSource.offsetForBlankDataSet()
            NSLayoutConstraint.activate([
                contentView.bottomAnchor.constraint(equalTo: customView.bottomAnchor),
                contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
                contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
                contentView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: verticalOffset)
            ])

            return
        }


        var spaces: [CGFloat] = dataSource.verticalSpacesForBlankDataSetItems().reversed()
        let space: CGFloat = dataSource.verticalSpaceForBlankDataSet()

        while spaces.count < 3 {
            spaces.append(space)
        }

        contentView.addSubview(referenceView)
        NSLayoutConstraint.activate([
            referenceView.topAnchor.constraint(equalTo: contentView.topAnchor),
            referenceView.leadingAnchor.constraint(equalTo: leadingAnchor),
            referenceView.trailingAnchor.constraint(equalTo: trailingAnchor),
            referenceView.heightAnchor.constraint(equalToConstant: 1.0)
        ])

        var adjacentView: UIView = referenceView
        if let image = dataSource.imageForBlankDataSet() {
            imageView.image = image
            contentView.addSubview(imageView)

            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                imageView.topAnchor.constraint(equalTo: adjacentView.bottomAnchor)
            ])

            adjacentView = imageView
        }

        if let titleConfiguration = dataSource.titleForBlankDataSet() {
            switch titleConfiguration {
            case let .normal(text, color, font):
                titleLabel.text = text
                titleLabel.textColor = color
                titleLabel.font = font
            case let .rich(attributedText):
                titleLabel.attributedText = attributedText
            }

            contentView.addSubview(titleLabel)
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                titleLabel.topAnchor.constraint(equalTo: adjacentView.bottomAnchor, constant: spaces.popLast()!),
                titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            ])

            adjacentView = titleLabel
        }

        if let detailConfiguration = dataSource.detailForBlankDataSet() {
            switch detailConfiguration {
            case let .normal(text, color, font):
                detailLabel.text = text
                detailLabel.textColor = color
                detailLabel.font = font
            case let .rich(attributedText):
                detailLabel.attributedText = attributedText
            }

            contentView.addSubview(detailLabel)
            NSLayoutConstraint.activate([
                detailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                detailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                detailLabel.topAnchor.constraint(equalTo: adjacentView.bottomAnchor, constant: spaces.popLast()!),
                detailLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            ])

            adjacentView = detailLabel
        }

        if let buttonConfiguration = dataSource.buttonForBlankDataSet() {
            if let titleConfiguration = buttonConfiguration.titleConfiguration {
                switch titleConfiguration {
                case let .normal(text, color, font):
                    button.setTitle(text, for: .normal)
                    button.setTitleColor(color, for: .normal)
                    button.titleLabel?.font = font
                case let .rich(attributedText):
                    button.setAttributedTitle(attributedText, for: .normal)
                }
            }

            let backgroundImage = buttonConfiguration.backgroundImage
            button.setBackgroundImage(backgroundImage, for: .normal)

            let image = buttonConfiguration.image
            button.setImage(image, for: .normal)

            button.backgroundColor = buttonConfiguration.backgroundColor
            button.layer.borderWidth = buttonConfiguration.borderWidth
            button.layer.borderColor = buttonConfiguration.borderColor.cgColor
            button.layer.cornerRadius = buttonConfiguration.cornerRadius

            let titleImageSpace = buttonConfiguration.titleImageSpace

            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: titleImageSpace / 2, bottom: 0, right: -titleImageSpace / 2)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -titleImageSpace / 2, bottom: 0, right: titleImageSpace / 2)

            contentView.addSubview(button)

            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: adjacentView.bottomAnchor, constant: spaces.popLast()!),
                button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                button.widthAnchor.constraint(equalToConstant: buttonConfiguration.size.width),
                button.heightAnchor.constraint(equalToConstant: buttonConfiguration.size.height)
            ])
            adjacentView = button
        }

        let verticalOffset = dataSource.offsetForBlankDataSet()

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: referenceView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: verticalOffset),
            contentView.bottomAnchor.constraint(equalTo: adjacentView.bottomAnchor)
        ])

        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
    }
    
    @objc func tapAction() {
        owner.blankSetDelegate?.blankDataSetDidTapView()
    }
 
    @objc func buttonAction() {
        owner.blankSetDelegate?.blankDataSetDidTapButton()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let owner = owner else { return super.hitTest(point, with: event) }
        if let allowTouch = owner.blankSetDelegate?.blankDataSetShouldAllowTouch(), allowTouch {
            return super.hitTest(point, with: event)
        } else if let customView = customView, customView.frame.contains(convert(point, to: customView)) {
            let point = convert(point, to: customView)
            return customView.hitTest(point, with: event)
        } else if button.frame.contains(convert(point, to: contentView)) {
            let point = convert(point, to: button)
            return button.hitTest(point, with: event)
        } else {
            return nil
        }
    }
}
