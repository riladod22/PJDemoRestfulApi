//
//  TryTopViewController.swift
//  DemoRestfulApi
//
//  Created by PujieLee on 2022/9/29.
//

import UIKit

class TryTopViewController: BaseViewController {
    
    @IBOutlet weak var btnPrev: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnVerify: UIButton!
    @IBOutlet weak var lblLevel: UILabel!
    
    var viewCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblLevel.text = "階層 = \(viewCount)"
    }
    
    @IBAction func btnPrevClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnNextClicked(_ sender: Any) {
        let vc = TryTopViewController.init(nibName:  "TryTopViewController", bundle: Bundle.main)
        vc.modalPresentationStyle = .fullScreen
        vc.viewCount = (self.viewCount + 1)

        self.present(vc, animated: true)
    }
    
    @IBAction func btnVerifyClicked(_ sender: Any) {
        
        let vc:UIViewController? = getTopViewController()
        
        var showLv = -1
        
        if let tryTopVC = vc as? TryTopViewController {
            showLv = tryTopVC.viewCount
        }
        
        self.showAlertMessage(title: "-訊息-", message: "階層 = \(showLv)", target: self, okEvent: nil)
    }
    
}
