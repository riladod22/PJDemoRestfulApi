//
//  LoginViewModel.swift
//  DemoRestfulApi
//
//  Created by PujieLee on 2022/9/25.
//

import UIKit

//MARK: data
class LoginViewData {
    var isLoading = Observerable<Bool>(value: false)
    
    var inputedLoginAccount: String = ""
    var inputedLoginPassword: String = ""
}

//MARK: view module
class LoginViewModel {
    private let apiService: ApiService
    
    var viewData: LoginViewData
    
    init(apiService: ApiService = ApiService(),
         loginViewData: LoginViewData = LoginViewData()) {
        self.apiService = apiService
        self.viewData = loginViewData
    }
    
    func start(){
        //..
    }
    
    func runLogin(completion: @escaping(EventResult<String>) -> Void){
        
        let errorMessage = checkLogin()
        
        if errorMessage != nil {
            completion(.failure(errorMessage))
        }else{
            postUserLogin(){
                completion(.success)
            }
        }
    }
    
    func checkLogin() -> String?{
        
        if viewData.inputedLoginAccount.count == 0 {
            return "請輸入帳號"
        }else if viewData.inputedLoginPassword.count == 0 {
            return "請輸入密碼"
        }
            
        return nil
    }
    
    func postUserLogin(completion: @escaping() -> Void){
        //api post userlogin
        viewData.isLoading.value = true
        
        ApiService.sharedInstance.postLogin(username:  viewData.inputedLoginAccount, password: viewData.inputedLoginPassword) { result in
            
            self.viewData.isLoading.value = false
            
            switch result {
            case .success(let responseData):
                LoginDataStorage.sharedInstance.loginData = responseData
                
                completion()
                print(responseData)
                
            case .failure(let error):
                print(error ?? "")
            }
        }
    }
    
    func pushToUserView(_ viewController: UIViewController?){
        let userViewController = UserViewController.init(nibName:  "UserViewController", bundle: Bundle.main)
        userViewController.modalPresentationStyle = .fullScreen

        if let viewController = viewController {
            viewController.present(userViewController, animated: true)
        }
    }
}
