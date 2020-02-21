//
//  FileServiceManager.swift
//  MediaCypher-J22
//
//  Created by mac on 2/20/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation


struct FileServiceManager {
    
    //MARK: SAVE
    static func save(_ data: Data,_ isVideo: Bool) {
        
        let hash = String(data.hashValue)
        let path = isVideo ? hash + ".mov" : hash
        
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(path) else { return }
        
        do {
            try data.write(to: url)
            CoreManager().save(path: path, isMovie: isVideo)
            print("Saved Data to Disk: \(url)")
        } catch {
            print(error.localizedDescription)
            return
        }
    }
    
    
    //MARK: LOAD
    static func load(_ path: String) -> URL? {
        
        let documentDir = FileManager.SearchPathDirectory.documentDirectory
        let domainMask = FileManager.SearchPathDomainMask.userDomainMask
        let urls = NSSearchPathForDirectoriesInDomains(documentDir, domainMask, true)
        
        guard let url = urls.first else { return nil }
        
        return URL(fileURLWithPath: url).appendingPathComponent(path)
    }
    
}
