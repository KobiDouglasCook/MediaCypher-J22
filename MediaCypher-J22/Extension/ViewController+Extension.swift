//
//  ViewController+Extension.swift
//  MediaCypher-J22
//
//  Created by mac on 2/20/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

extension UIViewController {
    
    
    func goToNext() {
        let homeNav = storyboard?.instantiateViewController(identifier: "HomeNav") as! UINavigationController
        present(homeNav, animated: true, completion: nil)
    }
    
    func showAlert(_ title: String?, _ message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alert.addAction(okayAction)
        present(alert, animated: true, completion: nil)
    }
    
}
