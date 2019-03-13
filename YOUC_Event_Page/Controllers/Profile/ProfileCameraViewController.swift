//
//  ProfileCameraViewController.swift
//  YOUC_Event_Page
//
//  Created by Hermain Hanif on 3/11/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class ProfileCameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var profileUserImage: UIImageView!
    
//    @IBOutlet weak var profileUserImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func onUserSubmitButton(_ sender: Any) {
        let user = PFUser.current()!
        
        let imageProfileData = profileUserImage.image!.pngData()
        let profileFile = PFFileObject(data: imageProfileData!)
        
        user["user_image"] = profileFile
        
        user.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("saved image!")
            } else {
                print("error!")
            }
        }
    }
    
    
//    @IBAction func onUserSubmitButton(_ sender: Any) {
//        let user = PFUser.current()!
//
//        let imageProfileData = profileUserImage.image!.pngData()
//        let profileFile = PFFileObject(data: imageProfileData!)
//
//        user["user_image"] = profileFile
//
//        user.saveInBackground { (success, error) in
//            if success {
//                self.dismiss(animated: true, completion: nil)
//                print("saved image!")
//            } else {
//                print("error!")
//            }
//        }
//    }
    
    
    @IBAction func cameraButtonClicked(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        // when user done picking photo, let me know what they took, and call me back on function that has photo
        picker.allowsEditing = true
        // allows second screen to come up to allow editing on photo
        
        // if camera available
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
//    @IBAction func cameraButtonClicked(_ sender: Any) {
//        let picker = UIImagePickerController()
//        picker.delegate = self
//        // when user done picking photo, let me know what they took, and call me back on function that has photo
//        picker.allowsEditing = true
//        // allows second screen to come up to allow editing on photo
//
//        // if camera available
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            picker.sourceType = .camera
//        } else {
//            picker.sourceType = .photoLibrary
//        }
//
//        present(picker, animated: true, completion: nil)
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        profileUserImage.image = scaledImage
        
        dismiss(animated: true, completion: nil)
        // dismiss that camera view
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

