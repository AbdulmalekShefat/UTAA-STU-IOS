//
//  LeftMenuViewController.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 23/07/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import UIKit
import Firebase
import KRProgressHUD

class LeftMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var drawerTable: UITableView!
    @IBOutlet weak var userName: UITextView!
    @IBOutlet weak var profileImage: UIImageView!
    
    var userData: ProfileData?
    var items:[[String:String]] = drawerItems()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        initImage(image: UIImage(named: "profile_pic")!)
        loadProfileData()
        
    }
    
    //  MARK: USER-DATA
    
    func initImage(image: UIImage){
        
        let newImage = image.scaleImagetoSize(newSize: profileImage.frame.size)
        self.profileImage.image = newImage.circleMask
        CustomizeView.setBorder(layer: profileImage.layer, radius: self.profileImage.bounds.width/2.0)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageClicked(gesture:)))
        
        self.profileImage.addGestureRecognizer(tapRecognizer)
        
    }
    
    func loadProfileData(){
        
        database.child(KUSERS).child((Auth.auth().currentUser?.uid)!).observe(.value, with: {
            (snapshot) in
            
            if snapshot.exists() {
                
                let dic = snapshot.value as! NSDictionary
                
                self.userData = ProfileData.init(dictionary: dic)
                
                self.initProfile(item: self.userData!)
                
            } else {
                
                self.userData = ProfileData.init()
                
                self.initProfile(item: self.userData!)
                
            }
            
            
        })
    }
    
    func initProfile(item: ProfileData){
        
        userName.text = item.name == "" ? item.email : item.name
        
        if item.profilePicture == "" {
            
            initImage(image: UIImage(named: "profile_pic")!)
            
        } else {
            
            imageFromData(imageData: item.profilePicture, withBlock: {
                (image) in
                
                initImage(image: image!)
                
            })
            
        }
        
    }

    
    //  MARK: Click Listeners
    
    func imageClicked(gesture: UITapGestureRecognizer) {
        
        self.sideMenuViewController.hideViewController()
        
        // open profile view controller
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ProfileViewController")
        self.present(controller, animated: true, completion: nil)
        
    }
    
    //  MARK: TableView Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DrawerTableViewCell
        
        let item: [String:String] = items[indexPath.row]
        
        cell.initiate(icon: item["image"]!, label: item["label"]!)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case CellIndx.SOCIAL_GROUPS.rawValue:
            print("Groups")
            break
        case CellIndx.STUDYING_MATERIAL.rawValue:
            print("Materials")
            break
        case CellIndx.EXAM_TABLE.rawValue:
            print("Exam Table")
            break
        case CellIndx.ACADEMIC_CALENDAR.rawValue:
            print("Calendar")
            break
        case CellIndx.UTAA_CONTACTS.rawValue:
            print("Contacts")
            break
        case CellIndx.NOTIFICATIONS.rawValue:
            print("Notifications")
            break
        case CellIndx.ABOUT.rawValue:
            print("About")
            break
        case CellIndx.SETTINGS.rawValue:
            print("Settings")
            break
        default:
            break
            
        }
            
        self.sideMenuViewController.hideViewController()
        
    }
    
}
