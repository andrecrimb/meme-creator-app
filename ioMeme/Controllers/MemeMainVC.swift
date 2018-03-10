//
//  ViewController.swift
//  ioMeme
//
//  Created by Andre Rosa on 19/01/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import UIKit

class MemeMainVC: UIViewController {

    // MARK: Setting IBOutlets
    
    @IBOutlet weak var backgroundViewImage: UIView!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let textFieldDelegate = TextFieldDelegate()
    
    var meme: Meme!
    
    @IBOutlet weak var shareBtn: UIButton!
    
    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.checkShareButtonAvaliable()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        bottomText.delegate = textFieldDelegate
        topText.delegate = textFieldDelegate
        
        
        
        initMemeData()
    }
    // MARK: Subscribing to keybord notifications to scroll the view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        subscribeToKeyboardNotifications()
        shareBtn.isEnabled = imagePickerView.image != nil
    }
    
    // MARK: Unsubscribing to keybord notifications
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: Dismiss keyboard when user tap anywhere
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // MARK: Setting UIAlertControler with camera souce options. Disable camera option if camera not available
    @IBAction func cameraOptions(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let controller = UIAlertController(title: "Choose from source", message: nil, preferredStyle: .actionSheet)
            controller.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (UIAlertAction) in
                self.pickAnImageFromSource(sourceType: .camera)
            }))
            
            controller.addAction(UIAlertAction(title: "Album", style: .default, handler: { (UIAlertAction) in
                self.pickAnImageFromSource(sourceType: .savedPhotosAlbum)
            }))
            controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(controller, animated: true, completion: nil)
        } else {
            self.pickAnImageFromSource(sourceType: .savedPhotosAlbum)
        }
    }
    
    // MARK: Method that calls ActivityViewController and save image
    @IBAction func shareMeme(_ sender: Any) {
        self.save()
        let controller = UIActivityViewController(activityItems: [meme.memedImage], applicationActivities: nil)
        controller.completionWithItemsHandler = { (activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) -> Void in
            if completed {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIF_RELOAD_TABLE), object: nil)
                self.dismissView()
            }
        }
        self.present(controller, animated: true, completion: nil)
        
    }
    
    
    @IBAction func dismissViewPress(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: Method that subscribe and unsubscribe to keyboard notifications
    func subscribeToKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    // MARK: Method that get keyboard height and set contentInset of the scrollview
    @objc func keyboardWillShow(_ notification: Notification){
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = getKeyboardHeight(notification)
        scrollView.contentInset = contentInset
    }
    
    // MARK: Method that set the scrollview contentInset to zero
    @objc func keyboardWillHide(_ notification: Notification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    
    // MARK: Function that crate the meme taking a "screenshot"
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
    
    
    // MARK: Method save the meme in appDelegate and set the background color to white before save
    func save(){
        backgroundViewImage.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let memedImage: UIImage = generateMemedImage()
        backgroundViewImage.backgroundColor = nil
        self.meme = Meme(topText: topText.text!, bottomText: bottomText.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(self.meme)
    }
    
    func checkShareButtonAvaliable(){
      shareBtn.isEnabled = (imagePickerView != nil)
    }
    
    func areLabelsHidden(hidden: Bool){
        topText.isHidden = hidden
        bottomText.isHidden = hidden
    }
    
    func dismissView(){
        self.dismiss(animated: false, completion: nil)
    }
    
    func initMemeData(){
        areLabelsHidden(hidden: (meme == nil))
        if meme != nil{
            imagePickerView.image = meme.originalImage
            bottomText.text = meme.bottomText
            topText.text = meme.topText
        }
    }
}

// MARK: Delegate methods
extension MemeMainVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
     func pickAnImageFromSource(sourceType: UIImagePickerControllerSourceType) {
        presentImagePickerWith(sourceType: sourceType)
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
        
        // MARK: Check if there is an image to show the labels
        areLabelsHidden(hidden: (imagePickerView.image == nil))
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismissView()
    }
}
