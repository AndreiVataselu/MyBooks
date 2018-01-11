//
//  VCExtension.swift
//  MyBooks
//
//  Created by Andrei Vataselu on 1/11/18.
//  Copyright © 2018 Andrei Vataselu. All rights reserved.
//

import Foundation
import BarcodeScanner

extension ViewController: BarcodeScannerCodeDelegate {
    
    func barcodeScanner(_ controller: BarcodeScannerController, didCaptureCode code: String, type: String) {
        print(code)
        
        userLibrary.checkForExistingBook(ISBN: code) { (bookExists) in
            if bookExists {
                print("Book already exists!")
            } else {
                self.userLibrary.addBook(ISBN: code) { (foundBook) in
                    
                    if !foundBook {
                        print("This book does not exists in our database.")
                        }
                    }
                }
            
            DispatchQueue.main.async {
                controller.reset()
                controller.dismiss(animated: true, completion: nil)
                
            }
        }
    }
}

extension ViewController: BarcodeScannerErrorDelegate {
    
    func barcodeScanner(_ controller: BarcodeScannerController, didReceiveError error: Error) {
        print(error)
    }
}

extension ViewController: BarcodeScannerDismissalDelegate {
    
    func barcodeScannerDidDismiss(_ controller: BarcodeScannerController) {
        controller.reset()
        controller.dismiss(animated: true, completion: nil)
    }
}

