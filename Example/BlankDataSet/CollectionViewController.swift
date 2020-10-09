//
//  CollectionViewController.swift
//  BlankKit
//
//  Created by 蔡志文 on 2020/8/27.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.blankSetDataSource = self
        collectionView.blankSetDelegate = self
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 300
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.red
        // Configure the cell
    
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("-----")
    }

}
//
extension CollectionViewController: BlankDataSetDataSource {
    
    func imageForBlankDataSet() -> UIImage? {
        return UIImage(named: "candidate_icon_noresult")
    }
    
    func titleForBlankDataSet() -> BlankTextConfiguration? {
        return .normal("Click me", UIColor.red, UIFont.systemFont(ofSize: 15))
    }
    
    func detailForBlankDataSet() -> BlankTextConfiguration? {
        let text = "Hi Joe – thanks for your comments,\nthat's a lot of bold (as in many of your other comments!)\n As I stated in reply to your answer,"
        return .normal(text, UIColor.red, UIFont.systemFont(ofSize: 15))
    }
    
    func buttonForBlankDataSet() -> BlankButtonConfiguration? {
        return BlankButtonConfiguration(
            titleConfiguration: .normal("title", UIColor.systemBlue, UIFont.systemFont(ofSize: 15)),
            image: UIImage(named: "address_icon_trashred"),
            backgroundColor: UIColor.green,
            borderWidth: 1,
            borderColor: UIColor.systemBlue,
            cornerRadius: 22,
            titleImageSpace: 10,
            size: CGSize(width: view.bounds.width - 30, height: 44))
    }
    
    func verticalSpacesForBlankDataSetItems() -> [CGFloat] {
        [10, 30, 60]
    }
}


extension CollectionViewController: BlankDataSetDelegate {
    func blankDataSetDidTapView() {
        print("tap view")
    }
    
    func blankDataSetDidTapButton() {
        print("tap button")
    }
    
    func blankDataSetShouldAllowScroll() -> Bool {
        true
    }
    
    func blankDataSetShouldForcedToDisplay() -> Bool {
        false
    }
    
    func blankDataSetShouldAllowTouch() -> Bool {
        true
    }
    
}
