//
//  habit.swift
//  project1_01
//
//  Created by Isaac Sheets on 10/7/18.
//  Copyright © 2018 Isaac Sheets. All rights reserved.
//

import Foundation

struct Habit : Codable {
    var habitTitle : String
    var numTimes : Int
    var timeInterval : Int
    var secBetween : TimeInterval
    var costPerTime : Float
    var costPerSec : Float
    var dateCreated : Date
    var curDate : Date
    var timeSince : String
    var moneySaved : Double
}
