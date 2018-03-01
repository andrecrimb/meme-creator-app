//
//  MemeTableCell.swift
//  ioMeme
//
//  Created by Andre Rosa on 28/02/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

class MemeTableCell: UITableViewCell {

    @IBOutlet weak var memeImage: RoundedImage!
    @IBOutlet weak var topText: UILabel!
    @IBOutlet weak var bottomText: UILabel!
    
    var meme: Meme!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(meme: Meme){
        self.meme = meme
        self.memeImage.image = self.meme.originalImage
        self.topText.text = self.meme.topText
        self.bottomText.text = self.meme.bottomText
    }

}
