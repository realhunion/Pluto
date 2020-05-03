//
//  MyProfileVC+Edit.swift
//  Pluto
//
//  Created by Hunain Ali on 4/25/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation
import Firebase

extension MyProfileVC : UITextFieldDelegate {
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentCharacterCount = textField.text?.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        let newLength = currentCharacterCount + string.count - range.length
        return newLength <= 12
    }
    
    
    func editNameTapped() {
        
        guard let myU = self.myUser else { return }
        
        
        DispatchQueue.main.async {
            
            let alertController = UIAlertController(title: "Edit Name:", message: "", preferredStyle: UIAlertController.Style.alert)
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.text = myU.name
            }
            let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
                guard let editedName = alertController.textFields?[0].text else { return }
                guard editedName != "" else { return }
                
                MyProfileEditor.shared.saveUserName(name: editedName)
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
                (action : UIAlertAction!) -> Void in })
            
            alertController.addAction(cancelAction)
            alertController.addAction(saveAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    func editDescriptionTapped() {
        
        guard let myU = self.myUser else { return }
        
        let alertController = UIAlertController(title: "Edit Description:", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.text = myU.description
        }
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            guard var editedDescription = alertController.textFields?[0].text else { return }
            if editedDescription == "" {
                let array = ["🪐", "⭐️", "🌎"]
                editedDescription = array.randomElement() ?? "🚀"
            }
            
            MyProfileEditor.shared.saveUserDescription(description: editedDescription)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    
    
    func editImageTapped() {
        
        guard let myU = self.myUser else { return }
        
        DispatchQueue.main.async {
            
            let picker: UIImagePickerController = UIImagePickerController()
            
            picker.allowsEditing = true
            picker.mediaTypes = ["public.image"]
            picker.sourceType = .photoLibrary
            picker.delegate = self
            
            picker.modalPresentationStyle = .pageSheet
            
            self.present(picker, animated: true, completion: nil)
        }
        
    }
    
}


extension MyProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func userImageSelected(image : UIImage?) {
        
        if let img = image {
            MyProfileEditor.shared.saveUserImage(image: img)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.userImageSelected(image: nil)
    }
    
    
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            self.userImageSelected(image: nil)
            return
        }
        self.userImageSelected(image: image)
    }
}
