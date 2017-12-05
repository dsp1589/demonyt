//
//  BookTitlesViewController.swift
//  NowYetTimes
//
//  Created by Dhana S on 12/4/17.
//  Copyright © 2017 Dhana S. All rights reserved.
//

import Foundation

class BookTitlesViewController: UIViewController {
    
    var bookType : Books!{
        didSet{
            updateUI()
        }
    }
    
    var updateBookOfTypeResponse : ((String, BooksOfTypeResponse, Bool) -> Void)?
    var updateList : ((String) -> ())?
    
    @IBOutlet weak var  bookTypeTitleLabel : UILabel!
    
    @IBOutlet weak var newPublishedDate: UILabel!
    @IBOutlet weak var oldPublishedDate: UILabel!
    static let SB_ID = "bookTitlesViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let _ = self.bookType.reponse else{
            getBooksOfType(currentType: bookType.list_name_encoded!)
            return
        }
        if let updateListClosure = updateList{
            updateListClosure(bookType.list_name_encoded!)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let updateListClosure = updateList{
            updateListClosure(bookType.list_name_encoded!)
        }
        
    }
    
    func getBooksOfType(currentType : String){
        BooksService.init(section: "/books").getBooksOfType(encodedName: currentType, successCallBack: { (response) in
            if let closure = self.updateBookOfTypeResponse{
                self.bookType.reponse = response["Response"]!
                closure(currentType, response["Response"]!,true)
                if let updateListClosure = self.updateList{
                    updateListClosure(self.bookType.list_name_encoded!)
                }
            }
        }, failureCallBack: { (error) in
        })
    }
    func updateUI(){
        DispatchQueue.main.async {
            self.bookTypeTitleLabel.text = self.bookType.display_name
            self.oldPublishedDate.text = self.bookType.oldest_published_date
            self.newPublishedDate.text = self.bookType.newest_published_date
        }
    }

    
}
