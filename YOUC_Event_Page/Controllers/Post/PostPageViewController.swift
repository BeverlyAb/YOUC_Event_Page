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


protocol PostPageViewControllerDelegate : class {
    func locationsPickedLocation(controller: PostPageViewController, latitude: NSNumber, longitude: NSNumber)
}


class PostPageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PickMapViewControllerDelegate {
    
    
    @IBOutlet weak var eventNameField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    weak var delegate : PostPageViewControllerDelegate!
    
    @IBOutlet weak var coverView: UIImageView!

    @IBOutlet weak var dateValueField: UITextField!
    var location : CLLocation!
    var lat : Double!
    var long : Double!
    
    @IBAction func onSubmitButton(_ sender: Any) {
        let post = PFObject(className: "Events")

        if (dataChecker()){
            post["author"] = PFUser.current()!
            post["eventName"] = eventNameField.text!
            post["description"] = descriptionField.text!
            post["location"] =  PFGeoPoint(latitude: lat, longitude: long)
            post["date"] = dateValueField.text!
            let imageData = coverView.image!.pngData()
            let file = PFFileObject(data: imageData!)
            post["coverImage"] = file
            //post["tags"] = array of strings

            post.saveInBackground{(success, error) in
                if (success){
                    self.dismiss(animated: true, completion: nil)
                    print("saved")
                }else {
                    self.createAlert(title: "Uh Oh,", message: "Post could not be saved")
                }

                }
        } else {
            self.createAlert(title: "Uh Oh,", message: "Event, Date, Description, & Location must be filled")
        }
    }
    //-----------------------All data filled? (blank img ok)-------------------------
    func dataChecker()->Bool{
        return (    PFUser.current() != nil &&
                    eventNameField.text != nil &&
                    descriptionField.text != nil &&
                    lat != nil &&
                    long != nil)
    }
    
    //-----------------------Date--------------------------------------
    
    @IBAction func datePickerChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        dateValueField.text = dateFormatter.string(from: (sender as AnyObject).date)
    }
    //----------------------Location----------------------------------
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let pickMapViewController = segue.destination as! PickMapViewController
        pickMapViewController.delegate = self
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
    
    //save location points from segue
    func locationsPickedLocation(controller: PickMapViewController, latitude: NSNumber, longitude: NSNumber) {
            lat = Double(truncating: latitude)
            long = Double(truncating: longitude)
    }

    //-------------------------error screen-------------------------
    func createAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert,animated: true, completion: nil)
    }
}
