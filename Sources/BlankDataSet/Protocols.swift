//
//  UIScrollView+Ex.swift
//  BlankKit
//
//  Created by 蔡志文 on 2020/8/25.
//

import UIKit

public protocol BlankDataSetProtocol where Self: UIView {
    var blankSetDelegate: BlankDataSetDelegate? { get set }
    var blankSetDataSource: BlankDataSetDataSource? { get set }
}

public protocol BlankDataSetDataSource: NSObjectProtocol {
    
    func imageForBlankDataSet() -> UIImage?
    
    func titleForBlankDataSet() -> BlankTextConfiguration?
    
    func detailForBlankDataSet() -> BlankTextConfiguration?

    func buttonForBlankDataSet() -> BlankButtonConfiguration?
    
    func customViewForBlankDataSet() -> UIView?
    
    func verticalSpacesForBlankDataSetItems() -> [CGFloat]
    
    func verticalSpaceForBlankDataSet() -> CGFloat
    
    func offsetForBlankDataSet() -> CGFloat
    
}


public protocol BlankDataSetDelegate: NSObjectProtocol {
    
    func blankDataSetShouldForcedToDisplay() -> Bool
    
    func blankDataSetShouldDisplay() -> Bool
    
    func blankDataSetShouldAllowTouch() -> Bool
    
    func blankDataSetShouldAllowScroll() -> Bool
    
    func blankDataSetDidTapView()
    
    func blankDataSetDidTapButton()
}

public extension BlankDataSetDataSource {
    
    func imageForBlankDataSet() -> UIImage? { return nil }
    
    func titleForBlankDataSet() -> BlankTextConfiguration? { return nil }
    
    func detailForBlankDataSet() -> BlankTextConfiguration? {return nil }
    
    func buttonForBlankDataSet() -> BlankButtonConfiguration? { return nil }
    
    func customViewForBlankDataSet() -> UIView? { return nil }
    
    func verticalSpacesForBlankDataSetItems() -> [CGFloat] {  return [] }
    
    func verticalSpaceForBlankDataSet() -> CGFloat { return 10.0 }
    
    func offsetForBlankDataSet() -> CGFloat { return 0.0 }
    
}

public extension BlankDataSetDelegate {
    func blankDataSetShouldForcedToDisplay() -> Bool { return false }
    
    func blankDataSetShouldDisplay() -> Bool { return true }
    
    func blankDataSetShouldAllowTouch() -> Bool { return true }
    
    func blankDataSetShouldAllowScroll() -> Bool { return false }
    
    func blankDataSetDidTapView() {}
    
    func blankDataSetDidTapButton() {}
}

public enum BlankTextConfiguration {
    case normal(String, UIColor, UIFont)
    case rich(NSAttributedString)
}

public struct BlankButtonConfiguration {
    
    var titleConfiguration: BlankTextConfiguration?
    var image: UIImage?
    var backgroundColor: UIColor?
    var backgroundImage: UIImage?
    var borderWidth: CGFloat
    var borderColor: UIColor
    var cornerRadius: CGFloat
    var titleImageSpace: CGFloat = 0
    var size: CGSize
    
    
    init(titleConfiguration: BlankTextConfiguration?, image: UIImage? = nil, backgroundColor: UIColor? = nil, backgroundImage: UIImage? = nil, borderWidth: CGFloat = 0, borderColor: UIColor = UIColor.clear, cornerRadius: CGFloat = 0, titleImageSpace: CGFloat = 0, size: CGSize) {
        self.titleConfiguration = titleConfiguration
        self.image = image
        self.backgroundColor = backgroundColor
        self.backgroundImage = backgroundImage
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.cornerRadius = cornerRadius
        self.titleImageSpace = titleImageSpace
        self.size = size
    }
}
