//
//  AddBookVC.swift
//  MyBooks
//
//  Created by Andrei Vataselu on 2/25/18.
//  Copyright © 2018 Andrei Vataselu. All rights reserved.
//

import UIKit
import Firebase

class AddBookVC: UIViewController {
    
    
    @IBOutlet weak var bookImage : UIImageView!
    @IBOutlet weak var bookName : UILabel!
    @IBOutlet weak var pagesReadTextField : UITextField!
    @IBOutlet weak var bookPages : UILabel!

    var book : Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let book = book {
        bookImage.image = book.picture
        bookName.text = book.title
        bookPages.text = "/\(book.numberOfPages)"
        }
    }
    
    @IBAction func submitToDatabase(sender: UIButton) {
        if pagesReadTextField.text != "" {
            book!.pagesRead = Int(pagesReadTextField.text!)!
        }
   
        var bookDetails = [String:String]()
        bookDetails["title"] = book!.title
        bookDetails["author"] = book!.author
        bookDetails["numberOfPages"] = "\(book!.numberOfPages)"
        bookDetails["pagesRead"] = "\(book!.pagesRead)"
        bookDetails["imageURL"] = book!.imageURL
        bookDetails["ISBN"] = book!.ISBN
        
    databaseReference!.child("users").child(User.id).child("books").child(bookDetails["ISBN"]!).setValue(bookDetails)
        
        navigationController?.popViewController(animated: true)
    }
}
