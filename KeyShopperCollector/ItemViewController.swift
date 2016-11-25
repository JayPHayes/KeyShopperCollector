//
//  ItemViewController.swift
//  KeyShopperCollector
//
//  Created by Jay P. Hayes on 11/25/16.
//  Copyright © 2016 Jay P. Hayes. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var txtItemName: UITextField!
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var isLibrary: UISwitch!
    
    var imagePicker =  UIImagePickerController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
    }
    
    //MARK: - Image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imgItem.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
        
        
    }

    
    //MARK: - screen button methods
    @IBAction func btnAddTapped(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let item = MasterItems(context: context)
        
        item.name = txtItemName.text
        
        if let itemImg = UIImagePNGRepresentation(imgItem.image!) {
            item.image = itemImg as NSData?
        }
        
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func btnPhotosTapped(_ sender: Any) {
        if isLibrary.isOn {
            imagePicker.sourceType = .photoLibrary
        } else {
            imagePicker.sourceType = .savedPhotosAlbum
        }
        
        
        present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func btnCameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
    }

}
