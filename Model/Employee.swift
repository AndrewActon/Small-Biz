//
//  Employee.swift
//  SmallBiz
//
//  Created by Andrew Acton on 12/1/22.
//

import Foundation

class Employee: Codable {
    let firstName: String
    let lastName: String
    var skillLevel: Int
    var id: String
    var tasks: [Task]
    
    init (firstName: String, lastName: String, skillLevel: Int = 1, id: String = UUID().uuidString, tasks: [Task] = []){
        self.firstName = firstName
        self.lastName = lastName
        self.skillLevel = skillLevel
        self.id = id
        self.tasks = tasks
    }
}

extension Employee: Equatable {
    static func == (lhs: Employee, rhs: Employee) -> Bool {
        return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName
    }
}
