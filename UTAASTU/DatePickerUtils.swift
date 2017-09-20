//
//  DatePickerUtils.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 04/08/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import Foundation
import KRProgressHUD

func getDays(of date: Date, fromNow plus: Int = 45) -> [Date] {
        var dates = [Date]()
        
        let calendar = Calendar.current
        
        // first date
        var currentDate = date
        
        // adding 30 days to current date
        let oneMonthFromNow = calendar.date(byAdding: .day, value: plus, to: currentDate)
        
        // last date
        let endDate = oneMonthFromNow
        
        while currentDate <= endDate! {
            dates.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        return dates
    }
    
    func getTimes(of date: Date) -> [Date] {
        var times = [Date]()
        var currentDate = date
        
        currentDate = Calendar.current.date(bySetting: .hour, value: 7, of: currentDate)!
        currentDate = Calendar.current.date(bySetting: .minute, value: 00, of: currentDate)!
        
        let calendar = Calendar.current
        
        let interval = 10
        var nextDiff = interval - calendar.component(.minute, from: currentDate) % interval
        var nextDate = calendar.date(byAdding: .minute, value: nextDiff, to: currentDate) ?? Date()
        
        var hour = Calendar.current.component(.hour, from: nextDate)
        
        while(hour < 23) {
            times.append(nextDate)
            
            nextDiff = interval - calendar.component(.minute, from: nextDate) % interval
            nextDate = calendar.date(byAdding: .minute, value: nextDiff, to: nextDate) ?? Date()
            
            hour = Calendar.current.component(.hour, from: nextDate)
        }
        
        return times
    }
    
    func setDays() -> [Date] {
        let today = Date()
        return getDays(of: today)
    }
    
    func setStartTimes() -> [Date] {
        let today = Date()
        return getTimes(of: today)
    }
    
    func setEndTimes() -> [Date] {
        let today = Date()
        return getTimes(of: today)
    }
    
    func getDayString(from: Date) -> String {
        return dayFormatter().string(from: from)
    }
    
    func getTimeString(from: Date) -> String {
        return timeFormatter().string(from: from)
    }

func getTimeString(start: Date, end: Date) -> String{
    if compareDates(start: start, end: end) {
        return timeFormatter().string(from: start) + " - " + timeFormatter().string(from: end)
    }else{
        KRProgressHUD.showError(withMessage: "time must be at lease 50 mins")
        return ""
    }
}

func compareDates(start: Date, end: Date) -> Bool {
    let mins = 50
    let calendar = Calendar.current
    let nextDate = calendar.date(byAdding: .minute, value: mins, to: start) ?? Date()
    return end >= nextDate
    
}







