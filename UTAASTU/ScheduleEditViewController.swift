//
//  ScheduleViewController.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 26/07/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import UIKit
import Firebase
import SwipeCellKit
import KRProgressHUD
import MobileCoreServices

class ScheduleEditViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, SwipeTableViewCellDelegate, UIDocumentMenuDelegate, UIDocumentPickerDelegate {
    
    let DAYS: [String] = ["MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATERDAY", "SUNDAY"]
    
    @IBOutlet weak var tableView: UITableView!
    
    var progressHUD: ProgressHUD!
    
    var days: [DayItem] = []
    var lectures: [LectureItem] = []
    var added: [String] = []
    
    //DatePickerVars
    var startTimes = [Date]()
    var endTimes = [Date]()
    let timePicker = UIPickerView()
    var tempStart: Date!
    var tempEnd: Date!
    var tempField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressHUD = ProgressHUD(text: "Downloading... please wait", block: false)
        progressHUD.hide()
        self.view.addSubview(progressHUD)
        
        // Do any additional setup after loading the view.
        
        CustomizeView.dropShadow(layer: self.navigationController!.navigationBar.layer)
        
        downloadSchedule()
        initPickerView()
    }
    
    //  MARK: Download data
    
    func downloadSchedule() {
        progressHUD?.show()
        
        database.child(KLECTURES).child((Auth.auth().currentUser?.uid)!).observe(.value, with: {
            (snapshot) in
            
            var tempDay: DayItem!
            
            for day in snapshot.children {
                
                var key = (day as! DataSnapshot).key
                key.remove(at: key.startIndex)
                tempDay = DayItem.init(day: key, items: 0)
                
                if (day as! DataSnapshot).childrenCount > 0 {
                    self.days.append(tempDay)
                    self.added.append(key)
                }
                
                for lecture in (day as! DataSnapshot).children {
                    
                    let lec = (lecture as! DataSnapshot).value as! NSDictionary
                    
                    self.lectures.append(LectureItem.init(dic: lec))
                    
                    tempDay.items += 1
                    
                }
                
                
            }
            
            if self.days.count != self.DAYS.count {
                for (index, day) in self.DAYS.enumerated() {
                    
                    if !self.added.contains(day){
                        let item = DayItem.init(day: day, items: 0)
                        self.days.insert(item, at: index)
                    }
                    
                    if self.days.count == self.DAYS.count {
                        break
                    }
                    
                }
            }
            
            self.tableView.reloadData()
            
        })
            
        self.progressHUD.hide()
        
    }
    
    //  MARK: TableView Setup
    
    func numberOfSections(in tableView: UITableView) -> Int {
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 8
        }else if indexPath.row == days[indexPath.section-1].items + 1 {
            return 56
        }
        
        return 36
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 0 : days[section - 1].items + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let totalRow = tableView.numberOfRows(inSection: indexPath.section)
        
        if indexPath.row == 0 {
            
            //return header cell
            
            let colorsCell = tableView.dequeueReusableCell(withIdentifier: "ColorsCell", for: indexPath) as! ColorsTableViewCell
            
            return colorsCell
            
        } else if indexPath.row == totalRow - 1 {
            
            let addButtonCell = tableView.dequeueReusableCell(withIdentifier: "AddButtonCell", for: indexPath) as! AddButtonTableViewCell
            
            addButtonCell.addLecture.tag = indexPath.section
            addButtonCell.addLecture.addTarget(self, action: #selector(holdRelease(sender:)), for: UIControlEvents.touchUpInside)
            
            return addButtonCell
            
        }
        
        let scheduleCell = tableView.dequeueReusableCell(withIdentifier: "ScheduleEditCell", for: indexPath) as! ScheduleEditTableViewCell
        
        scheduleCell.delegate = self
        
        let prev = prevItems(section: indexPath.section - 1)
        let index = indexPath.row - 1  + prev
        
        scheduleCell.setFields(item: lectures[index], delegate: self, tag: index)
        scheduleCell.time.inputView = timePicker
        scheduleCell.time.tag = index + 5
        
        return scheduleCell
    }
    
    func prevItems(section: Int) -> Int {
        
        var prev = 0
        
        for i in 0..<section  {
            
            prev += days[i].items
            
        }
        
        return prev
        
    }
    
    //  MARK: SwipeCellDelegates
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        let indx = prevItems(section: indexPath.section - 1) + indexPath.row - 1
        
        let delete = SwipeAction(style: .destructive, title: nil, handler: {
            (action, indexPath) in
            
            self.days[indexPath.section - 1].items -= 1
            self.lectures.remove(at: indx)
            
            self.tableView.beginUpdates()
            action.fulfill(with: .delete)
            self.tableView.endUpdates()
            
        })
        
        delete.image = UIImage(named: "delete_swipe")?.imageWithColor(.white)
        delete.backgroundColor = UIColor.red
        
        return [delete]
        
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = SwipeTableOptions().transitionStyle
        
        return options
    }
    
    //  MARK: Toolbar buttons
    
    @IBAction func backClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneClicked(_ sender: Any) {
        
        progressHUD.text = "uploading schedule ..."
        progressHUD.show()
        
        LectureItem.updateSchedule(days: days, lectures: lectures, completion: {
            (error) in
            
            self.progressHUD.hide()
            
            if error != nil {
                KRProgressHUD.showError(withMessage: "error uploading the schedule...")
            }else{
                self.dismiss(animated: true, completion: nil)
                KRProgressHUD.showSuccess(withMessage: "uploaded successfully...")
            }
            
        })
        
    }
    
    @IBAction func pickPDF(_ sender: Any) {
        //let url = Bundle.main.url(forResource: "schedule", withExtension: "pdf")
        
        /*  later   */
        
        // Picker
//        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypePDF as String], in: .import)
//        documentPicker.delegate = self
//        present(documentPicker, animated: true, completion: nil)
        // Menu
//        let importMenu = UIDocumentMenuViewController(documentTypes: [kUTTypePDF as String], in: .import)
//        importMenu.delegate = self
//        importMenu.addOption(withTitle: "Create New Document", image: nil, order: .first, handler: { print("New Doc Requested") })
//        present(importMenu, animated: true, completion: nil)
    }
    
    //  MARK: ButtonClick
    
    func holdRelease(sender: UIButton){
        CustomizeView.dropShadow(layer: sender.layer, radius: 2, height: 2, opacity: 0.48)
        let section = sender.tag
        let prev = prevItems(section: section)
        days[section - 1].items += 1
        lectures.insert(LectureItem.init(), at: prev)
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: days[section - 1].items, section: section)], with: UITableViewRowAnimation.automatic)
        tableView.endUpdates()
        
    }
    
    //  MARK: PickerView
    
    func initPickerView(){
        timePicker.delegate = self
        timePicker.dataSource = self
        
        startTimes = setStartTimes()
        endTimes = setEndTimes()
        
        tempStart = startTimes[0]
        tempEnd = endTimes[0]
        
        timePicker.backgroundColor = UIColor.MaterialColors.Primary.blue200
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if component == 1 {
            return self.view.bounds.width * 0.2
        }
        
        return self.view.bounds.width * 0.4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return startTimes.count
        case 1:
            return 1
        case 2:
            return endTimes.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var text = ""
        
        switch component {
        case 0:
            text = getTimeString(from: startTimes[row])
        case 1:
            text = "-"
        case 2:
            text = getTimeString(from: endTimes[row])
        default:
            break
        }
        
        return text
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            tempStart = startTimes[row]
            break
        case 2:
            tempEnd = endTimes[row]
            break
        default:
            break
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        switch component {
        case 0:
            return NSAttributedString(string: getTimeString(from: startTimes[row]), attributes: [NSForegroundColorAttributeName: UIColor.MaterialColors.Primary.blue700])
        case 1:
            return NSAttributedString(string: "-", attributes: [NSForegroundColorAttributeName: UIColor.MaterialColors.Primary.blue700])
        case 2:
            return NSAttributedString(string: getTimeString(from: endTimes[row]), attributes: [NSForegroundColorAttributeName: UIColor.MaterialColors.Primary.blue700])
        default:
            break
        }
        return nil
    }
    
    //  MARK: CreatePickerToolbar
    
    func createToolbar(textField: UITextField){
        
        tempField = textField
        
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.tintColor = UIColor.MaterialColors.Accent.orange500
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(timePicked(sender:)))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(timeCancelled))
        
        toolbar.setItems([doneButton, spaceButton, cancelButton], animated: true)
        
        tempField.inputAccessoryView = toolbar
        
    }
    
    func timePicked(sender: UIBarButtonItem){
        
        let index = tempField.tag - 5
        
        let time = getTimeString(start: tempStart, end: tempEnd)
        
        if time != "" {
            tempField.text = time
            lectures[index].time = time
            tempField.resignFirstResponder()
        }
        
    }
    
    func timeCancelled(){
        tempField.resignFirstResponder()
    }
    
    // MARK: ScrollView & TextFields Fix
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
    
    func didTapView(gesture: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    func addObservers(){
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: nil){
            notification in
            self.keyboardWillShow(notification: notification)
        }
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: nil){
            notification in
            self.keyboardWillHide(notification: notification)
        }
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(notification: Notification){
        guard let userInfo = notification.userInfo,
            let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
        }
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
        tableView.contentInset = contentInset
    }
    
    func keyboardWillHide(notification: Notification){
        tableView.contentInset = UIEdgeInsets.zero
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField{
            
            nextField.becomeFirstResponder()
            
        }else{
            
            textField.resignFirstResponder()
            
        }
        
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.inputView == timePicker {
            createToolbar(textField: textField)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.inputView != timePicker {
            updateField(textField: textField)
        }
    }
    
    func updateField(textField: UITextField) {
        
        let tag = textField.tag
        
        switch textField.placeholder! {
        case "#":
            self.lectures[tag].section = textField.text!
        case "name":
            self.lectures[tag - 1].name = textField.text!
        case "code":
            self.lectures[tag - 2].code = textField.text!
        case "place":
            self.lectures[tag - 3].place = textField.text!
        default:
            return
        }
        
    }
    
    //  DocumentPicker
    
    // MARK:- UIDocumentMenuDelegate
    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    // MARK:- UIDocumentPickerDelegate
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        // Do something
        print("url: \(url)")
    }
    
}
