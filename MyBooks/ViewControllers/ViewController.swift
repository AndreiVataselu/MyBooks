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
        
        User.login(email: "vataseluandrei1@gmail.com", password: "parolamea") { (_) in }
        
        }
    
    
    @IBAction func scanCode() {
        present(barcodeScanner, animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
