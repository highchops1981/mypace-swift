//
//  Upload.swift
//  silentcamera+firestorage+offline
//
//  Created by keisuke ishikura on 2017/12/08.
//

import Foundation
import Firebase

struct InData {
    
    let domain:String
    let imageName:String
    let image:UIImage
    let customMetadata:[String:String]
    
    init(domain:String, imageName:String, image:UIImage, customMetadata:[String:String]){
        
        self.domain = domain
        self.imageName = imageName
        self.image = image
        self.customMetadata = customMetadata
        
    }
    
}

class Upload: NSObject {
    
    static let sharedUploadImage = Upload()
    
    var storage:Storage
    var storageRef:StorageReference
    var inDatas:[InData] = []
    var putTask:StorageUploadTask? = nil
    
    override private init() {
        
        storage = Storage.storage()
        storageRef = storage.reference()
        
        super.init()
        
    }
    
    func storeInData(inData: InData) {
        
        inDatas.append(inData)
        
    }
    
    func put() {
        
        print(":::::put")
        
        if inDatas.count != 0 {
            
            print(":::::put go:::::\(inDatas)")
            
            let inData = inDatas[0]
            Upload.sharedUploadImage.upload(domain: inData.domain, imageName: inData.imageName, image: inData.image, customMetadata:inData.customMetadata)
            
        }
        
    }
    
    func cancel() {
        
        print(":::::put cancel")
        
        putTask?.cancel()
        
    }
    
    func upload(domain:String, imageName:String, image:UIImage, customMetadata:[String : String]) {
        
        print(":::::upload")
        
        let url = domain + imageName
        
        let ref = storageRef.child(url)
        
        let imageData = UIImageJPEGRepresentation(image, 1.0)!
        
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        
        meta.customMetadata = customMetadata
        
        putTask = ref.putData(imageData, metadata: meta)
        
        putTask?.observe(.success) { snapshot in
            
            print(":::::upload success")
            
            if self.inDatas.count != 0 {
                self.inDatas.remove(at: 0)
            }
            self.put()
            
        }
        
        putTask?.observe(.failure) { snapshot in
            if let error = snapshot.error as NSError? {
                switch (StorageErrorCode(rawValue: error.code)!) {
                case .objectNotFound:
                    break
                case .unauthorized:
                    break
                case .cancelled:
                    
                    print(":::::upload cancelled")
                    break
                case .unknown:
                    break
                default:
                    break
                }
            }
        }
        
    }
    
}
