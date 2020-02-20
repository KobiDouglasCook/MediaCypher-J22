//
//  KeychainItem.swift
//  MediaCypher-J22
//
//  Created by mac on 2/18/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import Security

struct KeychainItem {
    
    /*
     Keychain is saved with keychain items. They are of type CFDictionary and they have 3 main attributes: 1. Access Group (allow share encypted data between apps), 2. Service (App Name), 3. Account (individual keychain item name)
     
     Keychain persists even AFTER app deletion
     */
    
    
    let service = "MediaCypher"
    var account: String!
    
    
    init(_ acct: String) {
        self.account = acct
    }
    
    //MARK: SAVE
    func save(_ password: String) {
        var item = createKeychainItem()
        guard let encoded = password.data(using: .utf8) else { return }
        item[kSecValueData as String] = encoded as AnyObject //set password key
        SecItemDelete(item as CFDictionary)
        SecItemAdd(item as CFDictionary, nil)
        print("Saved Passcode to Keychain: \(password)")
    }
    
    //MARK: LOAD
    func isValid(_ passcode: String) -> Bool {
        var item = createKeychainItem()
        item[kSecReturnAttributes as String] = kCFBooleanTrue //return unencypted
        item[kSecReturnData as String] = kCFBooleanTrue //return as data
        
        var result: AnyObject?
        
        SecItemCopyMatching(item as CFDictionary, &result) //copies the keychain item found
        
        guard let returnedItem = result as? [String:AnyObject], //get back item
            let encoded = returnedItem[kSecValueData as String] as? Data, //get passcode key from item
            let pass = String(data: encoded, encoding: .utf8) else { return false } //decode passcode
    
        print("loaded passcode from Keychain: \(pass == passcode)")
        return pass == passcode
    }
    

    //MARK: Keychain Helper
    private func createKeychainItem() -> [String:AnyObject] {
        
        var item = [String:AnyObject]()
        
        //set item's key for generic password
        item[kSecClass as String] = kSecClassGenericPassword //password type
        //set item's account attribute
        item[kSecAttrAccount as String] = account as AnyObject //user
        //item's service attribute
        item[kSecAttrService as String] = service as AnyObject //MediaCypher
        
        return item
    }
    
    
}
