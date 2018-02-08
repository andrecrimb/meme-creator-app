//
//  ViewController.swift
//  ioMeme
//
//  Created by Andre Rosa on 19/01/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

class MemeMainVC: UIViewController {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let textFieldDelegate = TextFieldDelegate()
    
    var meme: Meme!
    
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    @IBOutlet weak var cameraBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.checkShareButtonAvaliable()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        bottomText.delegate = textFieldDelegate
        topText.delegate = textFieldDelegate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        subscribeToKeyboardNotifications(scrollView: scrollView)
        cameraBtn.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        unsubscribeFromKeyboardNotifications()
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func shareMeme(_ sender: Any) {
        self.save()
        let controller = UIActivityViewController(activityItems: [meme.memedImage], applicationActivities: nil)
        controller.completionWithItemsHandler = { (activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) -> Void in
            if completed {
                self.save()
            }
        }
        self.present(controller, animated: true, completion: nil)
        
    }
    @IBAction func dismissViewPress(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func subscribeToKeyboardNotifications(scrollView: UIScrollView){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification){
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = getKeyboardHeight(notification)
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(_ notification: Notification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    func generateMemedImage() -> UIImage{
        let imageSize = self.imagePickerView.frame.size
      
        if let imageRect = self.imagePickerView.superview?.convert(self.imagePickerView.frame, to: nil){
            
            UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
            
            let memeRect = CGRect(x: imageRect.origin.x, y: -imageRect.origin.y, width: view.bounds.size.width, height: view.bounds.size.height)
            
            view.drawHierarchy(in: memeRect, afterScreenUpdates: true)
            
            let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            return memedImage
        }
        return UIImage()
    }
    
    func save(){
        let memedImage: UIImage = generateMemedImage()
        self.meme = Meme(topText: topText.text!, bottomText: bottomText.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
    }
    
    func checkShareButtonAvaliable(){
      shareBtn.isEnabled = (imagePickerView != nil)
    }
}

extension MemeMainVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        presentImagePickerWith(sourceType: .camera)
    }
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        presentImagePickerWith(sourceType: .photoLibrary)
    }
    
    func presentImagePickerWith(sourceType: UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imagePickerView.image = image
        }
        dismiss(animated: true, completion: nil)
        self.checkShareButtonAvaliable()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
