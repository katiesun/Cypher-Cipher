//
//  CaesarViewController.swift
//  cyphercipher
//
//  Created by Katherine Sun on 4/7/20.
//  Copyright © 2020 Katherine Sun. All rights reserved.
//

import UIKit

class CaesarViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var endecrypt: UIPickerView!
    @IBOutlet weak var message: UITextField!
    @IBOutlet weak var shift: UIPickerView!
    @IBOutlet weak var transmessage: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var endecryptData: [String] = [String]()
    var shiftData: [Int] = [Int]()
    var kshift = 0
    var encrypt = true
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //connect data:
        self.endecrypt.delegate = self
        self.endecrypt.dataSource = self
        
        self.shift.delegate = self
        self.shift.dataSource = self
        
        //input data into the array:
        endecryptData = ["encrypt", "decrypt"]
        shiftData = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
           return endecryptData.count
        } else {
            return shiftData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return "\(endecryptData[row])"
        } else {
            return "\(shiftData[row])"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            button.setTitle("\(endecryptData[row])",for: .normal)
            if endecryptData[row] == "encrypt" {
                encrypt = true
            } else {
                encrypt = false
            }
        } else {
            kshift = shiftData[row]
        }
    }
    
    func caesarshift(text: String, shift: Int) -> String{
        func shiftLetter(ucs: UnicodeScalar) -> UnicodeScalar {
            let firstLetter = Int(UnicodeScalar("A").value)
            let lastLetter = Int(UnicodeScalar("Z").value)
            let letterCount = lastLetter - firstLetter + 1

            let value = Int(ucs.value)
            switch value {
            case firstLetter...lastLetter:
                // Offset relative to first letter:
                var offset = value - firstLetter
                // Apply shift amount (can be positive or negative):
                if encrypt == true {
                    offset += shift
                } else {
                    offset -= shift
                }
                // Transform back to the range firstLetter...lastLetter:
                offset = (offset % letterCount + letterCount) % letterCount
                // Return corresponding character:
                return UnicodeScalar(firstLetter + offset)!
            default:
                // Not in the range A...Z, leave unchanged:
                return ucs
            }
        }

        let msg = text.uppercased()
        return String(String.UnicodeScalarView(msg.unicodeScalars.map(shiftLetter)))
    }

    @IBAction func translate(_ sender: UIButton) {
        let value = message.text
        transmessage.text = caesarshift(text: value ?? "no message", shift: kshift)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

    

}
