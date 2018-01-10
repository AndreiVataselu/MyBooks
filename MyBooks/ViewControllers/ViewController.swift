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
    var library = Library.newLibrary(books: [Book]())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        barcodeScanner.codeDelegate = self
        barcodeScanner.errorDelegate = self
        barcodeScanner.dismissalDelegate = self
        
//        //MARK: - Temporary loading screen
//        let loadingScreen = UIView(frame: self.view.frame)
//        loadingScreen.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
//        loadingScreen.alpha = 0.8
//
//        let loadingLabel = UILabel()
//        loadingLabel.text = "Loading..."
//        loadingLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        loadingLabel.frame = CGRect(x: loadingScreen.frame.width / 2.5,
//                                    y: loadingScreen.frame.width / 2,
//                                    width: loadingScreen.frame.width,
//                                    height: loadingScreen.frame.height / 2)
//        loadingScreen.addSubview(loadingLabel)
//
//
//        self.view.addSubview(loadingScreen)

    }
    
    
    func updateUIfor(ISBN: String, foundBook: @escaping (Bool) -> Void){
        
        var xmlFile : XML?
        var errorXML : Error?

        Networking.getXMLfor(ISBN: ISBN) { (response) in
            switch response {
            case .success(let data):
                xmlFile = XML(xmlResponse: data)
                
            case .failed(let error):
                errorXML = error
            }
            
            if let xmlIsSuccesful = xmlFile {
                if xmlIsSuccesful.validFile {
                    let bookDetails = xmlIsSuccesful.getBookDetails()
                    
                    DispatchQueue.main.async {
                        self.bookTitleLabel.text = bookDetails["title"]
                        self.bookAuthorLabel.text = bookDetails["author"]
                        self.bookPageNumber.text = bookDetails["pages"]
                        
                        Networking.downloadImageFor(link: bookDetails["imageURL"]!, imageResult: { (image) in
                            self.bookImage.image = image
                        })
                        
//                        self.bookImage.kf.setImage(with: URL(string: bookDetails["imageURL"]!))
                        
                        foundBook(true)
                    }
                    
                } else {
                    print("Book not found!")
                        foundBook(false)
                }
            } else {
                foundBook(false)
                print("Error - \(String(describing: errorXML))")
            }
        }
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
        updateUIfor(ISBN: code) { (foundBook) in
            if foundBook {
                controller.reset()
                controller.dismiss(animated: true, completion: nil)
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
