//
//  EmployeeTaskListViewController.swift
//  SmallBiz
//
//  Created by Andrew Acton on 12/7/22.
//

import UIKit

class EmployeeTaskListViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var employeeTableView: UITableView!
    
    //MARK: - Properties
    var employee: Employee!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewTitle()
        setupTableView()
        
    }
    
    func setupTableView(){
        employeeTableView.delegate = self
        employeeTableView.dataSource = self
    }
    
    //MARK: - Actions
    @IBAction func addTaskButtonTapped(_ sender: Any) {
        guard let newTask = taskTextField.text, !newTask.isEmpty else { return }
        TaskController.assignTaskTo(employee, taskTitle: newTask)
        taskTextField.text = ""
        employeeTableView.reloadData()
        taskTextField.resignFirstResponder()
    }
    
    func setupViewTitle () {
        navigationItem.title = "\(employee.firstName)'s Tasks"
    }

}

extension EmployeeTaskListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employee.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else { return UITableViewCell() }
        let task = employee.tasks[indexPath.row]
        
        cell.task = task
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskToDelete = employee.tasks[indexPath.row]
            TaskController.deleteTaskFrom(employee, task: taskToDelete)
            employeeTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

extension EmployeeTaskListViewController: TaskStatusChangedProtocol {
    func updateTaskStatus(task: Task) {
        TaskController.toggleTaskStatus(employee: employee, task: task)
        employeeTableView.reloadData()
    }
}
