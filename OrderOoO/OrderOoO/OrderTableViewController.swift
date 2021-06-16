//
//  OrderTableViewController.swift
//  OrderOoO
//  Created by 鄭淳澧 on 2021/6/8.
//

import UIKit
import Firebase
import FirebaseFirestore

class OrderTableViewController: UITableViewController {

    var cellData = DrinkData()
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        setCellData(with: cellData)
    }

    
    @IBOutlet weak var imgLabel: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var orderNameLabel: UITextField!
    @IBOutlet weak var orderColdLabel: UISegmentedControl!
    @IBOutlet weak var orderSizeLabel: UISegmentedControl!
    @IBOutlet weak var orderSugarLabel: UISegmentedControl!
    
    
    func setCellData(with cellData: DrinkData) {
        imgLabel.image = UIImage(named: cellData.image!)
        nameLabel.text = cellData.name
        contentLabel.text = cellData.content
        detailLabel.text = cellData.detail
        priceLabel.text = cellData.price
    }
    
    
    @IBAction func orderSend(_ sender: Any) {
        
        if orderNameLabel.text == "" {
            print("[name] == empty")
        }else {
            db.collection("orders").addDocument(data: [
                "name": orderNameLabel.text ?? "",
                "drink": nameLabel.text ?? "",
                "price": priceLabel.text ?? "",
                "size": orderSizeLabel.titleForSegment(at: orderSizeLabel.selectedSegmentIndex) ?? "",
                "sugar": orderSugarLabel.titleForSegment(at: orderSugarLabel.selectedSegmentIndex) ?? "",
                "cold": orderColdLabel.titleForSegment(at: orderColdLabel.selectedSegmentIndex) ?? "",
            ]) { (error) in
                if let error = error {
                    print(error)
                }
            }
        self.performSegue(withIdentifier: "sendOrderDB", sender: nil)
        }
    }
    
    
}
