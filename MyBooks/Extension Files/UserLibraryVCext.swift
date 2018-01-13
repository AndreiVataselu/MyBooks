//
//  UserLibraryVCExtension.swift
//  MyBooks
//
//  Created by Andrei Vataselu on 1/13/18.
//  Copyright © 2018 Andrei Vataselu. All rights reserved.
//

import Foundation
import UIKit

enum CellState {
    case selected
    case notSelected
}

extension UserLibraryVC : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userLibrary?.books.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookViewCell", for: indexPath) as! BookViewCell
        
        cell.bookImage.image = userLibrary?.books[indexPath.row].picture
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? BookViewCell {

            let view = UIView()
            view.frame = cell.contentView.bounds
            view.backgroundColor = UIColor.white
            view.alpha = 0.5
            
            if cell.state == .notSelected {
                cell.addSubview(view)
                cell.state = .selected
                print("Selected cell at \(indexPath.row)")

            } else {
                cell.subviews[1].removeFromSuperview()
                cell.state = .notSelected
                print("Deselected cell at \(indexPath.row)")

            }
        
    }
}
    
    
}
