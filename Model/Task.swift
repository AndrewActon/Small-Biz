//
//  Task.swift
//  SmallBiz
//
//  Created by Andrew Acton on 12/7/22.
//

import Foundation

class Task: Codable {
    let title: String
    var isComplete: Bool
    var id: String = UUID().uuidString
    
    init (title: String, isComplete: Bool = false, id: String = UUID().uuidString){
        self.title = title
        self.isComplete = isComplete
        self.id = id
    }
}

extension Task: Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.title == rhs.title && lhs.id == rhs.id
    }
}
