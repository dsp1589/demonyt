//
//  AboutBookTableCell.swift
//  NowYetTimes
//
//  Created by Dhana S on 12/4/17.
//  Copyright © 2017 Dhana S. All rights reserved.
//

import Foundation

protocol SaveBookDelegate : class {
    func saveBook(book : AboutBook)
}

class AboutBookTableCell: UITableViewCell {
    static let CELL_ID = "AboutBookTableCell"
    
    @IBOutlet weak var booktitleName : UILabel!
    @IBOutlet weak var rankLabel : UILabel!
    @IBOutlet weak var priceButton : UIButton!
    
    @IBOutlet weak var debugL: UILabel!
    
    weak var saveDelegate : SaveBookDelegate?
    
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
//                if let price = ab.book_details?.first?.price{
//                    priceButton.setTitle("\(price)", for: .normal)
//                }else{
//                    priceButton.setTitle("N/A", for: .normal)
//                }
                if let isbn = aboutBook.isbns?.first?.isbn13{
                    priceButton.setTitle( AppUtils.isBookSaved(isbn_13: isbn) ? "SAVED" : "SAVE", for: .normal)
                }else{
                     priceButton.setTitle("SAVE", for: .normal)
                }
                

                debugL.text = ab.list_name
                debugL.alpha = 0.0
                
            }
        }
    }
    @IBAction func saveBook(_ sender: UIButton) {
        if aboutBook.isbns?.first?.isbn13 != nil{
            saveDelegate?.saveBook(book: aboutBook)
        }
        priceButton.setTitle("SAVED", for: .normal)
    }
    
}
