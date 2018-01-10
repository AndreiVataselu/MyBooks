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


class Library {
    
    var books : [Book]
    
    private init(){
        self.books = [Book]()
    }
    
    static func newLibrary() -> Library {
        return Library()
    }
    
    func addBook(ISBN: String, foundBook: @escaping (Bool) -> Void){
        
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
                    
                    var bookImage = UIImage()
                    
                    Networking.downloadImageFor(link: bookDetails["imageURL"]!, imageResult: { (image) in
                        bookImage = image
                        
                    })
                    
                    self.books.append(Book(bookTitle: bookDetails["title"]!,
                                                      bookAuthor: bookDetails["author"]!,
                                                      bookNumOfPages: Int(bookDetails["pages"]!)!,
                                                      bookPicture: bookImage))
                    
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
