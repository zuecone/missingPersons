//
//  PersonCell.swift
//  missingPersons
//
//  Created by Henry McC on 2017/01/08.
//  Copyright © 2017 HiddenPlatform. All rights reserved.
//

import UIKit

class PersonCell: UICollectionViewCell {
    
    @IBOutlet weak var personImage: UIImageView!
    var person: Person!
    
    func configureLocalImage(person: Person){
        self.personImage.image = UIImage(named: person.personImageUrl!)
        person.personImage = self.personImage.image
        //person.downloadFaceId() removed due to setSelected
    }
    
    
    func configureCell(person: Person){
        self.person = person
        if let url = URL(string: "\(baseURL)\(person.personImageUrl!)"){
            downloadImage(url: url)
        }
    }
    
    func downloadImage(url: URL){
        getDataFromURL(url: url) { (data, response, error) in
            DispatchQueue.main.async { () -> Void in
                guard let data = data as NSData?, error == nil else {return}
                //print("data: \(data)")
                //self.personImage.image = UIImage(data: data)
                self.person.personImage = self.personImage.image
                //
        }
        }
    }
    
    func getDataFromURL(url: URL, completion: @escaping ((_ data: NSData?,_ response: URLResponse?, _ error: NSError?) -> Void)){
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        session.dataTask(with: url) { (data, response, error) in
//            print("data: \(data)")
//            print("response: \(response)")
//            print("error: \(error)")
            completion(data as NSData?,response as URLResponse?, error as NSError?)
            }.resume()
        
    }
    
    func setSelected(person: Person){
        self.person = person
        personImage.layer.borderWidth = 2.0
        personImage.layer.borderColor = UIColor.yellow.cgColor
        person.personImage = self.personImage.image
        person.downloadFaceId()
    }
    
}
