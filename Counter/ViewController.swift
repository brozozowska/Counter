//
//  ViewController.swift
//  Counter
//
//  Created by Сергей Розов on 06.03.2025.
//

import UIKit

class ViewController: UIViewController {
    var counter: Int = 0
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        return formatter.string(from: Date())
    }

    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        counterLabel.text = "Значение счётчика\n\(counter)"
        textView.isEditable = false
        textView.text = "История изменений:\n\n"
    }
    
    /// Прокручивает UITextView до самого низа, чтобы последние строки были видны.
    /// Вызывается при добавлении нового текста в textView, чтобы прокрутить к последней записи.
    func scrollTextViewToBottom() {
        let range = NSMakeRange(textView.text.count, 0)
        textView.scrollRangeToVisible(range)
    }
    
    @IBAction func increaseCounter(_ sender: Any) {
        counter += 1
        counterLabel.text = "Значение счётчика\n\(counter)"
        textView.text.append(contentsOf: "\(formattedDate): Значение изменено на +1\n")
        scrollTextViewToBottom()
    }
    
    @IBAction func decreaseCounter(_ sender: Any) {
        if counter > 0 {
            counter -= 1
            textView.text.append(contentsOf: "\(formattedDate): Значение изменено на -1\n")
            scrollTextViewToBottom()
        } else {
            counter = 0
            textView.text.append(contentsOf: "\(formattedDate): Попытка уменьшить значение счётчика ниже 0\n")
            scrollTextViewToBottom()
        }
        counterLabel.text = "Значение счётчика\n\(counter)"
    }
    
    @IBAction func resetCounter(_ sender: Any) {
        counter = 0
        counterLabel.text = "Значение счётчика\n\(counter)"
        textView.text.append(contentsOf: "\(formattedDate): Значение сброшено\n")
        scrollTextViewToBottom()
    }
    

}

