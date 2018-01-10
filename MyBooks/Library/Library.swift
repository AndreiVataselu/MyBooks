//
//  Library.swift
//  MyBooks
//
//  Created by Andrei Vataselu on 1/10/18.
//  Copyright © 2018 Andrei Vataselu. All rights reserved.
//

import Foundation

class Library {
    
    var books : [Book]
    
    private init(books : [Book]){
        self.books = books
    }
    
    static func newLibrary(books : [Book]) -> Library {
        return Library(books: books)
    }
    
}
