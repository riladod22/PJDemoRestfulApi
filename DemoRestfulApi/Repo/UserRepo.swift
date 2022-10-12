//
//  UserRepo.swift
//  DemoRestfulApi
//
//  Created by PujieLee on 2022/9/28.
//

import Foundation

struct UserRepo: Codable {
    var id: String = ""
    var name: String = ""
    var level: Int = 0
    var phone: String = ""
    var area: String = ""
    var habit: String = ""
    var like: String = ""
    var specialmoves: [String] = []
}

