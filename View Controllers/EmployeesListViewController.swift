//
//  ViewController.swift
//  SmallBiz
//
//  Created by Colton Swapp on 8/26/22.
//

import UIKit

class EmployeesListViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var addEmployeeTextField: UITextField!
    @IBOutlet weak var employeeTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        EmployeeController.shared.loadFromPersistenceStore()
        employeeTableView.reloadData()
    }
    
    func setupTableView(){
        employeeTableView.delegate = self
        employeeTableView.dataSource = self
    }

    //MARK: - Actions
    @IBAction func addEmployeeButtonTapped(_ sender: Any) {
        guard let newEmployee = addEmployeeTextField.text, !newEmployee.isEmpty else { return }
        let newEmployeeName = newEmployee.components(separatedBy: " ")
        if newEmployeeName.count == 2 {
            EmployeeController.shared.addEmployee(firstName: newEmployeeName[0], LastName: newEmployeeName[1])
        } else if newEmployeeName.count == 1 {
            EmployeeController.shared.addEmployee(firstName: newEmployeeName[0], LastName: " ")
        }
        addEmployeeTextField.text = ""
        employeeTableView.reloadData()
    }
    

    
}

extension EmployeesListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EmployeeController.shared.employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell", for: indexPath)
        let employee = EmployeeController.shared.employees[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = "\(employee.firstName) \(employee.lastName)"
        cell.contentConfiguration = content

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let employeeToDelete = EmployeeController.shared.employees[indexPath.row]
            EmployeeController.shared.deleteEmployee(employee: employeeToDelete)
            employeeTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEmployeeTask" {
            guard let destination = segue.destination as? EmployeeTaskListViewController,
                  let index = employeeTableView.indexPathForSelectedRow else { return }
            
            let employeeToSend = EmployeeController.shared.employees[index.row]
            destination.employee = employeeToSend
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.employeeTableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
}
