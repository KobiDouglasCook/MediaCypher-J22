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
            switch content.isVideo {
            case true:
                guard let path = content.path,
                    let url = FileServiceManager.load(path),
                    let screenshot = url.getVideoScreenshot else { return }
                DispatchQueue.main.async {
                    self.homeImage.image = screenshot
                }
                
            case false:
                DispatchQueue.main.async {
                    self.homeImage.image = self.content.getImage
                }
            }
        }
    }
}
