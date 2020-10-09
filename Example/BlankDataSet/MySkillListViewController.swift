//
//  MySkillListViewController.swift
//  Luobo
//
//  Created by 蔡志文 on 2020/10/9.
//  Copyright © 2020 didong. All rights reserved.
//

import UIKit

class MySkillListViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = UIColor.white
        view.dataSource = self
        view.delegate = self
        view.blankSetDataSource = self
        view.blankSetDelegate = self
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNav()
        initView()
    }
    
    func initNav() {
        title = "我的技能"
    }
    
    func initView() {
        collectionView.frame = view.bounds
//        collectionView.register(UICollectionViewCell.nib, forCellWithReuseIdentifier: MySkillListCell.identifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        view.addSubview(collectionView)
    }
}

extension MySkillListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        cell.backgroundColor = UIColor.blue
        return cell
    }
    
    
}

extension MySkillListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.bounds.width - 30, height: 84)
    }
}


extension MySkillListViewController: BlankDataSetDataSource {
    func imageForBlankDataSet() -> UIImage? {
        UIImage(named: "img_kong")
    }
    
    func titleForBlankDataSet() -> BlankTextConfiguration? {
        .normal("还未添加技能标签", UIColor.black, UIFont.systemFont(ofSize: 18, weight: .medium))
    }
    
    func detailForBlankDataSet() -> BlankTextConfiguration? {
        .normal("快去添加技能，获取更多任务吧！", UIColor.lightGray, UIFont.systemFont(ofSize: 14))
    }
    
    func buttonForBlankDataSet() -> BlankButtonConfiguration? {
        BlankButtonConfiguration(titleConfiguration: .normal("添加技能", .white, UIFont.systemFont(ofSize: 18, weight: .medium)), backgroundColor: UIColor.red, cornerRadius: 4, size: CGSize(width: view.bounds.width - 30, height: 44))
    }
}

extension MySkillListViewController: BlankDataSetDelegate {
    func blankDataSetDidTapButton() {
        print("dddd")
    }
    
    func verticalSpacesForBlankDataSetItems() -> [CGFloat] {
        [13, 5, 37]
    }
}
