//
//  Protocols.swift
//  PocketNote
//
//  Created by Yu-Lin Yang on 8/2/16.
//  Copyright © 2016 Yu-Lin Yang. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsVCDelegate {
    func adjustDate(_ dateToggle: Bool)
    func adjustTimer(_ timerSelection: Int)
    func adjustBackground(_ backgroundColor: UIImage)
    
}
