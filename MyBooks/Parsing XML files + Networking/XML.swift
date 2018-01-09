//
//  XML.swift
//  MyBooks
//
//  Created by Andrei Vataselu on 1/8/18.
//  Copyright © 2018 Andrei Vataselu. All rights reserved.
//

import Foundation
import SWXMLHash

class XML {
    
    var xmlFile : XMLIndexer
    var validFile : Bool
    
    init(xmlResponse: XMLIndexer) {
        xmlFile = xmlResponse
        
        switch xmlFile["error"] {
        case .element(_):
            validFile = false
        default: validFile = true
        }
        
    }
    
    func getBookDetails() -> [String:String] {
        
        var bookDetails = [String: String]()
        
        //MARK: Book title
        switch xmlFile["GoodreadsResponse"]["book"]["title"] {
        case .element(let title):
            bookDetails["title"] = title.text
        case .xmlError(let error):
            print("Error book title -> \(error)")
        
        default: break
        }
        
        //MARK: Book author
        switch xmlFile["GoodreadsResponse"]["book"]["authors"]["author"]["name"] {
        case .element(let authorName):
            bookDetails["author"] = authorName.text
        case .xmlError(let error):
            print("Error author name -> \(error)")
            
        default:break
        }
        
        //MARK: No. of pages
        
        
        //MARK: Book image
        
        return bookDetails
    }
}
