//
//  TaskController.swift
//  SmallBiz
//
//  Created by Andrew Acton on 12/7/22.
//

import Foundation

class TaskController {
    
    //MARK: - CRUD
    
    //Create
    static func assignTaskTo(_ employee: Employee, taskTitle: String) {
        let newTask = Task(title: taskTitle)
        employee.tasks.append(newTask)
        EmployeeController.shared.saveToPersistenceStore()
    }
    
    //Read
    
    //Update
    static func toggleTaskStatus (employee: Employee, task: Task) {
        guard let employeeIndex = EmployeeController.shared.employees.firstIndex(of: employee),
              let taskIndex = employee.tasks.firstIndex(of: task) else { return }
        
        EmployeeController.shared.employees[employeeIndex].tasks[taskIndex].isComplete.toggle()
        
        EmployeeController.shared.saveToPersistenceStore()
    }
    
    //Delete
    static func deleteTaskFrom(_ employee: Employee, task: Task){
        guard let index = employee.tasks.firstIndex(of: task) else { return }
        
        employee.tasks.remove(at: index)
        
        EmployeeController.shared.saveToPersistenceStore()
    }
    
}
