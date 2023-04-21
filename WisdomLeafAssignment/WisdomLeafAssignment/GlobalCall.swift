//
//  GlobalCall.swift
//  WisdomLeafAssignment
//
//  Created by Pranav Dhomne on 21/04/23.
//

import Foundation

class GlobalCall {
    static let shared = GlobalCall()
    private init() {
           // Initialize the singleton instance here
       }
    var isButtonSelected = false
}
