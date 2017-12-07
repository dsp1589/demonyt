//
//  BooksTableViewController.swift
//  NowYetTimes
//
//  Created by Dhana S on 12/3/17.
//  Copyright © 2017 Dhana S. All rights reserved.
//

import Foundation


class BooksViewController : UIViewController{
    var titles : [Books]?
    var currentType : String?{
        didSet{
            DispatchQueue.main.async {
                self.booksListView.reloadData()
            }
        }
    }
    
    var updateBookOfTypeResponse : ((String, BooksOfTypeResponse,Bool) -> Void)?
    
    @IBOutlet weak var booksListView: UITableView!
    
    @IBOutlet weak var containerView: UIView!
    static let SB_ID = "booksTableViewController"
    var pageViewController : UIPageViewController?
    
    @IBAction func goBankTohome(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let vc = (childViewControllers.first as? UIPageViewController){
            pageViewController = vc
            pageViewController?.delegate = self
            pageViewController?.dataSource = self
            pageViewController?.isDoubleSided = true
            let initViewcontroller = getViewController(index: 0)
            pageViewController?.setViewControllers([initViewcontroller], direction: .forward, animated: true, completion: { (complted) in
            })
        }
        booksListView.delegate = self
        booksListView.dataSource = self
        booksListView.rowHeight = UITableViewAutomaticDimension
        booksListView.estimatedRowHeight = 100.0
        booksListView.tableFooterView = UIView(frame: .zero)
        booksListView.separatorInset = UIEdgeInsetsMake(0, 3000, 0, 0)
    }
    
    func getViewController(index : Int) -> UIViewController{
        let viewController = storyboard?.instantiateViewController(withIdentifier: BookTitlesViewController.SB_ID) as! BookTitlesViewController
        viewController.loadViewIfNeeded()
        viewController.bookType = titles![index]
        if viewController.bookType.reponse == nil{
            viewController.updateBookOfTypeResponse = {(currentType,response,update) in
                if update{
                    self.updateBooksListWithResponse(currentType: currentType, response: response)
                }
            }
        }else{
            viewController.updateBookOfTypeResponse = nil
        }
        viewController.updateList = { (s) in
            self.currentType = s
        }
        viewController.view.tag = index
        return viewController
    }
    
    func updateBooksListWithResponse(currentType : String, response : BooksOfTypeResponse){
        for (index,value) in titles!.enumerated(){
            if value.list_name_encoded == currentType{
                titles![index].reponse = response
                break
            }
        }
    }
}

extension BooksViewController : SaveBookDelegate{
    func saveBook(book: AboutBook) {
        var toBeSavedDate = Dictionary<String,String>()
        toBeSavedDate["amazon_url"] = book.amazon_product_url
        toBeSavedDate["isbns_13"] = book.isbns?.first?.isbn13
        toBeSavedDate["title"] = book.book_details?.first?.title
        toBeSavedDate["desc"] = book.book_details?.first?.description
        toBeSavedDate["author"] = book.book_details?.first?.author
        AppUtils.addBook(item: toBeSavedDate)
    }
}

extension BooksViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let c = titles?.first(where: { (b) -> Bool in
            return b.list_name_encoded == currentType
        })?.reponse?.results?.count ?? 0
        return c
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: AboutBookTableCell.CELL_ID) as! AboutBookTableCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let c = cell as? AboutBookTableCell
        if let aboutBooks = titles?.first(where: { (b) -> Bool in
            return b.list_name_encoded == currentType
        })?.reponse?.results{
            c?.aboutBook = aboutBooks[indexPath.row]
        }
        c?.saveDelegate = self
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension BooksViewController : UIPageViewControllerDelegate,
    UIPageViewControllerDataSource{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index: Int = viewController.view.tag
        if index == 0 || index == NSNotFound {
            index = titles!.count
        }
        index = index - 1
        return getViewController(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index: Int = viewController.view.tag
        if index == NSNotFound {
            return nil
        }
        index = index + 1
        if index == self.titles!.count {
            index = 0
        }
        return  getViewController(index: index)
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        pageViewController.viewControllers?.forEach({ (c) in
            print(c.view!.tag)
        })
    }
}
