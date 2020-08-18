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
            let fullName = value?["fullname"] as? String ?? ""
            let birthday = value?["birthday"] as? String ?? ""
            
            var user = User()
            user.mail = mail
            user.username = username
            user.birthday = birthday
            user.fullName = fullName
            completion?(user)
            
        }
        
    }
    
    func updateUserInfo(oldUserInfo: User, newUsername: String, newEmail:String, newFullName: String, newBirthday: String, completion: ((String?, Bool) -> ())? = nil) {
        
        if oldUserInfo.birthday == newBirthday && oldUserInfo.fullName == newFullName && oldUserInfo.mail == newEmail && oldUserInfo.username == newUsername {
            completion?("Everything is same.", false)
            return
        }
        if oldUserInfo.mail == newEmail && oldUserInfo.username != newUsername {
            self.ref.child("userInfos").queryOrdered(byChild: "username").queryEqual(toValue: newUsername).observeSingleEvent(of: .value) { (snapshot) in
                if snapshot.childrenCount == 0 {
                    var dictionary: [String:Any] = [:]
                    dictionary["fullname"] = newFullName
                    dictionary["email"] = newEmail
                    dictionary["birthday"] = newBirthday
                    dictionary["username"] = newUsername
                    
                    let userInfos = self.ref.child("userInfos").child(self.getCurrentID() ?? "")
                    userInfos.setValue(dictionary) { (error, _) in
                        if error == nil {
                            completion?(nil, false)
                            return
                        }
                        else {
                            completion?(error?.localizedDescription, false)
                        }
                    }
                }
                else {
                    completion?("Username already exists", false)
                }
                
            }
            
        }
        
        else if oldUserInfo.mail != newEmail && oldUserInfo.username == newUsername {
            
            self.updateEmail(newMail: newEmail) { (error) in
                if error == nil {
                    var dictionary: [String:Any] = [:]
                    dictionary["fullname"] = newFullName
                    dictionary["email"] = newEmail
                    dictionary["birthday"] = newBirthday
                    dictionary["username"] = newUsername
                    let userInfos = self.ref.child("userInfos").child(self.getCurrentID() ?? "")
                    userInfos.setValue(dictionary) { (error, _) in
                        if error == nil {
                            completion?(nil, true)
                            return
                        }
                        else {
                            completion?(error?.localizedDescription, true)
                        }
                    }
                }
                else {
                    completion?(error, false)
                }
            }
            
        }
        else if oldUserInfo.mail != newEmail && oldUserInfo.username != newUsername {
            self.ref.child("userInfos").queryOrdered(byChild: "username").queryEqual(toValue: newUsername).observeSingleEvent(of: .value) { (snapshot) in
                if snapshot.childrenCount == 0 {
                    self.updateEmail(newMail: newEmail) { (error) in
                        if error == nil {
                            var dictionary: [String:Any] = [:]
                            dictionary["fullname"] = newFullName
                            dictionary["email"] = newEmail
                            dictionary["birthday"] = newBirthday
                            dictionary["username"] = newUsername
                            
                            let userInfos = self.ref.child("userInfos").child(self.getCurrentID() ?? "")
                            userInfos.setValue(dictionary) { (error, _) in
                                if error == nil {
                                    completion?(nil, true)
                                    return
                                }
                                else {
                                    completion?(error?.localizedDescription, true)
                                }
                            }
                        }
                        else {
                            completion?(error, false)
                        }
                    }
                }
                else {
                    completion?("Username already exists", false)
                }
                
                
            }
            
        }
        
        else {
            var dictionary: [String:Any] = [:]
            dictionary["fullname"] = newFullName
            dictionary["email"] = newEmail
            dictionary["birthday"] = newBirthday
            dictionary["username"] = newUsername
            
            let userInfos = self.ref.child("userInfos").child(self.getCurrentID() ?? "")
            userInfos.setValue(dictionary) { (error, _) in
                if error == nil {
                    completion?(nil, false)
                    return
                }
                else {
                    completion?(error?.localizedDescription, false)
                }
            }
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
    
    func updateEmail(newMail: String, completion: ((String?) -> ())? = nil) {
        if self.signed() {
            Auth.auth().currentUser?.updateEmail(to: newMail, completion: { (error) in
                if error != nil{
                    completion?(error?.localizedDescription)
                    return
                }
                completion?(nil)
            })
            
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
