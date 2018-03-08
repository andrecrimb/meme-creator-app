//
//  BlurView.swift
//  ioMeme
//
//  Created by Andre Rosa on 22/02/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

@IBDesignable
class BlurView: UIView {

    var blurStyleEffect: UIBlurEffectStyle = UIBlurEffectStyle.regular
    
    @IBInspectable
    var blur: Bool = false {
        didSet{
            setupView(active: self.blur)
        }
    }
   
    @IBInspectable
    var blurStyle: Int = 3{
        didSet{
            switch blurStyle {
            case 1:
                blurStyleEffect = UIBlurEffectStyle.dark
            case 2:
                blurStyleEffect = UIBlurEffectStyle.light
            case 3:
                blurStyleEffect = UIBlurEffectStyle.regular
            default:
                blurStyleEffect = UIBlurEffectStyle.regular
            }
            setupView(active: blur)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView(active: blur)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView(active: blur)
    }
    
    func setupView(active: Bool){
        if active && !UIAccessibilityIsReduceTransparencyEnabled(){
            let blurEffect = UIBlurEffect(style: blurStyleEffect)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.layer.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.insertSubview(blurEffectView, at: 0)
        }
    }
    
}
