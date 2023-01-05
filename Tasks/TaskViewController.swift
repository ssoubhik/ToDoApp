//
//  TaskViewController.swift
//  Tasks
//
//  Created by Rhymetech on 05/01/23.
//

import UIKit

class TaskViewController: UIViewController {
    @IBOutlet var label: UILabel!

    var task: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        label.text = task
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteTask))
    }
    

    @objc func deleteTask() {

    }

}
