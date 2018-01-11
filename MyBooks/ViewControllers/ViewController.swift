//key: C30CIoFrgmG4NFSJujYw
//secret: cA8zi6lUQrwT5QYxMbKnz45FERrx0XwzgrHK1GIh8Tg

import UIKit
import Alamofire
import SWXMLHash
import Kingfisher
import BarcodeScanner

class ViewController: UIViewController {

    @IBOutlet weak var bookTitleLabel : UILabel!
    @IBOutlet weak var bookAuthorLabel : UILabel!
    @IBOutlet weak var bookPageNumber : UILabel!
    @IBOutlet weak var bookImage : UIImageView!
    let barcodeScanner = BarcodeScannerController()
    var userLibrary = Library.newLibrary()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        barcodeScanner.codeDelegate = self
        barcodeScanner.errorDelegate = self
        barcodeScanner.dismissalDelegate = self
        
        }
    
    
    @IBAction func scanCode() {
        present(barcodeScanner, animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension ViewController: BarcodeScannerCodeDelegate {
    
    func barcodeScanner(_ controller: BarcodeScannerController, didCaptureCode code: String, type: String) {
        print(code)
        
        
        userLibrary.addBook(ISBN: code) { (foundBook) in
            if foundBook {
                
                DispatchQueue.main.async {
                print(self.userLibrary.books.count)
                controller.reset()
                controller.dismiss(animated: true, completion: nil)
                }
                
            }
            //TODO: When book is not found
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

