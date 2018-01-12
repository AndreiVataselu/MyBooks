//
//  User.swift
//  MyBooks
//
//  Created by Andrei Vataselu on 1/11/18.
//  Copyright © 2018 Andrei Vataselu. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase

class User {
    
    private init(){}
    
    static var id = (Auth.auth().currentUser?.uid)!
    
    static var isLoggedIn : Bool {
        if Auth.auth().currentUser != nil {
            return true
        } else {
            return false
        }
    }
    
    
   static func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            switch error {
                
            case .none:
                print("Registered account with email: \(email)")

            case .some(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func login(email: String, password: String, didLogin: @escaping (Bool) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            switch error {                
            case .none:
                print("Welcome, \(email)")
                didLogin(true)
            case .some(let error):
                print(error.localizedDescription)
                didLogin(false)
            }
        }
    }
    
    static func logout(didSignOut: @escaping (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            didSignOut(true)
            
        } catch {
            print("Couldn't Sign out! \(error)")
            didSignOut(false)
        }
    }
    
    static func fetchLibrary(_ library: @escaping (Library) -> Void) {
        let userLibrary = Library.newLibrary()
        
        databaseReference!.child("users").child(User.id).child("books").observeSingleEvent(of: DataEventType.value) { (snapshot) in
            let books = snapshot.value as? NSDictionary ?? [:]

            if books.count > 0 {
            
                var booksLoaded = 0
                
            for book in books {

                let fetchedBook = book.value as? [String:String] ?? [:]

                Networking.downloadImageFor(link: fetchedBook["imageURL"]!, imageResult: { (image) in
                    userLibrary.books.append(Book(bookTitle: fetchedBook["title"]!,
                                                  bookAuthor: fetchedBook["author"]!,
                                                  bookNumOfPages: Int(fetchedBook["pages"]!)!,
                                                  bookPicture: image))
                 booksLoaded += 1
                    if booksLoaded == books.count {
                        library(userLibrary)
                    }
                })
            }
            } else {
                library(userLibrary)
            }
        }
    }
}
