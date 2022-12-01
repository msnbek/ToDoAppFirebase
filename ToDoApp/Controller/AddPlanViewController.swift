//
//  AddPlanViewController.swift
//  ToDoApp
//
//  Created by Mahmut Senbek on 1.12.2022.
//

import UIKit
import FirebaseFirestore
import FirebaseCore

class AddPlanViewController: UIViewController {

    var stringModel = StringModel()
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var subtitleTextField: UITextField!
    @IBOutlet weak var taskTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

   
    }
    
    
    @IBAction func backButtonClicked(_ sender: Any) {
        
        self.performSegue(withIdentifier: self.stringModel.segueTableView, sender: nil)
    }
    
    @IBAction func createButtonClicked(_ sender: Any) {
        
        let firebaseDatabase = Firestore.firestore()
        var firestoreReference : DocumentReference? = nil
    
        
        let firestoreNewPlan = [stringModel.task: taskTextField.text!, stringModel.subtitle: subtitleTextField.text!, stringModel.description: descriptionTextField.text!, stringModel.date: FieldValue.serverTimestamp() ] as [String : Any]
        
        firestoreReference = firebaseDatabase.collection(stringModel.collectionName).addDocument(data: firestoreNewPlan, completion: { error in
            
            if error != nil {
                // alert
            }else {
                
                let alert  = UIAlertController(title: "Saved", message: "Press Accept for review your plans.", preferredStyle: UIAlertController.Style.alert)
               
                let okButton = UIAlertAction(title: "Accept", style: UIAlertAction.Style.default) { [self] UIAlertAction in
                    self.performSegue(withIdentifier: self.stringModel.segueTableView, sender: nil)
                }
                alert.addAction(okButton)
                self.present(alert, animated: true)
                print("success")
            }
            
        }
        )
        
    }
    

}
