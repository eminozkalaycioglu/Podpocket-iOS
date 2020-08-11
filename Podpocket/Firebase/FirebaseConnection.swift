//
//  FirebaseConnection.swift
//  Podpocket
//
//  Created by Emin on 5.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation
import Firebase

class FirebaseConnection {
    
    private init() {
        
    }
    
    static let shared = FirebaseConnection()
    private var ref: DatabaseReference! = Database.database().reference()
    
    func createUser(fullName: String, email: String, pass: String, username: String, birthday: String, completion: ((String?) -> ())? = nil) {
        self.ref.child("userInfos").queryOrdered(byChild: "username").queryEqual(toValue: username).observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.childrenCount == 0 {
                Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                    if error != nil {
                        
                        completion?(error?.localizedDescription)
                        return
                    }
                    
                    
                    guard let uid = user?.user.uid else {
                        completion?("uid not found")
                        return
                    }
                    
                    
                    
                    self.saveWithInfos(email: email, fullName: fullName, uid: uid, username: username, birthday: birthday)
                    
                    completion?(nil)
                }
            }
            else {
                completion?("Username already exists")
            }
            
            
        }
        
        
        
    }
    
    private func saveWithInfos(email: String, fullName: String, uid: String, username: String, birthday: String) {
        
        var dictionary: [String:Any] = [:]
        dictionary["fullname"] = fullName
        dictionary["uid"] = uid
        dictionary["email"] = email
        dictionary["birthday"] = birthday
        dictionary["username"] = username
        
        let userInfos = self.ref.child("userInfos").child(uid)
        userInfos.setValue(dictionary)
        
    }
    
    func fetchUserInfo(uid: String, completion: ((User?) -> ())? = nil) {
        
        self.ref.child("userInfos").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let username = value?["username"] as? String ?? ""
            let mail = value?["email"] as? String ?? ""
            
            var user = User()
            user.mail = mail
            user.username = username
            completion?(user)
            
        }
        
    }
    
    func signIn(withEmail email: String, password: String, _ completion: ((String?) -> ())? = nil){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil{
                completion?(error?.localizedDescription)
                return
            }
            if let uid = user?.user.uid {
                print("uid: ", uid)
            }
            completion?(nil)
        }
    }
    
    func getCurrentID() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    func signOut() -> Bool{
        do{
            try Auth.auth().signOut()
            
            return true
        }catch{
            return false
        }
    }
    
    
    
    func signed() -> Bool {
        return Auth.auth().currentUser == nil ? false : true
        
    }
    
}
