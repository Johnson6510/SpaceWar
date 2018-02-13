//
//  TimerManger.swift
//  SpaceWar
//
//  Created by 黃健偉 on 2018/2/12.
//  Copyright © 2018年 黃健偉. All rights reserved.
//

import UIKit

class TimerManager {
    var _timerTable = [Int: Timer]()
    var _id: Int = 0
    
    // Schedule a timer and return an integer that represents id of the timer
    func startTimer(interval: TimeInterval, target: AnyObject, selector: Selector) -> Int {
        let timer = Timer.scheduledTimer(timeInterval: interval, target: target, selector: selector, userInfo: nil, repeats: true)
        _id += 1
        _timerTable[_id] = timer
        return _id
    }
    
    // Stop a timer of an id
    func stopTimer(id: Int) {
        if let timer = _timerTable[id] {
            if timer.isValid {
                timer.invalidate()
            }
        }
    }
    
    // Returns timer instance of an id
    func getTimer(id: Int) -> Timer? {
        return _timerTable[id]
    }
}

