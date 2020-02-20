//
//  HomeCollectionCell.swift
//  MediaCypher-J22
//
//  Created by mac on 2/20/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class HomeCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var homeImage: UIImageView!
    
    static let identifier = String(describing: HomeCollectionCell.self)
    
    var content: Content! {
        didSet {
            //TODO: Get Image
        }
    }
}
