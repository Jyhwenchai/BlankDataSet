//
//  UICollectionView+Ex.swift
//  BlankKit
//
//  Created by 蔡志文 on 2020/8/27.
//

import UIKit

extension UICollectionView: BlankDataSetProtocol {

    private enum AssociatedKeys {
        static var fixedSafeAreaInsets = "fixedSafeAreaInsets"
    }
    
    private var fixedSafeAreaInsets: Bool {
        get { objc_getAssociatedObject(self, &AssociatedKeys.fixedSafeAreaInsets) as? Bool ?? false }
        set { objc_setAssociatedObject(self, &AssociatedKeys.fixedSafeAreaInsets, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    
    static func configure() {
        let originalSeletor = #selector(reloadData)
        let swizzledSelector = #selector(swizzledReloadData)
        Swizzler.swizzleMethods(for: self, originalSelector: originalSeletor, swizzledSelector: swizzledSelector)
        
        let a = #selector(layoutSubviews)
        let b = #selector(swizledLayoutSubviews)
        Swizzler.swizzleMethods(for: self, originalSelector: a, swizzledSelector: b)
    }

    @objc private func swizzledReloadData() {
        swizzledReloadData()
        
        guard let _ = blankSetDataSource else { return }
        if fixedSafeAreaInsets {
            if let blankSetDelegate = blankSetDelegate, !blankSetDelegate.blankDataSetShouldForcedToDisplay(), numberOfItems > 0 {
                blankView?.removeFromSuperview()
                blankView = nil
                return
            }
            reloadBlankDataSet()
        }
    }
    
    @objc private func swizledLayoutSubviews() {
        swizledLayoutSubviews()
        
        guard let _ = blankSetDataSource else { return }
        if !fixedSafeAreaInsets {
            if let blankSetDelegate = blankSetDelegate, blankSetDelegate.blankDataSetShouldForcedToDisplay() {
                reloadBlankDataSet()
            } else if numberOfItems == 0 {
                reloadBlankDataSet()
            }
            fixedSafeAreaInsets = true
        }
    }
}

extension UICollectionView {
    private var numberOfItems: Int {
        guard let dataSource = dataSource else { return 0 }
        let sections = dataSource.numberOfSections?(in: self) ?? 0
        
        var rows = 0
        for index in 0..<sections {
            rows += dataSource.collectionView(self, numberOfItemsInSection: index)
        }
        return rows
    }
}
