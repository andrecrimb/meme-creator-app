//
//  CornerView.swift
//  ioMeme
//
//  Created by Andre Rosa on 24/02/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

@IBDesignable
extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
            setNeedsLayout()
        }
    }

    open override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
}
