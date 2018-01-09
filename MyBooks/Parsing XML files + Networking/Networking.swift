//
//  Networking.swift
//  MyBooks
//
//  Created by Andrei Vataselu on 1/8/18.
//  Copyright © 2018 Andrei Vataselu. All rights reserved.
//

import Foundation
import Alamofire
import SWXMLHash

enum XMLResult {
    case success(XMLIndexer)
    case failed(Error)
}

class Networking {
    
    private init() {}
    
    static func getXMLfor(ISBN: String, xml: @escaping (XMLResult) -> () ) {
        let URL = "https://www.goodreads.com/book/isbn/\(ISBN)?key=C30CIoFrgmG4NFSJujYw"
        
        let queue = DispatchQueue(label: "com.andreivataselu", qos: .background, attributes: .concurrent)
        
        Alamofire.request(URL).responseString(queue: queue) {
            (response) in

            if response.data != nil {
                xml(.success(SWXMLHash.parse(response.data!)))
            } else {
                xml(.failed(response.error!))
            }
        }
    }
    
}
