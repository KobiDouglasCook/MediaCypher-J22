//
//  ViewModel.swift
//  MediaCypher-J22
//
//  Created by mac on 2/20/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

protocol ModelDelegate: class{
    func updateUI()
}

class ViewModel {
    
    var content = [Content](){
        didSet{
            delegate?.updateUI()
        }
    }
    
    var current: Content!
    
    let coreManager = CoreManager()
    weak var delegate: ModelDelegate?
    
    init(){
        reload()
    }
    
    func reload(){
        content = coreManager.load()
    }
    
}
