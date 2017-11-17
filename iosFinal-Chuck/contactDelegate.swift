//
//  contactDelegate.swift
//  iosFinal-Chuck
//
//  Created by Chucks Mac Book on 11/17/17.
//  Copyright © 2017 Chucks Mac Book. All rights reserved.
//

import Foundation
import UIKit
protocol ContactDelegate: class {
    func addContact(by controller: Any?, firstName first: String?, lastName last: String?, phoneNumber phone: String, indexPath indexpath: NSIndexPath?)

}
