//
//  ViewController.swift
//  ioMeme
//
//  Created by Andre Rosa on 19/01/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

class MemeMainVC: UIViewController {

    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var topText: UITextField!
    
    let textFieldDelegate = TextFieldDelegate()
    
    @IBOutlet weak var cameraBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        bottomText.delegate = textFieldDelegate
        topText.delegate = textFieldDelegate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        subscribeToKeyboardNotifications()
        cameraBtn.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        unsubscribeFromKeyboardNotifications()
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        bottomText.resignFirstResponder()
        topText.resignFirstResponder()
    }
    
}

extension MemeMainVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func shareMeme(_ sender: Any) {
    }
}
