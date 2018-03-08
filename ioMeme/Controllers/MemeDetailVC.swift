//
//  MemeDetailVC.swift
//  ioMeme
//
//  Created by Andre Rosa on 08/03/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

class MemeDetailVC: UIViewController {

    @IBOutlet weak var imagePickerView: UIImageView!
    
    var meme: Meme!
    
    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerView.image = meme.memedImage
    }
}
