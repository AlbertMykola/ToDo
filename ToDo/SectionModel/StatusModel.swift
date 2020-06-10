//
//  StatusModel.swift
//  ToDo
//
//  Created by Albert on 12.05.2020.
//  Copyright © 2020 Albert Mykola. All rights reserved.
//

import Foundation

struct Status {
    var isOn: Bool
}

class isOn {
    var arrayInOn = [Status]()
    
    init() {
        setup()
    }
    
    func setup() {
        let urgenly = Status(isOn: false)
        let notNecessary = Status(isOn: false)
        arrayInOn.append(urgenly)
        arrayInOn.append(notNecessary)
    }
}
