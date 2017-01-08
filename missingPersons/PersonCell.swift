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
    
    func configureLocalImage(imgUrl: String){
        personImage.image = UIImage(named: imgUrl)
    }
    
    
    func configureCell(imgUrl: String){
        if let url = URL(string: imgUrl){
            downloadImage(url: url)
        }
    }
    
    func downloadImage(url: URL){
        getDataFromURL(url: url) { (data, response, error) in
            DispatchQueue.main.async { () -> Void in
                guard let data = data as NSData?, error == nil else {return}
                //print("data: \(data)")
                //self.personImage.image = UIImage(data: data)
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
    
}
