//
//  TimeWithoutSmokingModel.swift
//  SnoKE
//
//  Created by Ilya Buldin on 14.12.2021.
//

import Foundation

struct TimeWithoutSmokingModel {
    struct Days {
        let firstDigit: Int
        let secondDigit: Int
    }
    
    struct Hours {
        let firstDigit: Int
        let secondDigit: Int
    }
    
    struct Minutes {
        let firstDigit: Int
        let secondDigit: Int
    }
    
    let days: Days
    let hours: Hours
    let minutes: Minutes
}
