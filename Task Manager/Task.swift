//
//  Task.swift
//  Task Manager
//
//  Created by Adenilson Noronha da Silva Junior on 06/11/19.
//  Copyright © 2019 Adenilson Noronha da Silva Junior. All rights reserved.
//

import Foundation

class Task {
    let uid: String
    let name: String
    let date: String
    let level: Int
    let done: Bool
    
    init(uid: String, name: String, date: String, level: Int, done: Bool) {
        self.uid = uid
        self.name = name
        self.date = date
        self.level = level
        self.done = done
    }
    
    static func mapDictionaryToTask(_ dictionary: Dictionary<String, Any>) -> Task {
        return Task(
            uid: dictionary["uid"] as! String,
            name: dictionary["name"] as! String,
            date: dictionary["date"] as! String,
            level: dictionary["level"] as! Int,
            done: dictionary["done"] as! Bool
        )
    }
}
