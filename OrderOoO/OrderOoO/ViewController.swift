//
//  ViewController.swift
//  OrderOoO
//  Created by 鄭淳澧 on 2021/6/8.
//

import UIKit

struct DrinkData {
    var image: String?
    var name: String?
    var content: String?
    var detail: String?
    var price: String?
}


class MenuListTableViewCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var price: UILabel!
    
    
    func update(with cellData: DrinkData) {
        img.image = UIImage(named: cellData.image!)
        name.text = cellData.name
        content.text = cellData.content
        detail.text = cellData.detail
        price.text = cellData.price
    }
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var menuTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        menuTableView.dataSource = self
        menuTableView.delegate = self
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cellContent.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! MenuListTableViewCell

        let cellData = cellContent[indexPath.row]
        cell.update(with: cellData)

        return cell
    }
    
    let cellContent = [
        DrinkData(image: "drink001.jpg", name: "拿鐵咖啡", content: "熱鮮奶、咖啡", detail: "Caffè Latte就是所謂加了牛奶的咖啡，通常直接音譯為「拿鐵咖啡」甚至「拿鐵」或「那提」。", price: "$45.00"),
        DrinkData(image: "drink002.jpg", name: "魔幻美人魚", content: "調味咖啡", detail: "混合红色火龍果和芒果醬，撒上藍莓粉和鮮奶油，最後裝飾上巧克力魚尾，繽紛粉嫩的色調肯定是2020年夏季必喝飲品。", price: "$105.00"),
        DrinkData(image: "drink003.jpg", name: "芋頭牛奶", content: "芋頭、牛奶", detail: "嚴選新鮮大甲芋頭加上二砂， 純手工翻攪熬煮及悶煮將近1小時才能起鍋。", price: "$65.00"),
        DrinkData(image: "drink004.jpg", name: "阿華田", content: "偽裝美祿", detail: "包括51.6%糖（每30g含15.5克糖）、麥芽精華及乳清，後期加入可可粉。", price: "$55.00"),
        DrinkData(image: "drink005.jpg", name: "四季春", content: "四季春茶葉", detail: "香氣十足卻因茶湯苦澀， 以致價格低廉且多僅做罐裝茶飲及手搖茶原料。", price: "$55.00"),
        DrinkData(image: "drink006.jpg", name: "文山包種", content: "文山包種茶葉", detail: "色澤翠綠，水色蜜綠鮮豔帶黃金，香氣清香幽雅似花香，滋味甘醇滑潤帶活，香氣越濃郁品質越高級。", price: "$75.00"),
        DrinkData(image: "drink007.jpg", name: "珍珠奶茶", content: "奶茶、大顆粉圓", detail: "有兩家臺灣茶飲業者宣稱自己是發明者，一是源自臺中的春水堂，另一是源自臺南的翰林茶館。", price: "$55.00"),
        DrinkData(image: "drink008.jpg", name: "墨汁", content: "煤煙、松煙、明膠", detail: " 透過硯用水研磨可以產生用於毛筆書寫的墨汁，在水中以膠體的溶液存在。", price: "$66.00"),
        DrinkData(image: "drink009.jpg", name: "檸檬汁", content: "維生素C、鉀、葉酸", detail: "每100g，含蛋白質1g、脂肪0.3g、碳水化合物6.9g、纖維2.1g，提供121.4KJ熱量。", price: "$87.00"),
        DrinkData(image: "drink010.jpg", name: "養樂多", content: "水、各種化學物質", detail: "市面上充斥各種冒牌貨，內容物並無乳酸菌，不幫助消化，其實本家的也差不多啦！", price: "$15.00"),
        DrinkData(image: "drink011.jpg", name: "桂圓茶", content: "水、桂圓", detail: "用比桂圓重的水泡出來的桂圓茶，而且紅棗用完了所以半價，不建議女性直飲，燥熱。", price: "$44.00"),
        DrinkData(image: "drink012.jpg", name: "薑母茶", content: "熱水、薑母片", detail: "據說對禦寒有功效，如果喝完還是覺得冷，那是你體質差。", price: "$88.00"),
    ]

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? OrderTableViewController,
           let _ = menuTableView.indexPathForSelectedRow?.section,
           let row = menuTableView.indexPathForSelectedRow?.row {
            controller.cellData = cellContent[row]
        }
    }
    
    
}

