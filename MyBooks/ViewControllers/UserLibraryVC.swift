//
//  UserLibraryVC.swift
//  MyBooks
//
//  Created by Andrei Vataselu on 1/13/18.
//  Copyright © 2018 Andrei Vataselu. All rights reserved.
//

import UIKit

class UserLibraryVC: UIViewController {
    
    @IBOutlet weak var collectionView : UICollectionView!
    var userLibrary : Library?

    override func viewDidLoad() {
        super.viewDidLoad()

        User.login(email: "vataseluandrei1@gmail.com", password: "parolamea") { (_) in
            User.fetchLibrary { (library) in
                self.userLibrary = library

                self.collectionView.reloadData()
            }
        }        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
