//
//  DataStorage.swift
//  DemoRestfulApi
//
//  Created by PujieLee on 2022/9/25.
//

import Foundation

//暫存登入資料
class LoginDataStorage {
    static let sharedInstance = LoginDataStorage()
    
    var loginData: LoginRepo?
    
    private init() {
        
    }
}
