//
//  LoginViewController.swift
//  DemoRestfulApi
//
//  Created by PujieLee on 2022/9/25.
//

import UIKit

class LoginViewController: BaseViewController, UITextFieldDelegate {

    @IBOutlet weak var tfAccount: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    lazy var model: LoginViewModel = {
        return LoginViewModel()
    }()
    
    var viewData: LoginViewData {
        return model.viewData
    }
    

    required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewInit()
        dataBinding()
        model.start()
    }
    
    func viewInit() {
        self.setupTapGesture(#selector(endEditing))
        self.setupButton(btnLogin)
        self.setupTextField(tfAccount)
        self.setupTextField(tfPassword)
        
        self.testData()//test
    }
    
    func dataBinding(){
        
        viewData.isLoading.addObserver(sendNow: false){[weak self] isLoading in
            if isLoading {
                self?.nvStartLoading(message: "讀取中...")
            }else{
                self?.removeNV()
            }
        }
    }
    
    func testData() {
        tfAccount.text = "pjlee"
        tfPassword.text = "123456"
        viewData.inputedLoginAccount = "pjlee"
        viewData.inputedLoginPassword = "123456"
    }
    
    //MARK: UI event
    @IBAction func btnLoginClicked(_ sender: Any) {
        self.view.endEditing(true)
        
        model.runLogin(){[weak self] result in
            
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.model.pushToUserView(self)//跳頁
                }
            case .failure(let errorMsg):
                guard errorMsg != nil else { return }
                    
                //顯示訊息
                DispatchQueue.main.async {
                    self?.showAlertMessage(title: "訊息",
                                           message: errorMsg!,
                                           okEvent: nil)
                }
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == tfAccount {
            viewData.inputedLoginAccount = textField.text ?? ""
        }else if textField == tfPassword{
            viewData.inputedLoginPassword = textField.text ?? ""
        }
    }
}

extension LoginViewController {

    func setupButton(_ btn: UIButton){
        btn.layer.cornerRadius = 22.0
        btn.layer.borderWidth = 2.0
        btn.layer.borderColor = UIColor.init(rgb: 0x81D1C3).cgColor
    }
    
    func setupTextField(_ tf: UITextField){
        tf.layer.cornerRadius = 6.0
        tf.layer.borderWidth = 1.0
        tf.layer.borderColor = UIColor.init(rgb: 0x000000).cgColor
        tf.backgroundColor = UIColor.init(rgb: 0xFFFFFF)
        tf.delegate = self
    }
}
