//
//  NewsContentTableCellCell.swift
//  NowYetTimes
//
//  Created by Dhana S on 12/2/17.
//  Copyright © 2017 Dhana S. All rights reserved.
//

import Foundation

protocol UserActionOnNewsDelegate : class {
    func userActionOnNews(action : UserActionOnNews, url : String)
}

enum UserActionOnNews : Int{
    case shareNow = 0
    case openInWeb
}

class NewsContentTableCellCell: UITableViewCell {
    static let Cell_ID = "sectionTypeTitleAndSubTitle"
    
    @IBOutlet weak var titleHeaderCell: UILabel!
    @IBOutlet weak var thumbNailImage: UIImageView!
    
    @IBOutlet weak var subTitleContentCell: UILabel!
    @IBOutlet weak var openInWebButton: UIBarButtonItem!
    @IBOutlet weak var newsToolBar: UIToolbar!
    
    weak var userActionDelegate : UserActionOnNewsDelegate?
    
    @IBAction func shareNow(_ sender: Any) {
        if let u = forOpenInWebC{
            userActionDelegate?.userActionOnNews(action: .shareNow, url: u)
        }
        
    }
    
    @IBAction func openInSafari(_ sender: Any) {
        if let u = forOpenInWebC{
            userActionDelegate?.userActionOnNews(action: .openInWeb, url: u)
        }
    }
    
    var forOpenInWebC : String?{
        didSet{
            guard let _ = forOpenInWebC else{
                for item in newsToolBar.items! {
                    if item.tag == 30{
                        item.isEnabled = false
                    }
                }
                return
            }
        }
    }
}

protocol NewsContentSectionHeaderDelegate : class {
    func changeContentFilter(contentTypeClicked : Bool, periodClicked : Bool)
}

class NewsContentSectionHeaderTableCellCell: UITableViewCell {
    
    weak var delegate : NewsContentSectionHeaderDelegate?
    
    @IBAction func contentTypeClicked(_ sender: Any) {
        delegate?.changeContentFilter(contentTypeClicked: true, periodClicked: false)
    }
    
    @IBAction func periodClicked(_ sender: Any) {
        delegate?.changeContentFilter(contentTypeClicked: false, periodClicked: true)
    }
    @IBOutlet weak var contentTypeButton: UIButton!
    @IBOutlet weak var periodButton: UIButton!
    
    
    
    static let Cell_ID = "secHeader"
}
