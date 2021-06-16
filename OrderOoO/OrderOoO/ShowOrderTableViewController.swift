//
//  ShowOrderTableViewController.swift
//  OrderOoO
//  Created by 鄭淳澧 on 2021/6/8.
//

import UIKit
import Firebase
import FirebaseFirestore

class ShowOrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var drinkLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var coldLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
}

class ShowOrderTableViewController: UITableViewController {

    var db: Firestore!
    
    @IBOutlet var showTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showTableView.dataSource = self
        showTableView.delegate = self
        
        showTableView.allowsSelectionDuringEditing = true
        
        db = Firestore.firestore()
        
        readData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return nameList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowOrderCell", for: indexPath) as! ShowOrderTableViewCell

        // Configure the cell...
        cell.nameLabel.text = nameList[indexPath.row]
        cell.drinkLabel.text = drinkList[indexPath.row]
        cell.sizeLabel.text = sizeList[indexPath.row]
        cell.sugarLabel.text = sugarList[indexPath.row]
        cell.coldLabel.text = coldList[indexPath.row]
        cell.priceLabel.text = priceList[indexPath.row]
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "取消此訂單", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "再考慮一下", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "確定取消", style: .default, handler: { _ in
            let id = self.documentId[indexPath.row]
            
            self.db.collection("orders").document(id).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
            
            self.documentId.remove(at: indexPath.row)
            self.nameList.remove(at: indexPath.row)
            self.drinkList.remove(at: indexPath.row)
            self.sizeList.remove(at: indexPath.row)
            self.sugarList.remove(at: indexPath.row)
            self.coldList.remove(at: indexPath.row)
            self.priceList.remove(at: indexPath.row)
            self.showTableView.deleteRows(at: [indexPath], with: .automatic)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    var documentId:[String] = []
    var nameList:[String] = []
    var drinkList:[String] = []
    var sizeList:[String] = []
    var sugarList:[String] = []
    var coldList:[String] = []
    var priceList:[String] = []
    
    func readData() {
        db.collection("orders").getDocuments { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                for document in querySnapshot.documents {
                    self.documentId.append(document.documentID)
                    self.nameList.append(document.data()["name"] as! String)
                    self.drinkList.append(document.data()["drink"] as! String)
                    self.sizeList.append(document.data()["size"] as! String)
                    self.sugarList.append(document.data()["sugar"] as! String)
                    self.coldList.append(document.data()["cold"] as! String)
                    self.priceList.append(document.data()["price"] as! String)
                }
            }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        }
    }
    
    
}
