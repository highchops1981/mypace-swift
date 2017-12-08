//
//  FirebaseDatabaseUtil.swift
//  silentcamera+firestorage+offline
//
//  Created by keisuke ishikura on 2017/12/08.
//

import Foundation
import FirebaseDatabase

class FirebaseDatabaseUtil {
    
    static let ref: DatabaseReference = Database.database().reference()
    
    static let connectedRef = Database.database().reference(withPath: ".info/connected")
    
    static func offline() {
        Database.database().isPersistenceEnabled = true
    }
    
    static func networkStatusListener(connect:@escaping () -> Void,disconnect:@escaping () -> Void) {
        
        connectedRef.observe(.value, with: { snapshot in
            if snapshot.value as? Bool ?? false {
                
                print("Connected")
                connect()
                
            } else {
                
                print("Not connected")
                disconnect()
                
            }
        })
        
    }
    
}
