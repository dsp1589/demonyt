//
//  AboutBookTableCell.swift
//  NowYetTimes
//
//  Created by Dhana S on 12/4/17.
//  Copyright © 2017 Dhana S. All rights reserved.
//

import Foundation


class AboutBookTableCell: UITableViewCell {
    static let CELL_ID = "AboutBookTableCell"
    
    @IBOutlet weak var booktitleName : UILabel!
    @IBOutlet weak var rankLabel : UILabel!
    @IBOutlet weak var priceButton : UIButton!
    
    @IBOutlet weak var debugL: UILabel!
    var aboutBook : AboutBook!{
        didSet{
            if let ab = aboutBook{
                if let title = ab.book_details?.first?.title{
                    booktitleName.text = title
                }else{
                    booktitleName.text = "N/A"
                }
                
                if let rank = ab.rank{
                    rankLabel.text = "\(rank)"
                }else{
                    rankLabel.text = "N/A"
                }
                if let price = ab.book_details?.first?.price{
                    priceButton.setTitle("\(price)", for: .normal)
                }else{
                    priceButton.setTitle("N/A", for: .normal)
                }
                debugL.text = ab.list_name
                debugL.alpha = 0.0
                
            }
        }
    }
    
}
