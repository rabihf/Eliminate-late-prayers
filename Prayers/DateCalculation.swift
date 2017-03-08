//
//  DateCalculation.swift
//  Prayers
//
//  Created by Rabih Fawaz on 15/02/2017.
//  Copyright © 2017 Rabih Fawaz. All rights reserved.
//

import Foundation

func CalcTodayDate(x:Int)->String
{
    let todayDate = Date()
    var targetDate = Date()
    let calendar = Calendar.current
    targetDate = calendar.date(byAdding: .day, value: x, to: todayDate)!
    
    var targetComponents = calendar.dateComponents([.year, .month, .day, .weekday], from: targetDate)
    
    let myYear =  targetComponents.year!
    let myMonth = targetComponents.month!
    let myDay = targetComponents.day!
    let weekday = targetComponents.weekday!
    //        print(myDay)
    
    
    
    var week:String = ""
    switch weekday {
    case 1:
        week = "Sunday"
    case 2:
        week = "Monday"
    case 3:
        week = "Tuesday"
    case 4:
        week = "Wednesday"
    case 5:
        week = "Thursday"
    case 6:
        week = "Friday"
    case 7:
        week = "Saturday"
    default:
        break
    }
    
    let monthStr = ["January","February","March","April","May","June","July","August","September","October","November","December"]
    
    
    
    let myCalcDate = week + ", " + monthStr[myMonth-1] + " " + String(myDay) + ", "  + String(myYear)
    
    print("myDay: " + String(myDay) + " x: " + String(x))
    return myCalcDate
}
