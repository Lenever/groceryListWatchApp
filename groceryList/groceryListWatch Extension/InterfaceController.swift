//
//  InterfaceController.swift
//  groceryListWatch Extension
//
//  Created by Ikechukwu Onuorah on 21/11/2020.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    @IBOutlet var myTable: WKInterfaceTable!
    let userDefault = UserDefaults()
    
    override func awake(withContext context: Any?) {
        reloadTable()
    }
    
    override func willActivate() {
    }
    
    override func didDeactivate() {
    }
    
    func reloadTable() {
        if let tasks = userDefault.object(forKey: "myList") as? [String] {
            var x = 0
            
            self.myTable.setNumberOfRows(tasks.count, withRowType: "cell")
            
            for task in tasks {
                let row = self.myTable.rowController(at: x) as? RowController
                row?.myLabel.setText(task)
                x += 1
            }
        }
    }
    
    @IBAction func addButtonTaped() {
        self.presentTextInputController(withSuggestions: nil, allowedInputMode: .allowEmoji) { (result) in
            guard let result = result else { return }
            OperationQueue.main.addOperation {
                var string: [String] = self.userDefault.object(forKey: "myList") as? [String] ?? []
                string.append(result[0] as? String ?? String())
                self.dismissTextInputController()
                self.userDefault.set(string, forKey: "myList")
                self.reloadTable()
            }
        }
    }
}
