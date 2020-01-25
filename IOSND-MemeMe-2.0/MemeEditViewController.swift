//
//  ViewController.swift
//  IOSND-MemeMe-1.0
//
//  Created by Dimopoulos Stavros tou Athanasiou on 18/1/20.
//  Copyright © 2020 Dimopoulos Stavros tou Athanasiou. All rights reserved.
//

import UIKit



class ViewController: UIViewController,UIImagePickerControllerDelegate ,UINavigationControllerDelegate,UITextFieldDelegate{
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topMenuBar: UIToolbar!
    @IBOutlet weak var bottoMenuBar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    var memes:[Meme]! {
           let object = UIApplication.shared.delegate
           let appDelegate = object as! AppDelegate
           return appDelegate.memes
       }
    
    let initialText = "(enter text)"
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        
        NSAttributedString.Key.strokeColor: UIColor.black/* TODO: fill in appropriate UIColor */,
        NSAttributedString.Key.foregroundColor: UIColor.white/* TODO: fill in appropriate UIColor */,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: -4.0,  /* TODO: fill in appropriate Float */
        // I had to use negative value.It was tricky
        // https://developer.apple.com/library/archive/qa/qa1531/_index.html
        
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        reset()
        self.navigationController?.isNavigationBarHidden=true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        topTextField.defaultTextAttributes=memeTextAttributes
        topTextField.textAlignment=NSTextAlignment.center
        
        bottomTextField.defaultTextAttributes=memeTextAttributes
        bottomTextField.textAlignment=NSTextAlignment.center
        subscribeToKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide(_:)) , name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self,name: UIResponder.keyboardWillHideNotification,object: nil)
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func save() {
        // Create the meme
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
       
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
      
        
    }
    
    func generateMemedImage() -> UIImage {
          topMenuBar.isHidden=true
          bottoMenuBar.isHidden=true
          // Render view to an image
          UIGraphicsBeginImageContext(self.view.frame.size)
          view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
          let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
          UIGraphicsEndImageContext()
          topMenuBar.isHidden=false
          bottoMenuBar.isHidden=false
          return memedImage
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage/* TODO: Dictionary Key Goes Here */] as? UIImage {
            imagePickerView.image = image
            shareButton.isEnabled=true
        }
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) { // clear the default text
        if textField.text==initialText{
            textField.text=""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { // Hide the keybord when RETURN is pressed
        textField.resignFirstResponder()
    }
    
    func reset(){
        topTextField.text=initialText
        bottomTextField.text=initialText
        imagePickerView!.image=nil
        shareButton.isEnabled=false

    }
    
    @IBAction func shareMeme(_ sender: Any) {
        if let  _ = imagePickerView.image{
            let vc = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: nil)
            vc.completionWithItemsHandler = { (activityType, completed, returnedItems, error) in
                if !completed{
                    return
                }
                self.save()
                self.reset()
                self.navigationController?.popViewController(animated: true)
                self.navigationController?.isNavigationBarHidden=false
                            
            }
        present(vc, animated: true)

        }
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self //as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePicker.sourceType =  .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickImageFromAlbum(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self //as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePicker.sourceType =  .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottomTextField.isEditing{  // move the view up only when the user edits the bottom text field. If we move up while editing the top field, it will not be vissible.
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    

    @objc func keyboardWillHide(_ notification:Notification) {
        
        view.frame.origin.y = 0 // += getKeyboardHeight(notification)
    }
  
    @IBAction func cancelAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.isNavigationBarHidden=false

    }
}
