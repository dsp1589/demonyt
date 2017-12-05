//
//  MenuAndContentHandlerController.swift
//  NowYetTimes
//
//  Created by Dhana S on 12/1/17.
//  Copyright © 2017 Dhana S. All rights reserved.
//

import Foundation
import UIKit

enum ForMenu {
    case TopStories
    case MostPopular
}


class MenuAndContentHandlerController: UIViewController, MenuSelectedDelegate, RevealMenuDelegate {
    var menuRevealed : Bool!
    var firstTimeMenuReveal : Bool = false
    var forMenu : ForMenu = .TopStories
    @IBOutlet var closedMenuConstraint: NSLayoutConstraint!
    
    @IBOutlet var revealedMenuConstraint: NSLayoutConstraint!
    
    var menuListController : MenuListViewController!
    var mainLandingViewController : MainLandingViewController?
   
    
    @IBOutlet weak var mainContainerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        menuRevealed = true
        for vc in childViewControllers{
            if let mlvc = vc as? MenuListViewController{
                mlvc.menuSelectionDelegate = self
                mlvc.forMode = self.forMenu
                menuListController = mlvc
            }else if let mlvc = vc as? MainLandingViewController{
                mlvc.showMenuDelegate = self
                mainLandingViewController = mlvc
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !firstTimeMenuReveal{
            firstTimeMenuReveal = true
            revealMenu()
        }
    }
    
    
    //MARK: Show Menu Delegate
    func showNewsFor(menu: String) {
        if forMenu == .TopStories{
            if let ind = kAllowedSectionInTopStoriesDisplayable.index(of: menu){
                mainLandingViewController?.topStoriesViewController?.getTopStories(sec: kAllowedSectionInTopStories[ind])
            }
        }else{
            mainLandingViewController?.mostPopularViewController?.updateMostPopularStoriesWith(menu : menu)
        }
        menuRevealed = true
        revealMenu()
    }
    
    //MARK:Reveal Menu
    func revealMenu() {
        
        if menuRevealed{
            menuRevealed = false
            NSLayoutConstraint.deactivate([revealedMenuConstraint])
            NSLayoutConstraint.activate([closedMenuConstraint])
        }else{
            menuRevealed = true
            NSLayoutConstraint.deactivate([closedMenuConstraint])
            NSLayoutConstraint.activate([revealedMenuConstraint])
        }
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.6, options: .curveEaseOut, animations: {
        self.view.layoutIfNeeded()
        }, completion: {completed in

        })
    }
    
    func goToHome() {
        if let popToVc = navigationController?.viewControllers.first(where: { (vc) -> Bool in
            return vc is HomeViewController
        }){
            navigationController?.popToViewController(popToVc, animated: true)
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainLandings"{
            (segue.destination as? MainLandingViewController)?.forMenu = forMenu
        }else if segue.identifier == "mainMenuList"{
            (segue.destination as? MenuListViewController)?.forMode = forMenu
        }
    }
    
}
