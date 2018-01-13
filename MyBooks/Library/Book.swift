//
//  Book.swift
//  MyBooks
//
//  Created by Andrei Vataselu on 1/10/18.
//  Copyright © 2018 Andrei Vataselu. All rights reserved.
//

import Foundation
import UIKit

struct Book {
    var title : String
    var author : String
    var numberOfPages : Int
    var picture : UIImage
    var pagesRead : Int
    
    init(bookTitle: String, bookAuthor: String, bookNumOfPages: Int, bookPicture: UIImage, pagesRead: Int) {
        self.title = bookTitle
        self.author = bookAuthor
        self.numberOfPages = bookNumOfPages
        self.picture = bookPicture
        self.pagesRead = pagesRead
    }
}

