//key: C30CIoFrgmG4NFSJujYw
//secret: cA8zi6lUQrwT5QYxMbKnz45FERrx0XwzgrHK1GIh8Tg

import UIKit
import Alamofire
import SWXMLHash

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let networking = Networking.createThread()
        
        var xmlFile : XML?

        _ = networking.getXMLfor(ISBN: "9789731931937") { (response) in
            switch response {
            case .success(let data):
                xmlFile = XML(xmlResponse: data)

            case .failed(let error):
                print(error)
            }
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

