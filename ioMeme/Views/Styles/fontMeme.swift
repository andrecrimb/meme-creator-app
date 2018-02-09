//
//  fontMeme.swift
//  ioMeme
//
//  Created by Andre Rosa on 24/01/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//
import Foundation
import UIKit

@IBDesignable class fontMeme: UITextField{
  
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
        
        self.defaultTextAttributes = memeTextAttributes
        self.textAlignment = .center
        self.textColor = UIColor.white
        self.textColor = UIColor.white
    }
    
}
