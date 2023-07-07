//
//  AddEditEmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by Jon Salkin on 5/24/23.
//

import UIKit

class AddEditEmojiTableViewController: UITableViewController {
    
    var emoji: Emoji?
    
    init?(coder: NSCoder, emoji: Emoji?) {
        self.emoji = emoji
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - IBOutlets
    @IBOutlet var symbolTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var usageTextField: UITextField!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    
    
    //MARK: - VDL
    override func viewDidLoad() {
        super.viewDidLoad()

        if let emoji = emoji {
            symbolTextField.text = emoji.symbol
            nameTextField.text = emoji.name
            descriptionTextField.text = emoji.description
            usageTextField.text = emoji.usage
            title = "Edit Emoji"
        } else {
            title = "Add Emoji"
        }
        
        updateSaveButtonState()
    }

    //MARK: - IBActions
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    

    //MARK: - Methods
    func updateSaveButtonState() {
        
        let nameText = nameTextField.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        let usageText = usageTextField.text ?? ""
        saveButton.isEnabled = containsSingleEmoji(symbolTextField) && !nameText.isEmpty && !descriptionText.isEmpty && !usageText.isEmpty
    }

    
    func containsSingleEmoji(_ textField: UITextField) -> Bool {
        guard let text = textField.text, text.count == 1 else {
            return false
        }
        
            let isCombinedIntoEmoji = text.unicodeScalars.count > 1 &&
               text.unicodeScalars.first?.properties.isEmoji ?? false
            let isEmojiPresentation = text.unicodeScalars.first?.properties.isEmojiPresentation ?? false
        
            return isEmojiPresentation || isCombinedIntoEmoji
        
    }
    
    
}


