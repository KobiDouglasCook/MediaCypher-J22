//
//  URL+Extension.swift
//  MediaCypher-J22
//
//  Created by mac on 2/21/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import AVKit

extension URL {
    
    
    var getVideoScreenshot: UIImage? {
        let asset = AVAsset(url: self)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        let timeStamp = CMTime(seconds: 2, preferredTimescale: 1) //2 seconds
        
        do {
            let cgImage = try imageGenerator.copyCGImage(at: timeStamp, actualTime: nil)
            return UIImage(cgImage: cgImage)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
