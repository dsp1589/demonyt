//
//  TopStoriesTableViewController.swift
//  NowYetTimes
//
//  Created by Dhana S on 12/2/17.
//  Copyright © 2017 Dhana S. All rights reserved.
//

import Foundation
import SafariServices
import SDWebImage

class TopStoriesTableViewController: UITableViewController {
    
static let SB_ID = "topStoriesTableViewController"
    
    var currentSection = "home"
    var topStories : Dictionary<String,TopStoriesResponse> = Dictionary<String,TopStoriesResponse>(){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
                if let headerView = self.tableView.tableHeaderView as? UILabel{
                    headerView.text = self.topStories[self.currentSection]?.section?.capitalized
                }
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100.0
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorInset = UIEdgeInsetsMake(0, 3000, 0, 0)
        getTopStories(sec: "home")
    }
    
    func getTopStories(sec : String){
        currentSection = sec
        if self.topStories[sec] == nil{
            TopStoriesService.init(section: sec, successCallBack: { (response) in
                self.topStories[sec] = response["Response"]
            }) { (errpr) in
                
                }.getTopStories()
        }else{
            self.tableView.reloadData()
        }
        
    }

}


extension  TopStoriesTableViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topStories[currentSection]?.results?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let c = tableView.dequeueReusableCell(withIdentifier: NewsContentTableCellCell.Cell_ID, for: indexPath)
        c.selectionStyle = .none
        if let res = topStories[currentSection]?.results{
            (c as! NewsContentTableCellCell).titleHeaderCell.text = res[indexPath.row].title ?? "--"
            (c as! NewsContentTableCellCell).subTitleContentCell.text = res[indexPath.row].abstract ?? "--"
            (c as! NewsContentTableCellCell).forOpenInWebC = res[indexPath.row].url
            (c as! NewsContentTableCellCell).userActionDelegate = self
            if let mm = res[indexPath.row].multimedia?.first(where: { (mm) -> Bool in
                return (mm.width == 75 && mm.height == 75 && mm.url != nil)
            }){
                if let  u = URL(string : mm.url!){
                    (c as! NewsContentTableCellCell).thumbNailImage.sd_setImage(with: u, completed: nil)
                }
            }
        }
        return c
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.contentView.setNeedsDisplay()
    }
    
    
}
extension  TopStoriesTableViewController{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension TopStoriesTableViewController : UserActionOnNewsDelegate{
    func userActionOnNews(action: UserActionOnNews, url: String) {
        switch action {
        case .openInWeb:
            if let u = URL(string : url){
                let svc = SFSafariViewController(url: u)
//                self.view.window?.rootViewController?
                    self.present(svc, animated: true, completion: nil)
            }
            break
        case .shareNow:
            //Out of scope for now
            break
        }
    }
}
