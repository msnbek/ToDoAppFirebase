//
//  DetailViewController.swift
//  ToDoApp
//
//  Created by Mahmut Senbek on 1.12.2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var taskLabel: UILabel!
    
    var planArrayDetailsVC : Plan?
    override func viewDidLoad() {
        super.viewDidLoad()

        taskLabel.text = "Task: \(planArrayDetailsVC!.task)"
        subtitleLabel.text = "Subtitle: \(planArrayDetailsVC!.subtitle)"
        descriptionLabel.text = "Description: \(planArrayDetailsVC!.description)"
    }
    

   

}
