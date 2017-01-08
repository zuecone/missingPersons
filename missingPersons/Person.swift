//
//  Person.swift
//  missingPersons
//
//  Created by Henry McC on 2017/01/08.
//  Copyright © 2017 HiddenPlatform. All rights reserved.
//

import UIKit
import ProjectOxfordFace

class Person{
    
    var faceId: String?
    var personImage: UIImage?
    var personImageUrl: String?
    
    init(personImageUrl: String){
        self.personImageUrl = personImageUrl
    }
    
    
    func downloadFaceId(){
        if let img = personImage, let imgData = UIImageJPEGRepresentation(img, 0.8){
            FaceService.instance.client?.detect(with: imgData, returnFaceId: true, returnFaceLandmarks: false, returnFaceAttributes: nil, completionBlock: { (faces:[MPOFace]?, err:Error?) in
                if err == nil{
                    var faceId: String?
                    for face in faces!{
                        faceId = face.faceId
                        print("FaceId: \(faceId)")
                        break
                    }
                     self.faceId = faceId
                    
                }
            })
        }
        
    }
    
    
}
