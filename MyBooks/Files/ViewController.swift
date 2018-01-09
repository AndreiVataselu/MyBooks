//key: C30CIoFrgmG4NFSJujYw
//secret: cA8zi6lUQrwT5QYxMbKnz45FERrx0XwzgrHK1GIh8Tg

import UIKit
import Alamofire
import SWXMLHash

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var xmlFile : XML?

        Networking.getXMLfor(ISBN: "9781409376415") { (response) in
            switch response {
            case .success(let data):
                xmlFile = XML(xmlResponse: data)

            case .failed(let error):
                print(error)
            }
            
            if let xmlIsSuccesful = xmlFile {
                if xmlIsSuccesful.validFile {
                    let bookDetails = xmlIsSuccesful.getBookDetails()
                    
                    for detail in bookDetails {
                        print(detail)
                    }
                    
                } else {
                    print("Book not found!")
                }
            }
            
        }
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

