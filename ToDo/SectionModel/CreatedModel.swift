//
//  CreatedModel.swift
//  ToDo
//
//  Created by Albert on 12.05.2020.
//  Copyright © 2020 Albert Mykola. All rights reserved.
//

import Foundation

var info = Info()
var editing: Bool = false

struct Info: Codable {
    var name: String?
    var descriptionName: String?
    var timeTask: Date?
    var executionTime: Date?
    var status = 1
    var done: Bool = false
}

class AllTask {
    static var shared = AllTask()
    var notPerformed: [Info] = []
    var tasksCompleted: [Info] = []
    
    init() {
        notPerformed = Created.shared.load(forKey: "arrayInfo")
        tasksCompleted = Created.shared.load(forKey: "tasksCompleted")
    }
}




