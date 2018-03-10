//
//  ShadowView.swift
//  ioMeme
//
//  Created by Andre Rosa on 22/02/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

@IBDesignable
class ShadowView: UIView {

    @IBInspectable
    var ShadowView: Bool = false{
        didSet{
            setupView(active: self.ShadowView)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView(active: ShadowView)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView(active: ShadowView)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        setupView(active: ShadowView)
    }
    
    func setupView(active: Bool){
        if active{
            self.layer.cornerRadius = 16
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = CGSize(width: 1, height: 1)  //Here you control x and y
            self.layer.shadowOpacity = 0.3
            self.layer.shadowRadius = 6 //Here your control your blur
            self.layer.masksToBounds =  false
            layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 16).cgPath
        }
    }
}
