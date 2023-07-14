//
//  ViewControllerSubClass.swift
//  CoredataApp
//
//  Created by Айбек on 14.07.2023.
//

import UIKit
import CoreData


class ViewControllerSubClass: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameText: UITextField!
    
    
    @IBOutlet weak var artistText: UITextField!
    
    @IBOutlet weak var yearText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        
        //Recognizers
        let gestureRecohnizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecohnizer)
        
        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecognizer)
        
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newArt = NSEntityDescription.insertNewObject(forEntityName: "Pain", into: context)
        
        //Attributes
        newArt.setValue(nameText.text!, forKey: "name")
        newArt.setValue(artistText.text!, forKey: "artist")
        
        if let yearInt = Int(yearText.text!) {
            newArt.setValue(yearInt, forKey: "year")
        }
        
        newArt.setValue(UUID(), forKey: "id")
        
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        
        newArt.setValue(data, forKey: "image")
        do {
            try context.save()
            print("success")
        } catch {
            print("error")
        }
        
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
}
