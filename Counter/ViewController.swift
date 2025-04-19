//
//  ViewController.swift
//  Counter
//
//  Created by Сергей Розов on 06.03.2025.
//

import UIKit

final class ViewController: UIViewController {
    private var counter: Int = 0
    
    /// Скобки () в конце замыкания означают, что это замыкание немедленного действия.
    /// Замыкание вызывается сразу при загрузке ViewController.
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        return formatter
    }()
    
    private var formattedDate: String {
        return dateFormatter.string(from: Date())
    }
    
    private let counterKey = "counterValue"
    private let historyKey = "historyText"

    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var plusButton: UIButton!
    @IBOutlet private weak var minusButton: UIButton!
    @IBOutlet private weak var resetButton: UIButton!
    @IBOutlet private weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Загружаем значение счётчика
        counter = UserDefaults.standard.integer(forKey: counterKey)
        //Загружаем историю
        textView.text = UserDefaults.standard.string(forKey: historyKey) ?? "История изменений:\n\n"
        
        counterLabel.text = "Значение счётчика\n\(counter)"
        textView.isEditable = false
    }
    
    private func saveData() {
        UserDefaults.standard.set(counter, forKey: counterKey)
        UserDefaults.standard.set(textView.text, forKey: historyKey)
    }
    
    /// Прокручивает UITextView до самого низа, чтобы последние строки были видны.
    /// Вызывается при добавлении нового текста в textView, чтобы прокрутить к последней записи.
    private func scrollTextViewToBottom() {
        let range = NSMakeRange(textView.text.count, 0)
        textView.scrollRangeToVisible(range)
    }
    
    @IBAction private func increaseCounter(_ sender: Any) {
        counter += 1
        counterLabel.text = "Значение счётчика\n\(counter)"
        textView.text.append(contentsOf: "\(formattedDate): Значение изменено на +1\n")
        scrollTextViewToBottom()
        saveData()
    }
    
    @IBAction private func decreaseCounter(_ sender: Any) {
        if counter > 0 {
            counter -= 1
            textView.text.append(contentsOf: "\(formattedDate): Значение изменено на -1\n")
        } else {
            counter = 0
            textView.text.append(contentsOf: "\(formattedDate): Попытка уменьшить значение счётчика ниже 0\n")
        }
        scrollTextViewToBottom()
        counterLabel.text = "Значение счётчика\n\(counter)"
        saveData()
    }
    
    @IBAction private func resetCounter(_ sender: Any) {
        counter = 0
        counterLabel.text = "Значение счётчика\n\(counter)"
        textView.text.append(contentsOf: "\(formattedDate): Значение сброшено\n")
        scrollTextViewToBottom()
        saveData()
    }
}

