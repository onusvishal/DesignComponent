//
//  Utility.swift
//  DesignComponent
//
//  Created by Admin on 27/12/18.
//  Copyright © 2018 VISHAL. All rights reserved.
//

import Foundation
import UIKit
class Utility {
    
    // MARK: - Add shadow to View..
    class func Button1(button: UIButton) {
        let ButtonLayer: CALayer? = button.layer
        ButtonLayer?.frame = button.frame
        ButtonLayer?.cornerRadius = button.frame.size.height / 2
        ButtonLayer?.shadowRadius = 1.0
        ButtonLayer?.shadowOpacity = 0.3
        ButtonLayer?.shadowOffset = CGSize(width: CGFloat(0.0), height: CGFloat(1.0))
    }
    
    class func Button2(button: UIButton) {
        let ButtonLayer: CALayer? = button.layer
        ButtonLayer?.frame = button.frame
        ButtonLayer?.cornerRadius = button.frame.size.height / 2
        ButtonLayer?.borderWidth = 2.0
        ButtonLayer?.borderColor = BorderColor.cgColor
        ButtonLayer?.shadowRadius = 1.0
        ButtonLayer?.shadowOpacity = 0.3
        ButtonLayer?.shadowOffset = CGSize(width: CGFloat(0.0), height: CGFloat(1.0))
    }
    
    class func View1(view: UIView) {
        let ViewLayer: CALayer? = view.layer
        ViewLayer?.frame = view.frame
        ViewLayer?.cornerRadius = view.frame.size.height / 2
        ViewLayer?.borderWidth = 2.0
        ViewLayer?.borderColor = GreyBorderColor.cgColor
    }
    
    class func View2(view: UIView) {
        let ViewLayer: CALayer? = view.layer
        ViewLayer?.frame = view.frame
        ViewLayer?.cornerRadius = 10.0
        ViewLayer?.shadowRadius = 1.0
        ViewLayer?.shadowOpacity = 0.3
        ViewLayer?.shadowOffset = CGSize(width: CGFloat(0.0), height: CGFloat(1.0))
    }
    
    class func View3(view: UIView) {
        let ViewLayer: CALayer? = view.layer
        ViewLayer?.frame = view.frame
        ViewLayer?.cornerRadius = 10.0
        ViewLayer?.shadowRadius = 1.0
        ViewLayer?.shadowOpacity = 0.3
        ViewLayer?.shadowOffset = CGSize(width: CGFloat(0.0), height: CGFloat(1.0))
    }
    
    class func imageView1(imageView: UIImageView) {
        let rectShape = CAShapeLayer()
        rectShape.bounds = imageView.frame
        rectShape.position = imageView.center
        rectShape.path = UIBezierPath(roundedRect: imageView.bounds, byRoundingCorners: [.topRight , .topLeft], cornerRadii: CGSize(width: 10, height: 10)).cgPath
        imageView.layer.mask = rectShape
    }
    
    class func Label1(label: UILabel) {
        let LabelLayer: CALayer? = label.layer
        label.layer.masksToBounds = true
        LabelLayer?.frame = label.frame
        LabelLayer?.cornerRadius = 10.0
        LabelLayer?.shadowRadius = 1.0
        LabelLayer?.shadowOpacity = 0.3
        LabelLayer?.shadowOffset = CGSize(width: CGFloat(0.0), height: CGFloat(1.0))
    }
}
