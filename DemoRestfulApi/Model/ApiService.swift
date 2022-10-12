//
//  ApiService.swift
//  DemoRestfulApi
//
//  Created by PujieLee on 2022/9/22.
//

import Foundation

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    //MARK: Users
    func getUser(id: String, completion: @escaping (Result<UserRepo>) -> Void){
        
        let paramaters = ["id": id]
        
        WebService.sharedInstance.httpRequest("User", method: .get, paramaters: paramaters){ result in
            completion(result)
        }
    }
    
    func postLogin(username: String, password: String, completion: @escaping (Result<LoginRepo>) -> Void){
        
        
        let paramaters = ["username": username,
                          "password": password]
        
        WebService.sharedInstance.httpRequest("UserLogin", method: .post, paramaters: paramaters){ result in
            completion(result)
        }
    }
    /*
     註1：GET User回傳值
     {
         "id" : "1",
         "name" : "PuJie Lee",
         "level" : 3,
         "phone" : "0921913333",
         "area" : "Taiwan",
         "habit" : "Movies",
         "like" : "Coffee",
         "specialmoves" : ["iOS_Developer","UI_Designer"]
     }
     
     註2：POST UserLogin回傳值
     {
         "id" : "1",
         "name" : "PuJie Lee",
         "level" : 3,
         "phone" : "0921913333",
         "sessionToken" : "koUSxiEujIqAjQ2pRPBhULwJlbM0JcLi9qMFN2qgC7YnRba6"
     }
     */
}
