//
//  ShadowImage.swift
//  ioMeme
//
//  Created by Andre Rosa on 19/02/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedImage: UIImageView {
  
    @IBInspectable
    var Rounded: Bool = false{
        didSet{
            setupView(active: self.Rounded)
        }
    }

    override open func awakeFromNib() {
        super.awakeFromNib()
        setupView(active: Rounded)
    }
    
    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView(active: Rounded)
    }
    
    func setupView(active: Bool){
        layer.cornerRadius = active ? 16 : 0
    }
    
}
