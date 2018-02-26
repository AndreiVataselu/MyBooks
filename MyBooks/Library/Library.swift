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
    
    func checkForExistingBookInLibrary(ISBN: String, bookExists: @escaping (Bool) -> Void){
        databaseReference!.child("users").child(User.id).child("books").observeSingleEvent(of: DataEventType.value) { (snapshot) in
            let value = snapshot.value as? NSDictionary ?? [:]
            if let _ = value[ISBN] {
                bookExists(true)
            } else {
                bookExists(false)
            }
        }
    }
    
    func prepareBook(ISBN: String, foundBook: @escaping (Bool?,Book?) -> Void){
        
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
                            
                            var book : Book?
                            
                            Networking.downloadImageFor(link: bookDetails["imageURL"]!, imageResult: { (image) in
                                book = Book(bookTitle: bookDetails["title"]!,
                                            bookAuthor: bookDetails["author"]!,
                                            bookNumOfPages: Int(bookDetails["pages"]!)!,
                                            bookPicture: image ,
                                            pagesRead: 0,
                                            imageURL: bookDetails["imageURL"]!,
                                            ISBN: ISBN)
                                foundBook(true,book)
                            })
                            
                        } else {
                            print("Book not found!")
                            foundBook(false,nil)
                        }
                    } else {
                        foundBook(false,nil)
                        print("Error - \(String(describing: errorXML))")
                    }
                }
            }
        }
    
