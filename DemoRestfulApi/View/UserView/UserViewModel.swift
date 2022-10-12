//
//  UserViewModel.swift
//  DemoRestfulApi
//
//  Created by PujieLee on 2022/9/25.
//

import UIKit

//MARK: data
class UserViewData {
    var isLoading = Observerable<Bool>(value: false)
    var userData = Observerable<UserRepo>(value: UserRepo())
    var networkMessage = Observerable<String>(value: "")
}

//MARK: view module
class UserViewModel {
    private let apiService: ApiService
    
    var viewData: UserViewData
    
    init(apiService: ApiService = ApiService(),
         userViewData: UserViewData = UserViewData()) {
        self.apiService = apiService
        self.viewData = userViewData
    }
    
    func start(){
        getUser()
    }
    
    func getUser(){
        
        viewData.isLoading.value = true
        
        let userId = LoginDataStorage.sharedInstance.loginData?.id ?? ""
        
        //getUser
        ApiService.sharedInstance.getUser(id: userId) { result in
            
            self.viewData.isLoading.value = false
            
            switch result {
            case .success(let responseData):
                self.viewData.userData.value = responseData
                print(responseData)
                
            case .failure(let error):
                self.viewData.networkMessage.value = error ?? "" //訊息顯示到畫面
                print(error ?? "")
            }
        }
    }
    
    func createUserInfomation(_ data: UserRepo) -> String{
        
        var result = "名稱：\(data.name)\n"
        result.append("電話：\(data.phone)\n")
        result.append("地區：\(data.area)\n")
        result.append("興趣：\(data.habit)\n")
        result.append("喜歡的東西：\(data.like)\n")
        result.append("絕招：")
        for i in 0..<data.specialmoves.count {
            let move = data.specialmoves[i]
            
            if i == 0 {
                result.append("\(move)")
            }else{
                result.append("、\(move)")
            }
        }
        
        return result
    }
}
