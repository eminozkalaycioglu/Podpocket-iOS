//
//  FirebaseConnection.swift
//  Podpocket
//
//  Created by Emin on 5.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase
class FirebaseConnection {
    
    private init() {
        
    }
    
    static let shared = FirebaseConnection()
    private var dbRef: DatabaseReference! = Database.database().reference()
    private var storageRef: StorageReference! = Storage.storage().reference()
    
    
    // USER ACTION FUNCTIONS
    func createUser(fullName: String, email: String, pass: String, username: String, birthday: String, completion: ((String?) -> ())? = nil) {
        
        
        if username.count <= 4 {
            completion?("Username must be at least 5 characters")
            return
        }
        
        if fullName.count <= 3 {
            completion?("Full name must be at least 4 characters")
            return
        }
        
        
        self.dbRef.child("userInfos").queryOrdered(byChild: "username").queryEqual(toValue: username).observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.childrenCount == 0 {
                 

                self.signUp(email: email, password: pass) { (error, uid)  in
                    
                    if let error = error {
                        completion?(error)
                        return
                    }
                    
                    self.saveWithInfos(email: email, fullName: fullName, uid: uid!, username: username, birthday: birthday)
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
        
        let userInfos = self.dbRef.child("userInfos").child(uid)
        userInfos.setValue(dictionary)
        
        self.saveProfilePhoto(image: UIImage(named: "profile")!)
        
    }
    
    func fetchUserInfo(uid: String, completion: ((User) -> ())? = nil) {
        
        self.dbRef.child("userInfos").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let username = value?["username"] as? String ?? ""
            let mail = value?["email"] as? String ?? ""
            let fullName = value?["fullname"] as? String ?? ""
            let birthday = value?["birthday"] as? String ?? ""
            let imageDataURL = value?["imageDataURL"] as? String ?? ""
            var user = User()
            
            user.mail = mail
            user.username = username
            user.birthday = birthday
            user.fullName = fullName
            user.imageURL = imageDataURL
            completion?(user)
            
        }
        
    }
    
    func updateUserInfo(oldUserInfo: User, newUsername: String, newEmail:String, newFullName: String, newBirthday: String, completion: ((String?, Bool) -> ())? = nil) {
        
        
        if oldUserInfo.birthday == newBirthday && oldUserInfo.fullName == newFullName && oldUserInfo.mail == newEmail && oldUserInfo.username == newUsername {
            completion?("Everything is same.", false)
            return
        }
        if oldUserInfo.mail == newEmail && oldUserInfo.username != newUsername {
            self.dbRef.child("userInfos").queryOrdered(byChild: "username").queryEqual(toValue: newUsername).observeSingleEvent(of: .value) { (snapshot) in
                if snapshot.childrenCount == 0 {
                    var dictionary: [String:Any] = [:]
                    dictionary["fullname"] = newFullName
                    dictionary["email"] = newEmail
                    dictionary["birthday"] = newBirthday
                    dictionary["username"] = newUsername
                    
                    let userInfos = self.dbRef.child("userInfos").child(self.getCurrentID() ?? "")
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
                    let userInfos = self.dbRef.child("userInfos").child(self.getCurrentID() ?? "")
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
            self.dbRef.child("userInfos").queryOrdered(byChild: "username").queryEqual(toValue: newUsername).observeSingleEvent(of: .value) { (snapshot) in
                if snapshot.childrenCount == 0 {
                    self.updateEmail(newMail: newEmail) { (error) in
                        if error == nil {
                            var dictionary: [String:Any] = [:]
                            dictionary["fullname"] = newFullName
                            dictionary["email"] = newEmail
                            dictionary["birthday"] = newBirthday
                            dictionary["username"] = newUsername
                            
                            let userInfos = self.dbRef.child("userInfos").child(self.getCurrentID() ?? "")
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
            
            let userInfos = self.dbRef.child("userInfos").child(self.getCurrentID() ?? "")
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
            
            completion?(nil)
        }
    }
    
    func signUp(email: String, password: String, completion: ((String?, String?) -> ())? = nil) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let uid = user?.user.uid else {
                completion?("uid not found", nil)
                return
            }
            if error != nil {
                completion?(error?.localizedDescription, uid)
                return
            }
            
            completion?(nil, uid)

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
    
    func signOut() -> Bool {
        do{
            try Auth.auth().signOut()
            
            return true
        } catch {
            return false
        }
    }
    
    func signed() -> Bool {
        
        return Auth.auth().currentUser == nil ? false : true
        
    }
    
    
    // FAVORITE FUNCTIONS
    func fetchAllFavoritedEpisodes(completion: (([FavoritedEpisodeModel])->())? = nil) {
        
        self.dbRef.child("favoritedEpisodes").observeSingleEvent(of: .value) { (snapshot) in
            
            var favoritedEpisodes = [FavoritedEpisodeModel]()
            favoritedEpisodes.removeAll()
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let value = child.value as? NSDictionary
                
                if (value?["\(self.getCurrentID() ?? "")"]) != nil {
                    let info = value?["episodeInformation"] as? NSDictionary
                    let title = info?["title"] as? String ?? ""
                    let pubDateMs = info?["pubDateMs"] as? Int ?? 0
                    
                    favoritedEpisodes.append(FavoritedEpisodeModel(episodeId: child.key, title: title, pubDateMs: pubDateMs))
                }
                
            }
            completion?(favoritedEpisodes)
        }
    }
    
    private func fetchFavoritedEpisode(episodeId: String, completion: ((DataSnapshot)->())? = nil) {
        
        self.dbRef.child("favoritedEpisodes").child(episodeId).observeSingleEvent(of: .value) { (snapshot) in
            
            completion?(snapshot)
            return
        }
    }
    
    func fetchNumberOfFavorites(episodeId: String, completion: ((Int)->())? = nil) {
        
        if self.signed() {
            self.fetchFavoritedEpisode(episodeId: episodeId) { (snapshot) in
                
                let count = Int(snapshot.childrenCount)
                completion?(count == 0 ? 0 : count - 1)
            }
        }
        
        
        
    }
    
    func isEpisodeFavorited(episodeId: String, completion: ((Bool)->())? = nil) {
        
        guard let uid = self.getCurrentID() else { return }
        
        self.fetchFavoritedEpisode(episodeId: episodeId) { (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                if child.key == uid {
                    completion?(true)
                    return
                }
            }
            completion?(false)
            return
        }
    }
    
    func removeEpisodeFromFavoriteList(episodeId: String) {
        self.dbRef.child("favoritedEpisodes").child(episodeId).child(self.getCurrentID() ?? "").removeValue()
    }
    
    func addEpisodeToFavoriteList(episodeId: String, title: String, pubDateMs: Int) {
        
        self.dbRef.child("favoritedEpisodes").child(episodeId).child("episodeInformation").setValue([
            "title" : title,
            "pubDateMs" : pubDateMs
        ])
        self.dbRef.child("favoritedEpisodes").child(episodeId).updateChildValues([self.getCurrentID() ?? "" : ""])
        
    }
    
    func observeFavorites(episodeId: String, completion: ((Bool)->())? = nil) {
        
        self.dbRef.child("favoritedEpisodes").child(episodeId).observe(.childAdded) { (_) in
            completion?(true)
        }
        
        self.dbRef.child("favoritedEpisodes").child(episodeId).observe(.childRemoved) { (_) in
            completion?(true)
        }
        
    }

    
    
    // FEED MESSAGE FUNCTIONS
    func deleteMessage(messageId: String) {
        self.dbRef.child("sharedMessages").child(messageId).removeValue()
        
    }
    
    func observeMessages(completion: ((Bool)->())? = nil) {
        
        let messages = self.dbRef.child("sharedMessages")
        messages.observe(.childAdded) { (_ ) in
            completion?(true)
        }
        
        messages.observe(.childRemoved) { (_ ) in
            completion?(true)
        }
    }
    
    func fetchAllMessages(type: FetchType, completion: (([MessageModel])->())? = nil) {
        
        var messagesArray = [MessageModel]()
        messagesArray.removeAll()
        
        let messages = self.dbRef.child("sharedMessages")
        let currentCountryCode = Locale.current.regionCode ?? "TR"
        
        
        
        messages.observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let value = child.value as? NSDictionary
                let message = value?["message"] as? String ?? ""
                let countryCode = value?["countryCode"] as? String ?? "TR"
                let date = value?["date"] as? String ?? ""
                let uid = value?["uid"] as? String ?? ""
                let messageId = child.key
                
                switch type {
                case .Local:
                    if currentCountryCode == countryCode {
                        messagesArray.append(MessageModel(id: messageId, countryCode: countryCode, date: date, message: message, uid: uid))
                    }
                    
                case .Worldwide:
                    messagesArray.append(MessageModel(id: messageId, countryCode: countryCode, date: date, message: message, uid: uid))
                }
                
                
                
                
            }
            
            completion?(messagesArray)
        }
    }
    
    func shareMessage(message: String, completion: ((Bool)->())? = nil) {
        
        let newMessage = self.dbRef.child("sharedMessages").childByAutoId()
        var dictionary: [String: Any] = [:]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: Date())
        
        if let countryCode = Locale.current.regionCode {
            dictionary["countryCode"] = countryCode
        }
        
        dictionary["message"] = message
        dictionary["uid"] = self.getCurrentID()!
        dictionary["date"] = dateString
        
        newMessage.setValue(dictionary) { (error, _) in
            if error == nil {
                completion?(true)
                return
            }
            completion?(false)
            return
            
        }
    }
    
    
    // PROFILE PHOTO FUNCTIONS (FIREBASE STORAGE)
    func saveProfilePhoto(image: UIImage) {
        
        
        if let uid = self.getCurrentID() {
            
            let imageRef = self.storageRef.child("UserProfilePhotos").child(uid)
            
            _ = imageRef.putData(image.jpegData(compressionQuality: 0.05) ?? Data(), metadata: nil) { (metadata, error) in
                guard metadata != nil else {
                    
                    return
                }
                
                imageRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        return
                    }
                    
                    self.dbRef.child("userInfos").child(uid).updateChildValues(["imageDataURL" : downloadURL.absoluteString]) { (error, _) in
                        if let error = error {
                            print("child error !!!!!! \(error) ")
                            
                        }
                    }
                    
                }
            }
            
            
        }
    }
    
    func fetchProfilePhoto(uid: String, completion: ((UIImage)->())? = nil) {
        
        if self.signed() && uid.count != 0 {
            self.dbRef.child("userInfos").child(uid).child("imageDataURL").observeSingleEvent(of: .value) { (snapshot) in
                
                let dataURL = snapshot.value as? String
                
                let imgRef = Storage.storage().reference(forURL: dataURL ?? "https://firebasestorage.googleapis.com/v0/b/podpocket-ios.appspot.com/o/UserProfilePhotos%2FGXyCLcbTvNSPoXl0ghRoHIuP6sg1?alt=media&token=bed9e1ca-968d-4dc1-a10f-cd0b97b5ec74")
                
                
                imgRef.getData(maxSize: 100 * 1024 * 1024) { (data, error) -> Void in
                    
                    if error == nil, let data = data {
                        
                        let profileImage = UIImage(data: data)
                        completion?(profileImage ?? UIImage())
                        
                    }
                    
                    else {
                        print(error.debugDescription)
                    }
                    
                    
                }
                
                
            }
        }
        
    }

    
    
    
}
