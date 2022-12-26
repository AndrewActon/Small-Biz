//
//  EmployeeController.swift
//  SmallBiz
//
//  Created by Andrew Acton on 12/1/22.
//

import Foundation

class EmployeeController {
    
    //Shared Instance
    static let shared = EmployeeController ()
    
    //Source of Truth
    var employees: [Employee] = []
    var defaultItems: [String] = [
    "Payroll",
    "Onboarding",
    "Employee Profile",
    "Work Shoes",
    ]
    
    //MARK: - CRUD
    
    //Create
    
    func addEmployee (firstName: String, LastName: String){
        //Declare New Employee
        let newEmployee = Employee(firstName: firstName, lastName: LastName)
        
        if UserDefaults.standard.bool(forKey: "New Employee default items"){
            let tasks: [Task] = defaultItems.compactMap( { Task(title: $0) })
            newEmployee.tasks = tasks
        }
        
        //Add employee to source of truth
        employees.append(newEmployee)
        
        //Save
        saveToPersistenceStore()
    }
    
    //Read
    
    //Update
    
    //Delete
    func deleteEmployee (employee: Employee) {
        guard let index = employees.firstIndex(of: employee) else { return }
        employees.remove(at: index)
        saveToPersistenceStore()
    }
    
    //MARK: - Persistence
    func persistantStore() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("SmallBiz.json")
        return fileURL
    }
    
    // Save
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(employees)
            try data.write(to: persistantStore())
        } catch {
            print("We had an error saving to our persistence store.")
            print(error)
            print(error.localizedDescription)
        }
    }
    
    // Load
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: persistantStore())
            employees = try JSONDecoder().decode([Employee].self, from: data)
        } catch {
            print("We had an error loading our data from the persistence store.")
            print(error)
            print(error.localizedDescription)
        }
    }
}
