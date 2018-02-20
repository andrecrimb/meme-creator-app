//
//  ShadowImage.swift
//  ioMeme
//
//  Created by Andre Rosa on 19/02/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

private var customShadow = false

@IBDesignable
extension UIImageView {
    
    @IBInspectable var CustomShadow: Bool{
        get {
            return customShadow
        }
        set{
            customShadow = newValue
            setupView(active: customShadow)
        }
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        setupView(active: customShadow)
    }
    
    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView(active: customShadow)
    }
    
    func setupView(active: Bool){
        if active{
            self.layer.cornerRadius = 16
        } else {
            self.layer.cornerRadius = 0
        }
    }
    
}
