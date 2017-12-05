//
//  MainLandingViewController.swift
//  NowYetTimes
//
//  Created by Dhana S on 12/1/17.
//  Copyright © 2017 Dhana S. All rights reserved.
//

import Foundation
import UIKit


class MainLandingViewController: UIViewController {
    
    static let StoryBoardSegue = "topStoriesSegue"
    var forMenu : ForMenu = .TopStories
    @IBOutlet weak var newsListTableView: UITableView!
    var showMenuDelegate : RevealMenuDelegate?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainLandingsContainerView: UIView!
    var topStoriesViewController : TopStoriesTableViewController?
    var mostPopularViewController : MostPopularContentViewcontroller?
    //MARK: Actions
    @IBAction func revealMenu(_ sender: Any) {
        showMenuDelegate?.revealMenu()
    }
    @IBAction func goHome(_ sender: Any) {
        showMenuDelegate?.goToHome()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch forMenu {
        case .MostPopular :
            titleLabel.text = "Most Popular"
            mostPopularViewController = storyboard?.instantiateViewController(withIdentifier: MostPopularContentViewcontroller.SB_ID) as? MostPopularContentViewcontroller
            mostPopularViewController?.loadViewIfNeeded()
            mainLandingsContainerView.subviews.forEach({ (v) in
                v.removeFromSuperview()
            })
            mostPopularViewController?.view.frame = mainLandingsContainerView.bounds
            mainLandingsContainerView.addSubview((mostPopularViewController?.view)!)
            self.addChildViewController(mostPopularViewController!)
            break
        case .TopStories :
            titleLabel.text = "Top Stories"
            topStoriesViewController = storyboard?.instantiateViewController(withIdentifier: TopStoriesTableViewController.SB_ID) as? TopStoriesTableViewController
            topStoriesViewController?.loadViewIfNeeded()
            topStoriesViewController?.view.subviews.forEach({ (v) in
                v.removeFromSuperview()
            })
            topStoriesViewController?.view.frame = mainLandingsContainerView.bounds
            mainLandingsContainerView.addSubview((topStoriesViewController?.view)!)
            self.addChildViewController(topStoriesViewController!)
            break
        }
        
        let gestRec = UISwipeGestureRecognizer(target: self, action: #selector(panned(sender:)))
        gestRec.direction = .left
        self.view.addGestureRecognizer(gestRec)
        
        let gestRightPanRec = UISwipeGestureRecognizer(target: self, action: #selector(pannedRight(sender:)))
        gestRightPanRec.direction = .right
        self.view.addGestureRecognizer(gestRightPanRec)
        
    }
    

    
    @objc func panned(sender : UIGestureRecognizer){
        if let mr = parent as? MenuAndContentHandlerController, mr.menuRevealed{
            showMenuDelegate?.revealMenu()
        }
    }
    
    @objc func pannedRight(sender : UIGestureRecognizer){
        if let mr = parent as? MenuAndContentHandlerController, !mr.menuRevealed{
            showMenuDelegate?.revealMenu()
        }
    }
    
}

