//
//  UserViewController.swift
//  DemoRestfulApi
//
//  Created by PujieLee on 2022/9/25.
//

import UIKit

class UserViewController: BaseViewController, UITextFieldDelegate {

    @IBOutlet weak var lblUser: UILabel!
    @IBOutlet weak var btnExit: UIButton!
   
    lazy var model: UserViewModel = {
        return UserViewModel()
    }()
    
    var viewData: UserViewData {
        return model.viewData
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewInit()
        dataBinding()
        model.start()
    }
    
    func viewInit() {
        self.setupButton(btnExit)
    }
    
    func dataBinding(){
        
        viewData.isLoading.addObserver(sendNow: false){[weak self] isLoading in
            if isLoading {
                self?.nvStartLoading(message: "讀取中...")
            }else{
                self?.removeNV()
            }
        }
        
        viewData.userData.addObserver(sendNow: false){[weak self] userData in
            self?.lblUser.text = self?.model.createUserInfomation(userData)
        }
        
        viewData.networkMessage.addObserver(sendNow: false){[weak self] networkMessage in
            if networkMessage.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertMessage(title: "訊息",
                                           message: networkMessage,
                                           okEvent: nil)
                    self?.viewData.networkMessage.value = ""
                }
            }
        }
    }
    
    //MARK: UI event
    @IBAction func btnExitClicked(_ sender: Any) {
        self.view.endEditing(true)
        self.dismiss(animated: true)
    }
     
}

extension UserViewController {

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

