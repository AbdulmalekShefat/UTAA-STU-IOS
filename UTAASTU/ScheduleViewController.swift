//
//  ScheduleViewController.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 26/07/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import UIKit
import Firebase
import KRProgressHUD

class ScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var placeHolderImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var progressHUD: ProgressHUD!
    
    var days: [DayItem] = []
    var lectures: [LectureItem] = []

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
    
    //  MARK: PlaceHolder Image
    
    func modifyImage(){
        let image = UIImage(named: "schedule_bg")?.imageWithColor(UIColor.MaterialColors.Accent.orange500)
        placeHolderImage.image = image
        placeHolderImage.isHidden = false
    }
    
    //  MARK: Download data
    
    func downloadSchedule() {
        progressHUD?.show()
        
        database.child(KLECTURES).child((Auth.auth().currentUser?.uid)!).observe(.value, with: {
            (snapshot) in
            
            self.days.removeAll()
            self.lectures.removeAll()
            
            var tempDay: DayItem!
            
            for day in snapshot.children {
                
                var key = (day as! DataSnapshot).key
                key.remove(at: key.startIndex)
                tempDay = DayItem.init(day: key, items: 0)
                
                if (day as! DataSnapshot).childrenCount > 0 {
                    self.days.append(tempDay)
                }
                
                for lecture in (day as! DataSnapshot).children {
                    
                    let lec = (lecture as! DataSnapshot).value as! NSDictionary
                    
                    self.lectures.append(LectureItem.init(dic: lec))
                    
                    tempDay.items += 1
                    
                }
                
                
            }
            
            self.tableView.reloadData()
            
        })
        
        self.progressHUD.hide()
        
    }
    
    //  MARK: TableView Setup
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if lectures.count == 0{
            modifyImage()
            return 0
        }
        placeHolderImage.isHidden = true
        return days.count + 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            
            return ColorsView()
        }
        
        let dayHeader = DayHeaderView()
        
        dayHeader.setTitle(title: days[section - 1].day)
        
        return dayHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 144 : 48
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == days.count ? 24 : 8
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 8
        }
        
        return 36
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 0 : days[section - 1].items + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            //return header cell
            
            let colorsCell = tableView.dequeueReusableCell(withIdentifier: "ColorsCell", for: indexPath) as! ColorsTableViewCell
            
            CustomizeView.dropShadow(layer: (colorsCell.contentView.superview?.layer)!, radius: 4, height: -2.0, width: 0, opacity: 0.25)
            
            return colorsCell
        
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell", for: indexPath) as! ScheduleTableViewCell
        
        let prev = prevItems(section: indexPath.section - 1)
        
        cell.setFields(item: lectures[indexPath.row - 1  + prev])
        
        let totalRow = tableView.numberOfRows(inSection: indexPath.section)
        
        if indexPath.row == totalRow - 1 {
            
            // todo: set shadow for last cell
            
            CustomizeView.dropShadow(layer: (cell.contentView.superview?.layer)!, radius: 2.0, height: 4.0, width: 0, opacity: 0.2)
            
        }else{
           CustomizeView.dropShadow(layer: (cell.contentView.superview?.layer)!, radius: 0, height: 0, width: 0, opacity: 0)
        }
        
        return cell
    }
    
    func prevItems(section: Int) -> Int {
        
        var prev = 0
        
        for i in 0..<section  {
            
            prev += days[i].items
            
        }
        
        return prev
        
    }

    //  MARK: Toolbar buttons
    
    @IBAction func openLeftMenu(_ sender: Any) {
        
        self.sideMenuViewController.presentLeftMenuViewController()
    
    }
    
    @IBAction func shareSchedule(_ sender: Any) {
        if lectures.count == 0 {
            KRProgressHUD.showInfo(withMessage: "schedule is empty")
            return
        }
        
//        let screenShot = UIImage().screenshot(tableView: self.tableView)
    }
    @IBAction func editSchedule(_ sender: Any) {
        //  open edit schedule viewController
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "EditScheduleVC")
        self.present(controller, animated: true, completion: nil)
    }
    
}
