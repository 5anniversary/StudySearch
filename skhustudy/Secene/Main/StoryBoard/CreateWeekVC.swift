//
//  CreateWeekVC.swift
//  SKHUStudy
//
//  Created by 원현식 on 2020/04/29.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

import Then

class CreateWeekVC: UIViewController {
    
    // MARK: - View
    let scrollView = UIScrollView()
    let containerView = UIView()
    
    let datePicker = UIDatePicker().then {
        $0.datePickerMode = .date
    }
    let dateFormatter = DateFormatter().then {
        $0.dateFormat = "yyyy-MM-dd"
    }
    
    let roundLabel = UILabel().then {
        $0.text = "회차:"
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 16)
        $0.sizeToFit()
    }
    
    let roundTextField = UITextField().then {
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
        $0.keyboardType = .numberPad
    }
    
    let dateLabel = UILabel().then {
        $0.text = "날짜:"
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 16)
        $0.sizeToFit()
    }
    
    let dateTextField = UITextField().then {
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
        $0.keyboardType = .numberPad
    }
    
    let subjectLabel = UILabel().then {
        $0.text = "주제:"
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 16)
        $0.sizeToFit()
    }
    
    let subjectTextField = UITextField().then {
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
    }
    
    let locationLabel = UILabel().then {
        $0.text = "위치:"
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 16)
        $0.sizeToFit()
    }
    
    let locationTextField = UITextField().then {
        $0.borderStyle = .none
        $0.addBorder(.bottom, color: .signatureColor, thickness: 1.0)
    }
    
    let memoLabel = UILabel().then {
        $0.text = "메모:"
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 16)
        $0.sizeToFit()
    }
    
    let memoTextView = UITextView().then {
        $0.sizeToFit()
        $0.isScrollEnabled = false
        $0.font = .systemFont(ofSize: 15)
        $0.allowsEditingTextAttributes = true
        $0.setBorder(borderColor: .signatureColor, borderWidth: 1)
        $0.setRounded(radius: 10)
        $0.adjustsFontForContentSizeCategory = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddWeekButton))
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapContainerView)))
        
        addKeyboardNotification()
        setDatePicker()
        addSubView()
    }
    
    // MARK: Methods
    
    func addKeyboardNotification() {
         NotificationCenter.default.addObserver(
             self,
             selector: #selector(keyboardWillShow),
             name: UIResponder.keyboardWillShowNotification,
             object: nil)
         
         NotificationCenter.default.addObserver(
             self,
             selector: #selector(keyboardWillHide),
             name: UIResponder.keyboardWillHideNotification,
             object: nil)
         
     }

     @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
         
         let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardFrame.height, right: 0.0)
         scrollView.contentInset = contentInsets
         scrollView.scrollIndicatorInsets = contentInsets

         var rect = self.view.frame
         rect.size.height -= keyboardFrame.height
         if rect.contains(memoTextView.frame.origin) {
             scrollView.scrollRectToVisible(memoTextView.frame, animated: true)
         }
     }

     @objc func keyboardWillHide(_ notification: Notification) {
         let contentInsets = UIEdgeInsets.zero
         scrollView.contentInset = contentInsets
         scrollView.scrollIndicatorInsets = contentInsets
     }
    
    private func setDatePicker() {
        dateTextField.inputView = datePicker
        let date = Date()
        let stringDate = dateFormatter.string(from: date)
        dateTextField.text = stringDate
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.tintColor = .signatureColor
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPickerView))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        dateTextField.inputAccessoryView = toolbar
        
    }
    
    @objc private func didTapContainerView() {
        self.view.endEditing(true)
    }
    
    
    @objc private func dismissPickerView() {
        let date = dateFormatter.string(from: datePicker.date)
        dateTextField.text = date
        view.endEditing(true)
    }
    
    @objc private func didTapAddWeekButton() {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
}
