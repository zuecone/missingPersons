//
//  ViewController.swift
//  missingPersons
//
//  Created by Henry McC on 2017/01/08.
//  Copyright © 2017 HiddenPlatform. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var selectedIMG: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
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
    
}

