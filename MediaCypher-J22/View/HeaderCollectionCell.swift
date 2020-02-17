//
//  HeaderCollectionCell.swift
//  MediaCypher-J22
//
//  Created by mac on 2/17/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class HeaderCollectionCell: UICollectionViewCell {

    @IBOutlet weak var headerPasswordLabel: UILabel!
    
    static let identifier = "HeaderCollectionCell"
    
    var code: String! {
        didSet {
            headerPasswordLabel.text = code
        }
    }
    
}
