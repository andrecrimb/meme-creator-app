//
//  MemeCollectionCell.swift
//  ioMeme
//
//  Created by Andre Rosa on 28/02/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

class MemeCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var memeImage: RoundedImage!
    
    var meme: Meme!
    
    func configureCell(meme: Meme){
        self.meme = meme
        memeImage.image = self.meme.originalImage
    }
    
}
