//
//  SavedBooksCell.swift
//  NowYetTimes
//
//  Created by Dhana S on 12/6/17.
//  Copyright © 2017 Dhana S. All rights reserved.
//

import Foundation

protocol BuyBookClicked : class {
    func buyClicked(url : String?)
}

class SavedBooksCell: UITableViewCell {
    
    weak var buyDelegate : BuyBookClicked?
    
    var savedBook : [String:String]?{
        didSet{
            titleLabel.text = savedBook?["title"]
            descLabel.text = savedBook?["desc"]
            authorLabel.text = savedBook?["author"]

        }
    }
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var descLabel : UILabel!
    @IBOutlet weak var authorLabel : UILabel!
    @IBOutlet weak var buy : UIButton!
    
    @IBAction func buy(_ sender : Any){
        buyDelegate?.buyClicked(url: savedBook?["amazon_url"])
    }
    
}
