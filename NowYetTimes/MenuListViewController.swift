//
//  MenuListViewController.swift
//  NowYetTimes
//
//  Created by Dhana S on 12/1/17.
//  Copyright © 2017 Dhana S. All rights reserved.
//

import Foundation
import UIKit


class MenuListViewController: UITableViewController {
    var forMode : ForMenu = .TopStories
    var menuSelectionDelegate : MenuSelectedDelegate?
    var selectedIndexPath : IndexPath?
    var cols : [UIColor] = [UIColor]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 3000, bottom: 0, right: 0)
        tableView.allowsSelection = true
        tableView.allowsMultipleSelection = false
        buildColors()
        selectedIndexPath = IndexPath(row: 0, section: 0)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch forMode {
        case .MostPopular:
            return kAllowedSectionInMostPopular.count
        case .TopStories:
        return kAllowedSectionInTopStoriesDisplayable.count
        }
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let c =  tableView.dequeueReusableCell(withIdentifier: MenuCell.Cell_ID, for: indexPath)
        let selecView = UIView(frame: c.frame)
        selecView.backgroundColor = UIColor.clear
        c.selectedBackgroundView = selecView
        c.selectionStyle = .none
        return c
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets(top: 0, left: 3000, bottom: 0, right: 0)
        (cell as? MenuCell)?.menuTitle.text = forMode == .TopStories ? kAllowedSectionInTopStoriesDisplayable[indexPath.row] : kAllowedSectionInMostPopular[indexPath.row]
        (cell as? MenuCell)?.backgroundColor = cols[indexPath.row]
        setupBGColor(indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let si = selectedIndexPath, si.row == indexPath.row{
            return 190.0
        }
        return 120.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
       tableView.reloadData()
        tableView.selectRow(at: selectedIndexPath, animated: false, scrollPosition: .none)
        tableView.scrollToRow(at: selectedIndexPath!, at: .middle, animated: false)
        switch forMode {
        case .MostPopular:
            menuSelectionDelegate?.showNewsFor(menu: kAllowedSectionInMostPopular[indexPath.row])
            break
        case .TopStories:
            menuSelectionDelegate?.showNewsFor(menu: kAllowedSectionInTopStories[indexPath.row])
            break
        }
        
    }
    
    func buildColors(){
        switch forMode {
        case .MostPopular:
            kAllowedSectionInMostPopular.forEach { (_) in
                cols.append(Utils.generateRandomPastelColor(withMixedColor: UIColor.black.withAlphaComponent(0.9)))
            }
            break
        case .TopStories:
            kAllowedSectionInTopStoriesDisplayable.forEach { (_) in
                cols.append(Utils.generateRandomPastelColor(withMixedColor: UIColor.black.withAlphaComponent(0.9)))
            }
            break
        }
    }
    
    func setupBGColor(indexPath : IndexPath){
        switch forMode {
        case .MostPopular:
            if indexPath.row == kAllowedSectionInMostPopular.count - 1 {
                tableView.backgroundColor = cols[kAllowedSectionInMostPopular.count-1]
            }else if indexPath.row == 0{
                tableView.backgroundColor = cols[0]
            }
            break
        case .TopStories:
            if indexPath.row == kAllowedSectionInTopStoriesDisplayable.count - 1 {
                tableView.backgroundColor = cols[kAllowedSectionInTopStoriesDisplayable.count-1]
            }else if indexPath.row == 0{
                tableView.backgroundColor = cols[0]
            }
            break
        }
        
    }
    
}
