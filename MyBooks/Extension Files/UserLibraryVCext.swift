//
//  UserLibraryVCExtension.swift
//  MyBooks
//
//  Created by Andrei Vataselu on 1/13/18.
//  Copyright © 2018 Andrei Vataselu. All rights reserved.
//

import Foundation
import UIKit


extension UserLibraryVC : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userLibrary?.books.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookViewCell", for: indexPath) as! BookViewCell
        
        cell.bookImage.image = userLibrary?.books[indexPath.row].picture
        
        return cell
    }
}
