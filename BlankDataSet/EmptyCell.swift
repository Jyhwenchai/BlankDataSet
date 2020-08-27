//
//  EmptyCell.swift
//  BlankKit
//
//  Created by 蔡志文 on 2020/8/27.
//

import UIKit

class EmptyCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        blankSetDataSource = self
        reloadBlankDataSet()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension EmptyCell: BlankDataSetProtocol {}
extension EmptyCell: BlankDataSetDataSource {
    func imageForBlankDataSet() -> UIImage? {
        return UIImage(named: "candidate_icon_noresult")
    }
    
    func titleForBlankDataSet() -> BlankTextConfiguration? {
        return .normal("Click me", UIColor.red, UIFont.systemFont(ofSize: 15))
    }
}

