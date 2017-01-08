//
//  ViewController.swift
//  missingPersons
//
//  Created by Henry McC on 2017/01/08.
//  Copyright © 2017 HiddenPlatform. All rights reserved.
//

import UIKit
import ProjectOxfordFace

let baseURL = "http://localhost:6069/img/"


class ViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var selectedIMG: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedPerson: Person?
    var hasSelectedImage: Bool = false
    
    let imagePicker = UIImagePickerController()
    
    let missingPeople = [
        Person(personImageUrl: "person1.jpg"),
        Person(personImageUrl: "person2.jpg"),
        Person(personImageUrl: "person3.jpg"),
        Person(personImageUrl: "person4.jpg"),
        Person(personImageUrl: "person5.jpg"),
        Person(personImageUrl: "person6.png")]
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedPerson = missingPeople[indexPath.row]
        let cell = collectionView.cellForItem(at: indexPath) as! PersonCell 
       cell.configureLocalImage(person: selectedPerson!)
        cell.setSelected(person: selectedPerson!)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return missingPeople.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonCell", for: indexPath) as! PersonCell
        let person = missingPeople[indexPath.row]
        //use this
        cell.configureLocalImage(person: person)
        //instead of this
        //        cell.configureCell(person: person)
        return cell
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            selectedIMG.image = pickedImage
            hasSelectedImage = true
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    func loadPicker(_ sender: UITapGestureRecognizer){
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary  //can be .camera as well and would allow use of camera
        
        present(imagePicker,animated: true, completion: nil)
        
    }
    
    func showErrorAlert(){
        let alert = UIAlertController(title: "Select Person & Image", message: "Please select a missing person and image from your album to check", preferredStyle: UIAlertControllerStyle.alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)

    }
    
    @IBAction func checkMatch(send: AnyObject){
        if selectedPerson == nil || !hasSelectedImage {
            showErrorAlert()
        }else{
            
            FaceService.instance.client?.verify(withFirstFaceId: <#T##String!#>, faceId2: <#T##String!#>, completionBlock: <#T##((MPOVerifyResult?, Error?) -> Void)!##((MPOVerifyResult?, Error?) -> Void)!##(MPOVerifyResult?, Error?) -> Void#>)
            selectedPerson!.downloadFaceId()
        }
    }
    
}

