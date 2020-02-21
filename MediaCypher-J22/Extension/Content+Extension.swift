//
//  Content+Extension.swift
//  MediaCypher-J22
//
//  Created by mac on 2/21/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit


extension Content {
    
    var getImage: UIImage? {
        guard let path = self.path,
            let url = FileServiceManager.load(path),
            let data = try? Data(contentsOf: url) else {return nil}
        return UIImage(data: data)
    }
    
}
