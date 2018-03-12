//
//  FontMeme.swift
//  ioMeme
//
//  Created by Andre Rosa on 10/03/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

@IBDesignable
class FontMeme: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView(){
        let memeTextAttributes:[String:Any] = [
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
            NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
            NSAttributedStringKey.strokeWidth.rawValue: -3.4
        ]
        
        defaultTextAttributes = memeTextAttributes
        textAlignment = .center
        textColor = UIColor.white
    }

}
