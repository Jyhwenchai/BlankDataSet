//
//  TestViewController.swift
//  BlankKit
//
//  Created by 蔡志文 on 2020/8/26.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

//        tableView.blankSetDataSource = self
        
        // Do any additional setup after loading the view.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(EmptyCell.self, forCellReuseIdentifier: "emptyCell")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        tableView.configBlankView()
        if #available(iOS 11.0, *) {
//            print(tableView.next.)
        } else {
            // Fallback on earlier versions
        }
    }

}

extension TestViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        var cell: UITableViewCell!
        if indexPath.row == 3 {
            cell = tableView.dequeueReusableCell(withIdentifier: "emptyCell")
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: identifier)
            cell?.textLabel?.text = "celklk \(indexPath.row)"
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 3 ? 150 : 44
    }
}

extension TestViewController: BlankDataSetDataSource {
    func imageForBlankDataSet() -> UIImage? {
        return nil
    }
    
    func titleForBlankDataSet() -> BlankTextConfiguration? {
        return .normal("Click me", UIColor.red, UIFont.systemFont(ofSize: 15))
    }
    
    func detailForBlankDataSet() -> BlankTextConfiguration? {
//        let text = "Hi Joe – thanks for your comments,\n that's a lot of bold (as in many of your other comments!)\n As I stated in reply to your answer,"
//        return .normal(text, UIColor.red, UIFont.systemFont(ofSize: 15))
        return nil
    }
    
    func buttonForBlankDataSet() -> BlankButtonConfiguration? {
//        return BlankButtonConfiguration(titleConfiguration: .normal("title", UIColor.systemBlue, UIFont.systemFont(ofSize: 15)), size: CGSize(width: view.bounds.width - 30, height: 44))
        return nil
    }
    
    
}
