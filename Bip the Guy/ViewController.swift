//
//  ViewController.swift
//  Bip the Guy
//
//  Created by Nick on 2/6/17.
//  Copyright © 2017 Nick Ryan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //Mark: Properties
    @IBOutlet weak var imageToPunch: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var audioPlayer = AVAudioPlayer()
    var imagePicker = UIImagePickerController()
    //Mark: Functions
    func animateImage() {
        let bounds = self.imageToPunch.bounds
        let shrinkValue : CGFloat = 60
        //shrink image by 60 pixels
        self.imageToPunch.bounds = CGRect(x: self.imageToPunch.bounds.origin.x + shrinkValue, y: self.imageToPunch.bounds.origin.y + shrinkValue, width: self.imageToPunch.bounds.size.width - shrinkValue, height: self.imageToPunch.bounds.size.height - shrinkValue)
        //resize animation
        UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: [], animations: { self.imageToPunch.bounds = bounds  }, completion: nil)
    }
    func playSound(soundName: String) {
        if let sound = NSDataAsset(name: soundName) {
            //play
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            }
            catch {
                print("ERROR: File \(soundName) is not a usable sound")
            }
        } else {
            print("ERROR: File \(soundName) could not load.")
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageToPunch.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)

    }
    func showError(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil
        )
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    //Mark: Actions
    @IBAction func photoTake(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        } else {
            showError(title: "Error", message: "You do not have camera access.")
        }
    }

    @IBAction func photoLibrary(_ sender: UIButton) {

        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }

    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        animateImage()
playSound(soundName: "punchSound")
        //Adding a second parameter to the argument continously resulted in the error "use of unresolved identifier," despite my code being the same as the example. not sure how to fix that.
    }
}

