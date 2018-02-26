//
//  UserLibraryVC.swift
//  MyBooks
//
//  Created by Andrei Vataselu on 1/13/18.
//  Copyright © 2018 Andrei Vataselu. All rights reserved.
//

import UIKit
import BarcodeScanner

class UserLibraryVC: UIViewController {
    
    @IBOutlet weak var collectionView : UICollectionView!
    var userLibrary : Library?
    let barcodeScanner = BarcodeScannerViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        populateCollectionView()
        
        barcodeScanner.codeDelegate = self
        barcodeScanner.errorDelegate = self
        barcodeScanner.dismissalDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        populateCollectionView()
    }
    
    func populateCollectionView() {
        User.fetchLibrary { (library) in
            self.userLibrary = library
            
            self.collectionView.reloadData()
        }
    }

    @IBAction func addNewBook() {
      present(barcodeScanner, animated: true, completion: nil)
    }
    
}
