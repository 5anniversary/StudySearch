//
//  AddStudyVC.swift
//  SKHUStudy
//
//  Created by 원현식 on 2020/04/27.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

class AddStudyVC: UITableViewController {
    
    let category = ["카테고리","IT", "영어", "수학", "취업"]
    
    @IBOutlet var studyNameTextField: UITextField!
    @IBOutlet var categoryTextField: UITextField!
    @IBOutlet var explanationTextView: UITextView!
    @IBOutlet var startDateTextField: UITextField!
    @IBOutlet var endDateTextField: UITextField!
    @IBOutlet var headCountTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var penaltyTextField: UITextField!
    @IBOutlet var penaltyButton: UIButton!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPickerView()
        
        title = "새로운 스터디 추가"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        
    }
    
    private func createPickerView() {
        // category picker
        let categoryPickerView = UIPickerView()
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        categoryTextField.inputView = categoryPickerView
        
        // date picker
        datePicker.datePickerMode = .date
        startDateTextField.inputView = datePicker
        endDateTextField.inputView = datePicker
        
        // 공통 툴바
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.tintColor = .signatureColor
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPickerView))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        startDateTextField.inputAccessoryView = toolbar
        endDateTextField.inputAccessoryView = toolbar
        categoryTextField.inputAccessoryView = toolbar
    }
    
    
    
    @objc func dismissPickerView() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        let date = dateFormatter.string(from: datePicker.date)
        
        if startDateTextField.isEditing {
            startDateTextField.text = date
            
        } else if endDateTextField.isEditing {
            endDateTextField.text = date
        }
        
        view.endEditing(true)
    }
    
    @objc private func didTapCancelButton() {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc private func didTapAddButton() {
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func didTapPenaltyButton(_ sender: Any) {
        if penaltyTextField.isEnabled  {
            penaltyButton.setTitle("", for: .normal)
            penaltyTextField.isEnabled = !penaltyTextField.isEnabled
            penaltyTextField.text = ""
        } else {
            penaltyButton.setTitle("✓", for: .normal)
            penaltyTextField.isEnabled = !penaltyTextField.isEnabled
        }
    }
    
    
}

extension AddStudyVC: UIPickerViewDelegate {}

extension AddStudyVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return category.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return category[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if category[row] == "카테고리" {
            return
        }
        categoryTextField.text = category[row]
    }
    
}

