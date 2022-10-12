//
//  Tools.swift
//  DemoRestfulApi
//
//  Created by PujieLee on 2022/9/26.
//

import UIKit

func setViewMatchParent(vi: UIView) -> Void{
    guard vi.superview != nil else { return }
    
    vi.translatesAutoresizingMaskIntoConstraints = false
    
    vi.superview?.addConstraint(NSLayoutConstraint.init(item: vi,
                                                        attribute: .leading,
                                                        relatedBy: .equal,
                                                        toItem: vi.superview,
                                                        attribute: .leading,
                                                        multiplier: 1.0,
                                                        constant: 0))
    
    vi.superview?.addConstraint(NSLayoutConstraint.init(item: vi,
                                                        attribute: .trailing,
                                                        relatedBy: .equal,
                                                        toItem: vi.superview,
                                                        attribute: .trailing,
                                                        multiplier: 1.0,
                                                        constant: 0))
    
    vi.superview?.addConstraint(NSLayoutConstraint.init(item: vi,
                                                        attribute: .top,
                                                        relatedBy: .equal,
                                                        toItem: vi.superview,
                                                        attribute: .top,
                                                        multiplier: 1.0,
                                                        constant: 0))
    
    vi.superview?.addConstraint(NSLayoutConstraint.init(item: vi,
                                                        attribute: .bottom,
                                                        relatedBy: .equal,
                                                        toItem: vi.superview,
                                                        attribute: .bottom,
                                                        multiplier: 1.0,
                                                        constant: 0))
}

func setViewAlignCenter(vi: UIView) -> Void{
    guard vi.superview != nil else { return }
    
    vi.translatesAutoresizingMaskIntoConstraints = false
    
    vi.superview?.addConstraint(NSLayoutConstraint.init(item: vi,
                                                        attribute: .centerX,
                                                        relatedBy: .equal,
                                                        toItem: vi.superview,
                                                        attribute: .centerX,
                                                        multiplier: 1.0,
                                                        constant: 0))
    
    vi.superview?.addConstraint(NSLayoutConstraint.init(item: vi,
                                                        attribute: .centerY,
                                                        relatedBy: .equal,
                                                        toItem: vi.superview,
                                                        attribute: .centerY,
                                                        multiplier: 1.0,
                                                        constant: 0))
}

/*
func getTopViewController() -> UIViewController?{
    //取得最上層的viewController
    let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first //ios13因scene捨棄keyWindow
    
    var topController = keyWindow?.rootViewController
        
    while let presentedViewController = topController?.presentedViewController {
        topController = presentedViewController
    }
    
    return topController
    
}*/
