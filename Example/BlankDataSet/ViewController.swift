//
//  ViewController.swift
//  BlankKit
//
//  Created by 蔡志文 on 2020/8/25.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.blankSetDataSource = self
        tableView.blankSetDelegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    @IBAction func update(_ sender: Any) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = "item \(indexPath.row)"
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIButton()
        view.setTitle("heheh", for: .normal)
        view.backgroundColor = .red
        view.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    @objc func buttonAction() {
        print("button Action")
    }
}


extension ViewController: BlankDataSetDataSource {
    func imageForBlankDataSet() -> UIImage? {
        return UIImage(named: "candidate_icon_noresult")
    }
    
    func titleForBlankDataSet() -> BlankTextConfiguration? {
        return .normal("t's a lot of bold (as in many of yourt's a lot of bold (as in many of your", UIColor.red, UIFont.systemFont(ofSize: 15))
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
    
//    func customViewForBlankDataSet() -> UIView? {
//        let e = EmptyView()
//        e.backgroundColor = UIColor.blue
//        return e
//    }
}

extension ViewController: BlankDataSetDelegate {
    func blankDataSetDidTapView() {
        print("tap view")
    }
    
    func blankDataSetDidTapButton() {
        print("tap button")
    }
    
}
