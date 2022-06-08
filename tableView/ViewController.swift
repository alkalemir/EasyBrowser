//
//  ViewController.swift
//  tableView
//
//  Created by Emir Alkal on 8.06.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    
    var datas = ["apple.com", "google.com", "hepsiburada.com", "trendyol.com"]
    
    override func loadView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Sites"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped() {
        let ac = UIAlertController(title: "Add Site", message: "Enter url like example.com", preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
            
            if ac.textFields![0].text! != "" {
                self.datas.append(ac.textFields![0].text!)
                self.tableView.reloadData()
            }
        }))
        
        present(ac, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = datas[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC = DetailViewController()
        
        destinationVC.allowedSites = datas
        destinationVC.urlString = datas[indexPath.row]
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            datas.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

