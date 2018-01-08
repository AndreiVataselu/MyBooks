//
//  XML.swift
//  MyBooks
//
//  Created by Andrei Vataselu on 1/8/18.
//  Copyright © 2018 Andrei Vataselu. All rights reserved.
//

import Foundation
import SWXMLHash

class XML {
    
    var xmlFile : XMLIndexer
    var validFile : Bool
    
    init(xml: XMLIndexer) {
        xmlFile = xml
        
        switch xmlFile["error"] {
        case .element(let elem):
            validFile = false
        default: validFile = true
        }
        
        
    }
    
    
    
}
