//
//  UITableView+Ex.swift
//  BlankKit
//
//  Created by 蔡志文 on 2020/8/26.
//

import UIKit

extension UITableView: BlankDataSetProtocol {

    static func configure() {
        let originalSeletor = #selector(reloadData)
        let swizzledSelector = #selector(swizzledReloadData)
        Swizzler.swizzleMethods(for: self, originalSelector: originalSeletor, swizzledSelector: swizzledSelector)
    }

    @objc private func swizzledReloadData() {
        swizzledReloadData()
        guard let _ = blankSetDataSource else { return }
        if let blankSetDelegate = blankSetDelegate, !blankSetDelegate.blankDataSetShouldForcedToDisplay(), numberOfItems > 0 {
            blankView?.removeFromSuperview()
            blankView = nil
            return
        }
        reloadBlankDataSet()
        if let blankView = blankView {
            sendSubviewToBack(blankView)
        }
    }
}

extension UITableView {
    private var numberOfItems: Int {
        guard let dataSource = dataSource else { return 0 }
        let sections = dataSource.numberOfSections?(in: self) ?? 0
        var rows = 0
        for index in 0..<sections {
            rows += dataSource.tableView(self, numberOfRowsInSection: index)
        }
        return rows
    }
}
