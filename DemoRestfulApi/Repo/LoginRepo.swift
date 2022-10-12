//
//  LoginRepo.swift
//  DemoRestfulApi
//
//  Created by PujieLee on 2022/9/25.
//

import Foundation

struct LoginRepo: Codable {
    
    var id: String = ""
    var name: String = ""
    var level: Int = 0
    var phone: String = ""
    var sessionToken: String = ""
}
