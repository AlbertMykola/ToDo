//
//  File.swift
//  ToDo
//
//  Created by Albert on 11.05.2020.
//  Copyright © 2020 Albert Mykola. All rights reserved.
//

import Foundation


class Created {
    
    static var shared = Created()

    func save(forKey: String, value: [Info] ) {
        if let encodedUserDetails = try? JSONEncoder().encode(value) {
            UserDefaults.standard.set(encodedUserDetails, forKey: forKey)
        }
    }
    
    func load(forKey: String) -> [Info] {
        if let decodeData = UserDefaults.standard.object(forKey: forKey) as? Data {
            if let userDetail = try? JSONDecoder().decode([Info].self, from: decodeData) {
                return userDetail
            }
        }
        return [Info]()
    }
}

    
    







