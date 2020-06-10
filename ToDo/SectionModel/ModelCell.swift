//
//  modelCellCreated.swift
//  ToDo
//
//  Created by Albert on 11.05.2020.
//  Copyright © 2020 Albert Mykola. All rights reserved.
//

import Foundation

struct ExpendedCell {
    var expended = false
}

class Model {
    static var shared = Model()
    var modelArray = [ExpendedCell]()
    
    init() {
        setup()
        }
        
    func setup() {
        let cellName = ExpendedCell()
        let dicriptionTast = ExpendedCell()
        let time = ExpendedCell()
        let status = ExpendedCell()

        modelArray.append(cellName)
        modelArray.append(dicriptionTast)
        modelArray.append(time)
        modelArray.append(status)
    }
    

}

