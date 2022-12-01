//
//  ViewController.swift
//  ToDoApp
//
//  Created by Mahmut Senbek on 1.12.2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class ViewYourPlans: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var stringModel = StringModel()
    
    var taskArray = [String]()
    var timeArray = [Timestamp]()
    var subtitleArray = [String]()
    var taskDescriptionArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(taskArray)
        tableView.delegate = self
        tableView.dataSource = self

        getDataFromFirebase()
    }
   
    
    @IBAction func addButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: stringModel.segueSecondScreen, sender: nil)
    }
    
    func getDataFromFirebase() {
        
        let firestoreFirebase = Firestore.firestore()
        
        firestoreFirebase.collection(stringModel.collectionName).order(by: stringModel.date, descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                //alert
                print("error")
            }else {
                
                if snapshot?.isEmpty == false {
                    self.taskArray.removeAll(keepingCapacity: false)
                    self.subtitleArray.removeAll(keepingCapacity: false)
                    self.taskDescriptionArray.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents {
                        
                        if let task = document.get(self.stringModel.task) as? String {
                            
                            self.taskArray.append(task)
                         //   print(task)
                        }
                        
                        if let subtitle = document.get(self.stringModel.subtitle) as? String {
                            
                            self.subtitleArray.append(subtitle)
                           // print(subtitle)
                        }
                        
                        if let description = document.get(self.stringModel.description) as? String {
                            
                            self.taskDescriptionArray.append(description)
                        }
                        
                        if let date = document.get(self.stringModel.date) as? Timestamp {
                            
                            self.timeArray.append(date)
                            
                        }
                        
                        self.tableView.reloadData()
                        
                    }
                    
                }
            }
        }
        
    }


}

//MARK: - TableView

extension ViewYourPlans: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return taskArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = taskArray[indexPath.row]
        cell.detailTextLabel?.text = subtitleArray[indexPath.row]
        return cell
        
    }
    
   
    
    
}

