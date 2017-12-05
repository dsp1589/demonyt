//
//  NowYetTimesMainLandingDelegates.swift
//  NowYetTimes
//
//  Created by Dhana S on 12/1/17.
//  Copyright © 2017 Dhana S. All rights reserved.
//

import Foundation



protocol RevealMenuDelegate {
    func revealMenu()
    func goToHome()
}

protocol MenuSelectedDelegate {
    func showNewsFor(menu : String)
}

protocol OpenInWebControllerDelegate {
    func openLinkInWebBController(url : String)
}
