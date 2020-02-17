//
//  KeyCollectionCellTwo.swift
//  MediaCypher-J22
//
//  Created by mac on 2/17/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class KeyCollectionCellTwo: UICollectionViewCell {
    
    @IBOutlet weak var keyIconImage: UIImageView!
    
    static let identifier = "KeyCollectionCellTwo"
    
    var icon: UIImage! {
        didSet {
            keyIconImage.image = icon
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupKeyCellTwo()
    }
    
    
    private func setupKeyCellTwo() {
        keyIconImage.translatesAutoresizingMaskIntoConstraints = false //allows programmatic constraints
        keyIconImage.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        keyIconImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        keyIconImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        keyIconImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
    }
    
}
