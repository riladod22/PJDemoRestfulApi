//
//  BaseViewController.swift
//  DemoRestfulApi
//
//  Created by PujieLee on 2022/9/25.
//

import UIKit

class BaseViewController: UIViewController {
    
    //Gray mask
    lazy var viLoadingMask: UIView = {
        var mask = UIView(frame: .zero)
        mask.translatesAutoresizingMaskIntoConstraints = false
        mask.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        return mask
    }()
    
    lazy var lblMaskLabel: UILabel = {
        var lbl = UILabel(frame: .zero)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.textColor = UIColor.init(rgb: 0x000000)
        return lbl
    }()

    func nvStartLoading(message: String?) -> Void{
        //Start loading progress animation

        if(viLoadingMask.superview == nil){
            view.addSubview(viLoadingMask)
            setViewMatchParent(vi: viLoadingMask)
        }
        if(lblMaskLabel.superview == nil){
            viLoadingMask.addSubview(lblMaskLabel)
            setViewAlignCenter(vi: lblMaskLabel)
        }
        
        lblMaskLabel.text = message
        
    }

    func removeNV() -> Void{
        //Remove loading progress animation
        viLoadingMask.removeFromSuperview()
    }
     //end of NV
     
    
    func showAlertMessage(title: String, message: String,  okEvent: (()->Void)?) {
        //Message label
        let action = UIAlertController(title: title, message: message,  preferredStyle: .alert)
        action.addAction(UIAlertAction(title: "確定", style: .default, handler: { action in
            
            if let event = okEvent {
                event()
            }
        }))
        
        self.present(action, animated: true, completion: nil)
    }
     
    func setupTapGesture(_ event:Selector?){
        //add gesture to close keyboard
        let tap = UITapGestureRecognizer(target: self, action: event)
        
        self.view.addGestureRecognizer(tap)
    }

    @objc func endEditing(){
        self.view.endEditing(true)
    }
}
