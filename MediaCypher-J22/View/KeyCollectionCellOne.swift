//
//  KeyCollectionCellOne.swift
//  MediaCypher-J22
//
//  Created by mac on 2/17/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class KeyCollectionCellOne: UICollectionViewCell {
    
    @IBOutlet weak var keyNumberLabel: UILabel!
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .transGray : .clear
        }
    }
    
    static let identifier = "KeyCollectionCellOne"
    
    var number: String! {
        didSet {
            keyNumberLabel.text = number
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderWidth = 3
        layer.borderColor = UIColor.systemBlue.cgColor
        layer.cornerRadius = frame.height / 2
    }
    
}
