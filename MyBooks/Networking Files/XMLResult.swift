//
//  XMLResultType.swift
//  MyBooks
//
//  Created by Andrei Vataselu on 1/9/18.
//  Copyright © 2018 Andrei Vataselu. All rights reserved.
//

import Foundation
import SWXMLHash


enum XMLResult {
    case success(XMLIndexer)
    case failed(Error)
}

