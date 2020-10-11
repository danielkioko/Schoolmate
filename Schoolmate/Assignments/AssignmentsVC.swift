//
//  AssignmentsVC.swift
//  Schoolmate
//
//  Created by Daniel Nzioka on 10/9/20.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class AssignmentsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let generator = UIImpactFeedbackGenerator(style: .light)
    
    @IBOutlet var tableView: UITableView!
    var ref: DatabaseReference!
    let fab = UIButton()
    var assignments = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        tableView.tableFooterView = UIView(frame: .zero)
        getAssignments()
    }
    
    private func getAssignments() {
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
          let value = snapshot.value as? NSDictionary
            guard let userAssigments = value?["userAssigments"] as? [String:Any] else { return }
            if(userAssigments.count != 0) {
                self.assignments = userAssigments
            }
          }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    @IBAction func openNewAssignmentPage() {
        generator.impactOccurred()
        let vc = storyboard?.instantiateViewController(identifier: "NewAssignmentVC") as! NewAssignmentVC
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assignments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AssignmentCell", for: indexPath) as! AssignmentCell
        return cell
    }
    
}

class NewAssignmentVC: UIViewController {
    
    let generator = UINotificationFeedbackGenerator()
    
    @IBOutlet var AssignmentTitle: UITextField!
    @IBOutlet var AssignmentTimeDue: UITextField!
    let datePicker = UIDatePicker()
    var ref: DatabaseReference?
    private var newAssignment = [String:AnyObject]()
    private var dueDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDatePicker()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, HH:mm"
        AssignmentTimeDue.text = formatter.string(from: Date())
        ref = Database.database().reference().child("Schoolmate").child(userID!)
    }
    
    @IBAction func addButtonTapped() {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let timestamp = df.string(from: Date())
        if (AssignmentTitle.text != "") {
            self.newAssignment = [
                "title": self.AssignmentTitle.text!,
                "timeDue": timestamp,
                "completed": false
            ] as [String : AnyObject]
            self.addAssignment()
        }
    }
    
    @IBAction func dismissPage() {
        self.dismiss(animated: true)
    }
    
    @objc private func addAssignment() {
        self.ref!.child("userAssigments").setValue(self.newAssignment)
        self.generator.notificationOccurred(.success)
        let vc = self.storyboard?.instantiateViewController(identifier: "ScheduledSuccess") as! ScheduledSuccess
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    func setDatePicker() {
        datePicker.datePickerMode = .date
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboardAndFillDueDate));
        toolbar.setItems([doneButton], animated: false)
        AssignmentTimeDue.inputAccessoryView = toolbar
        AssignmentTimeDue.inputView = datePicker
    }
    
    @objc func dismissKeyboardAndFillDueDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, HH:mm"
        AssignmentTimeDue.text = formatter.string(from: datePicker.date)
        self.dueDate = datePicker.date
        self.view.endEditing(true)
    }
    
}

class ScheduledSuccess: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.modalTransitionStyle = .coverVertical
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
