//
//  Library.swift
//  MyBooks
//
//  Created by Andrei Vataselu on 1/10/18.
//  Copyright © 2018 Andrei Vataselu. All rights reserved.
//

import Foundation
import Kingfisher
import SWXMLHash
import Firebase

var databaseReference : DatabaseReference?

class Library {
    
    var books : [Book]
    
    private init(){
        self.books = [Book]()
    }
    
    static func newLibrary() -> Library {
        return Library()
    }
    
    func checkForExistingBook(ISBN: String, bookExists: @escaping (Bool) -> Void){
        databaseReference!.child("users").child(User.id).child("books").observeSingleEvent(of: DataEventType.value) { (snapshot) in
            let value = snapshot.value as? NSDictionary ?? [:]
            if let _ = value[ISBN] {
                bookExists(true)
            } else {
                bookExists(false)
            }
        }
    }
    
    func addBookToDatabase(ISBN: String, foundBook: @escaping (Bool) -> Void){
        
        var xmlFile : XML?
        var errorXML : Error?
        
                Networking.getXMLfor(ISBN: ISBN) { (response) in
                    switch response {
                    case .success(let data):
                        xmlFile = XML(xmlResponse: data)
                        
                    case .failed(let error):
                        errorXML = error
                    }
                    
                    if let xmlIsSuccesful = xmlFile {
                        if xmlIsSuccesful.validFile {
                            let bookDetails = xmlIsSuccesful.getBookDetails()
                            
                            //MARK: Adding book to DB.
                            databaseReference!.child("users").child(User.id).child("books").child(ISBN).setValue(bookDetails)
                            
                            foundBook(true)
                            
                        } else {
                            print("Book not found!")
                            foundBook(false)
                        }
                    } else {
                        foundBook(false)
                        print("Error - \(String(describing: errorXML))")
                    }
                }
            }
        }
    
