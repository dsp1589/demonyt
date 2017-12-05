//
//  MenuCell.swift
//  NowYetTimes
//
//  Created by Dhana S on 12/1/17.
//  Copyright © 2017 Dhana S. All rights reserved.
//

import Foundation
import UIKit


class MenuCell: UITableViewCell {
    
    static let Cell_ID = "menuCell"
    
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var menuTitle: UILabel!
    
    override var isSelected: Bool{
        didSet{
            if isSelected{
                
            }else{
                
            }
        }
    }
}
