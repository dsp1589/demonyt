//
//  SaedBooksViewController.swift
//  NowYetTimes
//
//  Created by Dhana S on 12/6/17.
//  Copyright © 2017 Dhana S. All rights reserved.
//

import Foundation


class SavedBooksViewController: UITableViewController, BuyBookClicked {
    
    func buyClicked(url: String?) {
        if let u = url, let formUrl = URL(string: u){
            UIApplication.shared.open(formUrl, options: [:], completionHandler: nil)
        }
    }
    
    static let SB_ID = "SavedBooksViewController"
    
    var savedBooks : [[String:String]]?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Saved Books"
        savedBooks = AppUtils.savedBooks()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 180.0
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewWillDisappear(animated)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedBooks?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let c = tableView.dequeueReusableCell(withIdentifier: "SavedBooksCell", for: indexPath) as! SavedBooksCell
        c.savedBook = savedBooks![indexPath.row]
c.buyDelegate = self
        return c
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.setNeedsDisplay()
        
    }
 
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
