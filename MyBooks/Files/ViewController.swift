//key: C30CIoFrgmG4NFSJujYw
//secret: cA8zi6lUQrwT5QYxMbKnz45FERrx0XwzgrHK1GIh8Tg

import UIKit
import Alamofire
import SWXMLHash
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var bookTitleLabel : UILabel!
    @IBOutlet weak var bookAuthorLabel : UILabel!
    @IBOutlet weak var bookPageNumber : UILabel!
    @IBOutlet weak var bookImage : UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - Temporary loading screen
        let loadingScreen = UIView(frame: self.view.frame)
        loadingScreen.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        loadingScreen.alpha = 0.8
        
        let loadingLabel = UILabel()
        loadingLabel.text = "Loading..."
        loadingLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        loadingLabel.frame = CGRect(x: loadingScreen.frame.width / 2.5,
                                    y: loadingScreen.frame.width / 2,
                                    width: loadingScreen.frame.width,
                                    height: loadingScreen.frame.height / 2)
        loadingScreen.addSubview(loadingLabel)
        
        
        var xmlFile : XML?

        self.view.addSubview(loadingScreen)
        Networking.getXMLfor(ISBN: "9786066868570") { (response) in
            switch response {
            case .success(let data):
                xmlFile = XML(xmlResponse: data)

            case .failed(let error):
                print(error)
            }
            
            if let xmlIsSuccesful = xmlFile {
                if xmlIsSuccesful.validFile {
                    let bookDetails = xmlIsSuccesful.getBookDetails()
                    
                    DispatchQueue.main.async {
                    self.bookTitleLabel.text = bookDetails["title"]
                    self.bookAuthorLabel.text = bookDetails["author"]
                    self.bookPageNumber.text = bookDetails["pages"]
                    self.bookImage.kf.setImage(with: URL(string: bookDetails["imageURL"]!))
                    loadingScreen.removeFromSuperview()

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

