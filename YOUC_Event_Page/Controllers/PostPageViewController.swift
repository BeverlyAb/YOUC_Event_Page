//
//  PostPageViewController.swift
//  YOUC_Event_Page
//
//  Created by Beverly Abadines on 3/4/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse


//should split, texts, location, & cover album, into 3 viewcontrollers
// need back button in between
class PostPageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var eventNameField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var coverView: UIImageView!
    @IBOutlet weak var tagField: UITextField!
    
    @IBOutlet weak var dateValueField: UITextField!
    
    @IBAction func onSubmitButton(_ sender: Any) {
        let post = PFObject(className: "Events")
        
        post["author"] = PFUser.current()!
        post["eventName"] = eventNameField.text!
        post["description"] = descriptionField.text!
       // post["location"] =
        post["date"] = dateValueField.text!
        let imageData = coverView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        post["coverImage"] = file
        
        post.saveInBackground{(success, error) in
            if (success){
                self.dismiss(animated: true, completion: nil)
                print("saved")
            }else {
                print("fail")
            }
            
        }
    }
    //-----------------------Date--------------------------------------
    
    @IBAction func datePickerChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        dateValueField.text = dateFormatter.string(from: (sender as AnyObject).date)

    }
    
    //-----------------------Album Cover--------------------------------
    @IBAction func onShootButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else{
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        //resize
        let size = CGSize(width:300, height:300)
        let scaledImg = image.af_imageAspectScaled(toFill: size)
        
        coverView.image = scaledImg
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    


}
