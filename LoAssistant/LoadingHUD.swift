//
//  LoadingHUD.swift
//  LoadingExample
//
//  Created by Fury on 31/05/2019.
//  Copyright © 2019 Fury. All rights reserved.
//

import Foundation
import UIKit

class LoadingHUD {
    private static let sharedInstance = LoadingHUD()
    
    private var backgroundView: UIView?
    private var popupView: UIImageView?
    private var loadingLabel: UILabel?
    
    class func show() {
        let backgroundView = UIView(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        
        let popupView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        popupView.animationImages = LoadingHUD.getAnimationImageArray()
        popupView.animationDuration = 0.8
        popupView.animationRepeatCount = 0
        
        let loadingLabel = UILabel(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        loadingLabel.text = "Loading ..."
        loadingLabel.font = UIFont.boldSystemFont(ofSize: 20)
        loadingLabel.textColor = .black
        
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(backgroundView)
            window.addSubview(popupView)
            window.addSubview(loadingLabel)
            
            backgroundView.frame = CGRect(x: 0, y: 0, width: window.frame.maxX, height: window.frame.maxY)
            backgroundView.backgroundColor = UIColor.systemGroupedBackground
            
            popupView.center = window.center
            popupView.startAnimating()
            
            loadingLabel.layer.position = CGPoint(x: window.frame.midX, y: popupView.frame.maxY + 10)
            
            sharedInstance.backgroundView?.removeFromSuperview()
            sharedInstance.popupView?.removeFromSuperview()
            sharedInstance.loadingLabel?.removeFromSuperview()
            sharedInstance.backgroundView = backgroundView
            sharedInstance.popupView = popupView
            sharedInstance.loadingLabel = loadingLabel
        }
    }
    
    class func hide() {
        if let popupView = sharedInstance.popupView,
            let loadingLabel = sharedInstance.loadingLabel,
        let backgroundView = sharedInstance.backgroundView {
            popupView.stopAnimating()
            backgroundView.removeFromSuperview()
            popupView.removeFromSuperview()
            loadingLabel.removeFromSuperview()
        }
    }

    private class func getAnimationImageArray() -> [UIImage] {
        var animationArray: [UIImage] = []
        animationArray.append(UIImage(named: "frame-1")!)
        animationArray.append(UIImage(named: "frame-2")!)
        animationArray.append(UIImage(named: "frame-3")!)
        animationArray.append(UIImage(named: "frame-4")!)
        animationArray.append(UIImage(named: "frame-5")!)
        animationArray.append(UIImage(named: "frame-6")!)
        animationArray.append(UIImage(named: "frame-7")!)
        animationArray.append(UIImage(named: "frame-8")!)
        animationArray.append(UIImage(named: "frame-9")!)
        animationArray.append(UIImage(named: "frame-10")!)
        
        animationArray.append(UIImage(named: "frame-11")!)
        animationArray.append(UIImage(named: "frame-12")!)
        animationArray.append(UIImage(named: "frame-13")!)
        animationArray.append(UIImage(named: "frame-14")!)
        animationArray.append(UIImage(named: "frame-15")!)
        animationArray.append(UIImage(named: "frame-16")!)
        animationArray.append(UIImage(named: "frame-17")!)
        animationArray.append(UIImage(named: "frame-18")!)
        animationArray.append(UIImage(named: "frame-19")!)
        animationArray.append(UIImage(named: "frame-20")!)
        
        animationArray.append(UIImage(named: "frame-21")!)
        animationArray.append(UIImage(named: "frame-22")!)
        animationArray.append(UIImage(named: "frame-23")!)
        animationArray.append(UIImage(named: "frame-24")!)
        animationArray.append(UIImage(named: "frame-25")!)
        animationArray.append(UIImage(named: "frame-26")!)
        animationArray.append(UIImage(named: "frame-27")!)
        animationArray.append(UIImage(named: "frame-28")!)
        animationArray.append(UIImage(named: "frame-29")!)
        animationArray.append(UIImage(named: "frame-30")!)
        
        animationArray.append(UIImage(named: "frame-31")!)
        animationArray.append(UIImage(named: "frame-32")!)
        animationArray.append(UIImage(named: "frame-33")!)
        animationArray.append(UIImage(named: "frame-34")!)
        animationArray.append(UIImage(named: "frame-35")!)
        animationArray.append(UIImage(named: "frame-36")!)
        animationArray.append(UIImage(named: "frame-37")!)
        animationArray.append(UIImage(named: "frame-38")!)
        animationArray.append(UIImage(named: "frame-39")!)
        animationArray.append(UIImage(named: "frame-40")!)
        
        animationArray.append(UIImage(named: "frame-41")!)
        animationArray.append(UIImage(named: "frame-42")!)
        animationArray.append(UIImage(named: "frame-43")!)
        animationArray.append(UIImage(named: "frame-44")!)
        animationArray.append(UIImage(named: "frame-45")!)
        animationArray.append(UIImage(named: "frame-46")!)
        animationArray.append(UIImage(named: "frame-47")!)
        animationArray.append(UIImage(named: "frame-48")!)

        return animationArray
    }
}
