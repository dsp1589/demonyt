//
//  HomeViewController.swift
//  NowYetTimes
//
//  Created by Dhana S on 12/1/17.
//  Copyright © 2017 Dhana S. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    var bookResponse : BookNamesResponse?
    
    let kMainLandingSeque = "mainLanding"
    let kBookSeque = "books"
    let kPadding32 : CGFloat = 32.0
    var selectedMenu : Int = 0
    var savedItemAvailable  = false
    
    @IBOutlet weak var collectionView: UICollectionView!
    let collFlowLayout = UICollectionViewLayout()
    override func viewDidLoad() {
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        //always fill the view
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.insertSubview(blurEffectView, at: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let savedBookscount = AppUtils.savedBooks()?.count, savedBookscount > 0{
            savedItemAvailable = true
            collectionView.reloadData()
        }else{
            savedItemAvailable = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kMainLandingSeque{
            if selectedMenu == 0{
                (segue.destination as? MenuAndContentHandlerController)?.forMenu = .TopStories
            }else if selectedMenu == 1{
                (segue.destination as? MenuAndContentHandlerController)?.forMenu = .MostPopular
            }
        }else if segue.identifier == kBookSeque{
            (segue.destination as? BooksViewController)?.titles = (sender as? [Books])!
        }
    }
    
    func performSegueForMenu(id : Int, sender : Any?){
        switch id {
        case 0:
            performSegue(withIdentifier: kMainLandingSeque, sender: nil)
            break
        case 1:
            performSegue(withIdentifier: kMainLandingSeque, sender: nil)
            break
        case 2:
            performSegue(withIdentifier: kBookSeque, sender: sender)
            break
        default:
            break
        }
        
    }
    
}


extension HomeViewController{
    func getBooksAndNavigateTo(){
        BooksService.init(section: "/books", successCallBack: { (response) in
            if let respWithResults = response["Response"], let arrofBooks = respWithResults.results, arrofBooks.count > 0{
                self.bookResponse = respWithResults
                DispatchQueue.main.async {
                self.performSegueForMenu(id: 2, sender: arrofBooks)
                }
            }
        }) { (error) in
            
        }.getListOfBooks()
    }
}

extension HomeViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedMenu = indexPath.row
        switch indexPath.row {
        case 2:
            guard let available = bookResponse else {
            getBooksAndNavigateTo()
                return
            }
            performSegueForMenu(id: indexPath.row, sender: available.results)
            break
        default:
            performSegueForMenu(id: indexPath.row, sender: nil)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let c = kHomeMenu[indexPath.row]
        (cell as? HomeCollectionCell)?.titleLabel.text = c
        (cell as? HomeCollectionCell)?.imageView.image = UIImage(named:c)
    }
}

extension HomeViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cWidth = collectionView.frame.width
        let h = cWidth / 2 - kPadding32 + 68
        return CGSize(width: cWidth/2, height: h)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
}

extension HomeViewController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kHomeMenu.count - (savedItemAvailable ? 0 : 1)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionCell.Cell_Id, for: indexPath)
    }
}
