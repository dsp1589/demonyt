//
//  ViewController.swift
//  NowYetTimes
//
//  Created by Dhana S on 12/1/17.
//  Copyright © 2017 Dhana S. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let kHomeLandingSegue = "homeLanding"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        perform(#selector(pushToMainLanding), with: nil, afterDelay: 2)
    }
    
    @objc func pushToMainLanding(){
        performSegue(withIdentifier: kHomeLandingSegue, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("");
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionFade
        self.navigationController?.view.layer.add(transition, forKey:nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

