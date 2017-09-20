//
//  FoodViewController.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 26/07/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import UIKit
import Firebase
import KRProgressHUD

class FoodViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var foodTableView: UITableView!
    @IBOutlet weak var foodPlaceHolder: UIImageView!
    
    var progressHUD: ProgressHUD!
    
    var days: [String] = []
    var items: [Int] = []
    var food: [FoodItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressHUD = ProgressHUD(text: "Downloading... please wait")
        progressHUD.hide()
        self.view.addSubview(progressHUD)

        // Do any additional setup after loading the view.
        
        CustomizeView.dropShadow(layer: self.navigationController!.navigationBar.layer)
        
        modifyImage()
        
        downloadSchedule()
        
    }
    
    // MARK: Menu Buttons

    @IBAction func openLeftMenu(_ sender: Any) {
        
        self.sideMenuViewController.presentLeftMenuViewController()
        
    }
    
    //  MARK: PlaceHolder Image
    
    func modifyImage(){
        let image = UIImage(named: "schedule_bg")?.imageWithColor(UIColor.MaterialColors.Accent.orange500)
        foodPlaceHolder.image = image
        foodPlaceHolder.isHidden = false
    }
    
    //  MARK: Download data
    
    func downloadSchedule() {
        progressHUD?.show()

        database.child(KFOOD).observe(.value, with: {
            (snapshot) in
            
            self.days.removeAll()
            self.food.removeAll()
            self.items.removeAll()
            
            for day in snapshot.children {
                
                self.days.append((day as! DataSnapshot).key)
                self.items.append(Int((day as! DataSnapshot).childrenCount))
                
                for food in (day as! DataSnapshot).children {
                    
                    let item = (food as! DataSnapshot).value as! NSDictionary
                    self.food.append(FoodItem.init(dic: item))
                    
                }
                
            }
            
            self.foodTableView.reloadData()
            
        })
            
        self.progressHUD.hide()
        
    }
    
    //  MARK: TableView Setup
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if food.count == 0 || items.count == 0 {
            modifyImage()
            return 0
        }
        foodPlaceHolder.isHidden = true
        return days.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let dayHeader = DayHeaderView()
        
        dayHeader.setTitle(title: days[section])
        
        return dayHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == days.count ? 24 : 8
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 48
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath) as! FoodTableViewCell
        
        let prev = prevItems(section: indexPath.section)
        
        cell.setFields(item: food[indexPath.row - 1  + prev])

        
        return cell
    }
    
    func prevItems(section: Int) -> Int {
        
        var prev = 0
        
        for i in 0..<section  {
            
            prev += items[i]
            
        }
        
        return prev
        
    }

}
