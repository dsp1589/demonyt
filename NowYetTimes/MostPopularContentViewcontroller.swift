//
//  MostPopularContentViewcontroller.swift
//  NowYetTimes
//
//  Created by Dhana S on 12/3/17.
//  Copyright © 2017 Dhana S. All rights reserved.
//

import Foundation
import SafariServices

class MostPopularContentViewcontroller: UIViewController {
    
    static let SB_ID = "mostPopularContentViewcontroller"
    
    @IBOutlet weak var periodsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var mostPopularStories : Dictionary<String,MostPopularStoriesResponse> =
        Dictionary<String,MostPopularStoriesResponse> (){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var currentPeriod : String = "1"
    var contentsType : String = "all-sections"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100.0
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorInset = UIEdgeInsetsMake(0, 3000, 0, 0)
        periodsSegmentedControl.addTarget(self, action: #selector(periodChanged(sender:)), for: .valueChanged)
       getMostPopStories(period: currentPeriod, mode:getMode(),contentType: contentsType)
    }
    
    func getMode() -> String{
        switch periodsSegmentedControl.selectedSegmentIndex{
        case 0:
            return  "mostshared"
        case 1:
            return "mostemailed"
        case 2:
            return "mostviewed"
        default:
            //NA, #visit refactor required
            break
        }
        return ""//Impossible case,
    }
    
    func refreshMostPopularDetails(){
        updateMostPopularStoriesWith(menu : contentsType)
    }
    
    func updateMostPopularStoriesWith(menu : String){
        contentsType = menu
        let mode = getMode()
        
        getMostPopStories(period: currentPeriod, mode: mode, contentType: menu)
    }
    
    @objc func periodChanged(sender : Any){
        refreshMostPopularDetails()
    }
    
    func getMostPopStories(period : String, mode: String, contentType: String){
        currentPeriod = period
        MostPopularStoriesService.init(section: period, successCallBack: { (response) in
            if let res = response["Response"], let results = res.results, results.count > 0{
                self.mostPopularStories[period] = res
            }else{
                self.mostPopularStories[period] = nil
            }
        }) { (error) in
            
            }.getMostPopularStories(mode: mode,contentType: contentType)
    }
    
    func showActionSheetForPeriodSelection(){
        let alert = UIAlertController.init(title: "Choose Time Period", message: "Select the time period to filter results", preferredStyle: .actionSheet)
        
        let actionDay = UIAlertAction(title: "Today", style: .default) { (actionForOneDayToday) in
            self.currentPeriod = "1"
            self.refreshMostPopularDetails()
        }
        let actionWeek = UIAlertAction(title: "1 Week", style: .default) { (actionForWeek) in
            self.currentPeriod = "7"
            self.refreshMostPopularDetails()
        }
        let actionMonth = UIAlertAction(title: "1 Month", style: .default) { (actionForMonth) in
            self.currentPeriod = "30"
            self.refreshMostPopularDetails()
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) { (actionForMonth) in
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(actionDay)
        alert.addAction(actionWeek)
        alert.addAction(actionMonth)
        
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
    }
}

extension  MostPopularContentViewcontroller : UITableViewDataSource{
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mostPopularStories[currentPeriod]?.results?.count ?? 0
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let c = tableView.dequeueReusableCell(withIdentifier: NewsContentTableCellCell.Cell_ID, for: indexPath)
        c.selectionStyle = .none
        if let res = mostPopularStories[currentPeriod]?.results{
            (c as! NewsContentTableCellCell).titleHeaderCell.text = res[indexPath.row].title ?? "--"
            (c as! NewsContentTableCellCell).subTitleContentCell.text = res[indexPath.row].abstract ?? "--"
            (c as! NewsContentTableCellCell).forOpenInWebC = res[indexPath.row].url
            (c as! NewsContentTableCellCell).userActionDelegate = self
            if let mm = res[indexPath.row].media?.first(where: { (mm) -> Bool in
               
                return mm.type == "image" && mm.subtype == "photo"
                
            }){
                if let mediaWHCheck = mm.mediaMetadata, let found = mediaWHCheck.first(where: { (metaD) -> Bool in
                    return metaD.height == 75 && metaD.width == 75 && metaD.url != nil
                }), let url = found.url ,let u = URL(string : url){
                 (c as! NewsContentTableCellCell).thumbNailImage.sd_setImage(with: u, completed: nil)
                }
            }
        }
        return c
    }
    
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //        cell.contentView.setNeedsDisplay()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            let v = tableView.dequeueReusableCell(withIdentifier: NewsContentSectionHeaderTableCellCell.Cell_ID) as! NewsContentSectionHeaderTableCellCell
            v.delegate = self
            v.contentTypeButton.setTitle(contentsType, for: .normal)
            v.periodButton.setTitle(currentPeriod == "1" ? "Today" : currentPeriod == "7" ? "1 Week" : "1 Month", for: .normal)
            return v
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
}
extension  MostPopularContentViewcontroller : UITableViewDelegate{
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}


extension MostPopularContentViewcontroller : NewsContentSectionHeaderDelegate{
    func changeContentFilter(contentTypeClicked : Bool, periodClicked : Bool){
        if(contentTypeClicked){
            (parent as? MainLandingViewController)?.showMenuDelegate?.revealMenu()
        }else{
            showActionSheetForPeriodSelection()
        }
    }
}

extension MostPopularContentViewcontroller : UserActionOnNewsDelegate{
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
