//
//  ViewController.swift
//  Tasks
//
//  Created by Rhymetech on 05/01/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    var tasks = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Tasks"
        tableView.delegate = self
        tableView.dataSource = self

        // setup
        if !UserDefaults().bool(forKey: "setup") {
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }

        // get tasks
        updateTask()
    }

    @IBAction func didTapAdd(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "entry") as! EntryViewController
        vc.title = "New Task"
        vc.update = {
            DispatchQueue.main.async {
                self.updateTask()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }

    func updateTask() {
        tasks.removeAll()

        guard let count = UserDefaults().value(forKey: "count") as? Int else { return }

        for i in 0..<count {
            if let task = UserDefaults().value(forKey: "task_\(i+1)") as? String {
                tasks.append(task)
            }
        }

        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let vc = storyboard?.instantiateViewController(withIdentifier: "task") as! TaskViewController
        vc.title = "Task Details"
        vc.task = tasks[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = tasks[indexPath.row]

        return cell
    }
}
