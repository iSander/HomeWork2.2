//
//  ViewController.swift
//  HomeWork2.2
//
//  Created by Alex Sander on 02.02.2020.
//  Copyright © 2020 Alex Sander. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IB Outlet

    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    // MARK: - Properties
    
    let colorValueMin: Float = 0.0
    let colorValueMax: Float = 1.0
    
    // MARK: - Life Cycles Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDoneButton(to: redTextField)
        addDoneButton(to: greenTextField)
        addDoneButton(to: blueTextField)
        
        updateUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - IB Actions
    
    @IBAction func sliderValueChanged() {
        updateUI()
    }

    // MARK: - Private Methods
    
    private func updateUI() {
        redLabel.text = String(format: "%.2f", redSlider.value)
        redTextField.text = String(format: "%.2f", redSlider.value)
        
        greenLabel.text = String(format: "%.2f", greenSlider.value)
        greenTextField.text = String(format: "%.2f", greenSlider.value)
        
        blueLabel.text = String(format: "%.2f", blueSlider.value)
        blueTextField.text = String(format: "%.2f", blueSlider.value)
        
        colorView.backgroundColor = UIColor.init(red: CGFloat(redSlider?.value ?? colorValueMin),
                                                 green: CGFloat(greenSlider?.value ?? colorValueMin),
                                                 blue: CGFloat(blueSlider?.value ?? colorValueMin),
                                                 alpha: CGFloat(colorValueMax))
    }
    
    private func addDoneButton(to textField: UITextField) {
        let bar = UIToolbar()
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(keyboardDoneTapped))
        bar.items = [flexSpace, done]
        bar.sizeToFit()
        textField.inputAccessoryView = bar
    }
    
    @objc private func keyboardDoneTapped() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let inputText = textField.text, !inputText.isEmpty else {
            showAlert(with: "Textfield is empty", message: "Please enter value")
            return
        }
        
        var colorValue = colorValueMin
        
        if let floatValue = Float(inputText) {
            if colorValueMin...colorValueMax ~= floatValue {
                colorValue = floatValue
                textField.text = String(format: "%.2f", colorValue)
            }
            else {
                showAlert(with: "Wrong range", message: String(format: "Range should be from %.2f to %.2f", colorValueMin, colorValueMax))
                return
            }
        } else {
            showAlert(with: "Wrong format", message: "Format must be float")
            return
        }
        
        if textField == redTextField {
            redSlider.value = colorValue
        }
        else if textField == greenTextField {
            greenSlider.value = colorValue
        }
        else if textField == blueTextField {
            blueSlider.value = colorValue
        }
        
        updateUI()
    }
}

// MARK: - UIAlertController
extension ViewController {
    
    private func showAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
