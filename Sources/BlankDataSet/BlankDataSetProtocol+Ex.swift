//
//  BlankDataSetProtocol.swift
//  BlankKit
//
//  Created by 蔡志文 on 2020/8/26.
//

import UIKit

private enum AssociatedKeys {
    static var blankView = "blankView"
    static var dataSetWeakOwner = "dataSetWeakOwner"
    static var blankDataSetDelegate = "blankDataSetDelegate"
    static var blankDataSetDataSource = "blankDataSetDataSource"
}

extension BlankDataSetProtocol {

    private var blankView: BlankDataSetView? {
        get { objc_getAssociatedObject(self, &AssociatedKeys.blankView) as? BlankDataSetView }
        set { objc_setAssociatedObject(self, &AssociatedKeys.blankView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }
    
    private var owner: DataSetWeakOwner? {
        get { objc_getAssociatedObject(self, &AssociatedKeys.dataSetWeakOwner) as? DataSetWeakOwner }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.dataSetWeakOwner, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }
    
    public var blankSetDelegate: BlankDataSetDelegate? {
        get { owner?.blankSetDelegate }
        set {
            createOwner()
            owner?.blankSetDelegate = newValue
        }
    }
    
    public var blankSetDataSource: BlankDataSetDataSource? {
        get { owner?.blankSetDataSource }
        set {
            createOwner()
            owner?.blankSetDataSource = newValue
        }
    }


    private func createOwner() {
        if owner == nil { owner = DataSetWeakOwner() }
    }
    
    public func reloadBlankDataSet() {

        if let blankView = blankView {
            NSLayoutConstraint.deactivate(blankView.constraints)
            blankView.removeFromSuperview()
        } else {
            blankView = BlankDataSetView()
            blankView?.owner = owner
        }

        addSubview(blankView!)

        var offset: CGFloat = 0.0
        if #available(iOS 11.0, *) {
            offset = -safeAreaInsets.top
        } else {
            offset = bounds.minY
        }

        NSLayoutConstraint.activate([
            blankView!.widthAnchor.constraint(equalTo: widthAnchor),
            blankView!.heightAnchor.constraint(equalTo: heightAnchor),
            blankView!.centerXAnchor.constraint(equalTo: centerXAnchor),
            blankView!.centerYAnchor.constraint(equalTo: centerYAnchor, constant: offset)
        ])
        
        bringSubviewToFront(blankView!)
        blankView?.setupConstraints()
        blankView?.setNeedsLayout()
        blankView?.layoutIfNeeded()
        let forcedToDisplay = owner?.blankSetDelegate?.blankDataSetShouldForcedToDisplay() ?? false
        let shouldDisplay = owner?.blankSetDelegate?.blankDataSetShouldDisplay() ?? true
        
        blankView?.isHidden = !(forcedToDisplay || shouldDisplay)
//        blankView?.isUserInteractionEnabled = owner?.blankSetDelegate?.blankDataSetShouldAllowTouch() ?? true
        
        if let scrollView = self as? UIScrollView {
            scrollView.isScrollEnabled = owner?.blankSetDelegate?.blankDataSetShouldAllowScroll() ?? false
        }
    }
}

class DataSetWeakOwner {
    weak var blankSetDelegate: BlankDataSetDelegate?
    weak var blankSetDataSource: BlankDataSetDataSource?
}
