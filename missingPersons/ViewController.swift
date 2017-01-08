//
//  ViewController.swift
//  missingPersons
//
//  Created by Henry McC on 2017/01/08.
//  Copyright © 2017 HiddenPlatform. All rights reserved.
//

import UIKit
import ProjectOxfordFace

class ViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var selectedIMG: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let imagePicker = UIImagePickerController()
    
    let missingPeople = [
    "person1.jpg",
    "person2.jpg",
    "person3.jpg",
    "person4.jpg",
    "person5.jpg",
    "person6.png"
    ]
    
    let baseURL = "http://localhost:6069/img/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.delegate = self
        collectionView.dataSource = self
        imagePicker.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.loadPicker(_:)))
        tap.numberOfTapsRequired = 1
        selectedIMG.addGestureRecognizer(tap)
        
        
    }

    
    @IBAction func checkForMatch(_ sender: Any) {
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return missingPeople.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonCell", for: indexPath) as! PersonCell
        //let url = "\(baseURL)\(missingPeople[indexPath.row])"
//        cell.configureCell(imgUrl: url)
        let url = "\(missingPeople[indexPath.row])"
        cell.configureLocalImage(imgUrl: url)
        return cell
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            selectedIMG.image = pickedImage
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    func loadPicker(_ sender: UITapGestureRecognizer){
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary  //can be .camera as well and would allow use of camera
        
        present(imagePicker,animated: true, completion: nil)
        
    }
    
}

