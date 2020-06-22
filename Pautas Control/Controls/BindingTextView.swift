//
//  BindingTextView.swift
//  Pautas Control
//
//  Created by João Vitor Duarte Mariucio on 24/05/20.
//  Copyright © 2020 João Vitor Duarte Mariucio. All rights reserved.
//

import UIKit

class BindingTextView: UITextView {
    
    var textChanged: (String) -> () = { _ in }
    var placeholder: String = ""
    
    func bind(callback: @escaping (String) -> ()){
        self.textChanged = callback
        self.delegate = self
    }
    
    func setPlaceholder(_ placeholder: String){
        self.placeholder = placeholder
        self.textColor = .lightGray
        self.text = placeholder
    }
    
    func textFieldDidChange(_ text: String) {
        self.textChanged(text)
    }
}

extension BindingTextView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholder {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholder
            textView.textColor = .lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty || textView.text == placeholder {
            self.textChanged("")
        }else{
            self.textChanged(textView.text)
        }
    }
}
