//
//  ViewController.swift
//  TestScan
//
//  Created by Infaz Ariff on 1/16/18.
//  Copyright © 2018 Saberion. All rights reserved.
//

import UIKit
import MobileCoreServices
import TesseractOCR

class ViewController: UIViewController, TomarImageReaderDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, G8TesseractDelegate {
    
    @IBOutlet weak var capturedTxtView: UITextView!
    func sucess(withText cardInfo: [AnyHashable : Any]?) {
        print(cardInfo ?? "nothing")
        print(cardInfo!["name"])
        capturedTxtView.text = "\(cardInfo)"
    }
    
    func failedTextReader(_ error: Error?) {
        
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        showCamera()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showCamera() {
        //Image picker
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.mediaTypes = [(kUTTypeImage as String)]
        
        //Create the AlertController and add Its action like button in Actionsheet
        let actionSheetController: UIAlertController

        actionSheetController = UIAlertController(title:nil, message:nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { void in
            print("Cancel")
        }
        
        actionSheetController.addAction(cancelActionButton)
        
        let takeActionButton: UIAlertAction = UIAlertAction(title: "Take Photo", style: UIAlertActionStyle.default) { void in
            print("Take Photo")
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraDevice = UIImagePickerControllerCameraDevice.rear
            self.present(picker, animated: true, completion: nil)
        }
        
        actionSheetController.addAction(takeActionButton)
        
        let chooseActionButton: UIAlertAction = UIAlertAction(title: "Choose Photo", style: UIAlertActionStyle.default)
        { void in
            print("Choose Photo")
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.present(picker, animated: true, completion: nil)
        }
        
        actionSheetController.addAction(chooseActionButton)
        self.present(actionSheetController, animated: true, completion: nil)
    }

    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let imageReader = TomarImageReader()
        imageReader.performRecognition(with: selectedImage)
        imageReader.delegate = self
        
        
        
        
//        let tesseract = G8Tesseract.init(language: "eng")
//        tesseract?.delegate = self;
//        tesseract?.charWhitelist = "0123456789";
//        tesseract?.image = selectedImage.g8_grayScale()
//        tesseract?.rect = CGRect(x: 20, y: 20, width: 100, height: 100)
//        tesseract?.maximumRecognitionTime = 2.0;
//        tesseract?.recognize()
//
//        print(tesseract?.recognizedText ?? "nothing")
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)

    }

}

