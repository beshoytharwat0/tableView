//
//  ViewController.swift
//  tableview
//
//  Created by Mac on 9/4/20.
//  Copyright © 2020 beshoy tharwat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var tableView : UITableView = {
        let tb = UITableView(frame: .zero, style: .plain)
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.register(TableCell.self, forCellReuseIdentifier: "TableCell")
        return tb
    }()
    var itemArray = [String?]()
     var textField = UITextField()
    var indexGivenNumber = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem))
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        layout()
    }
    private func layout() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    @objc func addNewItem(){
       
        let alert = UIAlertController(title: "Add item", message: "", preferredStyle: .alert)
        let add = UIAlertAction(title: "Add", style: .default) { (action) in
            
            if self.itemArray.count == 0 {
                self.insertElementAtIndex(element:self.textField.text ?? "", index: 15)
            }
//            if self.itemArray.isEmpty {
//                self.itemArray.insert(self.textField.text ?? "", at: 0)
//                self.tableView.performBatchUpdates({
//                    self.tableView.insertRows(at: [IndexPath(row: 0,section: 0)],with: .automatic)}, completion: nil)
//            }else {
//                self.itemArray.insert(self.textField.text ?? "", at: 1)
//                self.tableView.performBatchUpdates({
//                    self.tableView.insertRows(at: [IndexPath(row: 1,section: 0)],with: .automatic)}, completion: nil)
//            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add  item"
            self.textField = alertTextField
        }
//        alert.addTextField { (alertIndexField) in
//            alertIndexField.placeholder = "add Index"
//            alertIndexField.keyboardType = .numberPad
//            self.indexGivenNumber = Int(alertIndexField.text!) ?? 0
//        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        alert.addAction(add)
        present(alert, animated: true, completion: nil)
    }
    
  private  func insertElementAtIndex(element: String?, index: Int) {
        
        while itemArray.count <= index {
             itemArray.append("")
            tableView.reloadData()
            print(itemArray)
        }
        
        itemArray.insert(element, at: index)
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
            cell.textLabel?.text = itemArray[indexPath.row]
        return cell
   }
}


