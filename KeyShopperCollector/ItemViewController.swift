//
//  ItemViewController.swift
//  KeyShopperCollector
//
//  Created by Jay P. Hayes on 11/25/16.
//  Copyright © 2016 Jay P. Hayes. All rights reserved.
// Add to Git hib from XCODE?

import UIKit

class ItemViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var txtItemName: UITextField!
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var isLibrary: UISwitch!
    @IBOutlet weak var btnAddUpdateButton: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    var imagePicker =  UIImagePickerController()
    var item: MasterItems? = nil
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        guard let selItem = item else {
            
            btnDelete.isHidden = true
            print("NO ITEM SELECTED")
            return
        }
        
        btnAddUpdateButton.setTitle("Update", for: .normal)
        txtItemName.text = selItem.name
        imgItem.image = UIImage(data: selItem.image as! Data)
        
        
//        if item != nil {
//            imgItem.image = UIImage(data: item.image as! Data)
//            txtItemName.text = item?.name
//            print("WE HAVE A SELECED ITEM \(item?.name)")
//        } else {
//            print("NO ITEMS")
//        }
        
    }
    
    //MARK: - Image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imgItem.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
        
        
    }

    
    //MARK: - screen button methods
    @IBAction func btnDeleteItem(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(item!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
        
    }
    
    
    @IBAction func btnAddTapped(_ sender: Any) {
        
        if item != nil {
            item!.name = txtItemName.text
            
            if let itemImg = UIImagePNGRepresentation(imgItem.image!) {
                item!.image = itemImg as NSData?
            }

        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let item = MasterItems(context: context)
            
            item.name = txtItemName.text
            
            if let itemImg = UIImagePNGRepresentation(imgItem.image!) {
                item.image = itemImg as NSData?
            }

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
        present(imagePicker, animated: true, completion: nil)
    }

}
