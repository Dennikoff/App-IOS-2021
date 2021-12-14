//
//  SecondaryTrackerViewModel.swift
//  SnoKE
//
//  Created by Ilya Buldin on 21.10.2021.
//

import Foundation
import FirebaseAuth

enum SecondaryTrackerViewType {
    case savedMoney
    case brokenCigarettes
    
    var icon: String {
        switch self {
        case .savedMoney:
            return "paymentIcon"
        case .brokenCigarettes:
            return "brokenCigarette"
        }
    }
}

struct SecondaryTrackerModel {
    let type: SecondaryTrackerViewType
    var number: Int {
        
        guard let daysWithoutCigarettes = HomeService.shared.getDaysWithoutCigarettes(),
              let minutesWithoutCigarettes = HomeService.shared.getMinutesOverDaysWithoutSmoking(),
              let hoursWithoutSmoking = HomeService.shared.getHoursWithoutSmoking() else {
            return -1
        }
        
        switch self.type {
        case .savedMoney:            
            guard let numberPerDay = UserDefaults.standard.string(forKey: "com.SnoKEapp.SnoKE.numberPerDay.\(AuthManager.shared.currentUserID)"),
                  let packPrice = UserDefaults.standard.string(forKey: "com.SnoKEapp.SnoKE.packPrice.\(AuthManager.shared.currentUserID)"),
                  let numberInPack = UserDefaults.standard.string(forKey: "com.SnoKEapp.SnoKE.numberInPack.\(AuthManager.shared.currentUserID)") else {
                return -1
            }
            
//            return 144
            let priceOfNotSmokedCiggarets = (Int(packPrice)! / Int(numberInPack)!) * Int(numberPerDay)!
            return Int(priceOfNotSmokedCiggarets * (daysWithoutCigarettes + (minutesWithoutCigarettes*hoursWithoutSmoking)/1440))
        case .brokenCigarettes:
            guard let numberPerDay = UserDefaults.standard.string(forKey: "com.SnoKEapp.SnoKE.numberPerDay.\(AuthManager.shared.currentUserID)") else {
                return -1
            }
//            print("[DEBUG] brokenCigarettes, \(Thread.isMainThread)")
//        return 145
            return Int(numberPerDay)! * daysWithoutCigarettes
        }
    }
}
