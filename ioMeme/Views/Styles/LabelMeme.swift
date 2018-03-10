//
//  LabelMeme.swift
//  ioMeme
//
//  Created by Andre Rosa on 09/03/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

@IBDesignable
class LabelMeme: UILabel {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        setupView()
    }
    
    func setupView(){
        let strokeTextAttributes: [NSAttributedStringKey : Any] = [
            NSAttributedStringKey.strokeColor : UIColor.black,
            NSAttributedStringKey.foregroundColor : UIColor.white,
            NSAttributedStringKey.strokeWidth : -3.0,
            ]
    
        self.lineBreakMode = .byTruncatingMiddle
        if let text = self.text{
            self.attributedText = NSAttributedString(string: text, attributes: strokeTextAttributes)
        }
    }
}
