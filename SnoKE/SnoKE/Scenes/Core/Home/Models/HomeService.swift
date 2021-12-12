//
//  HomeService.swift
//  SnoKE
//
//  Created by Ilya Buldin on 18.11.2021.
//

import UIKit
import FirebaseAuth


protocol HomeServiceProtocol {
    func getCurrentTimeWithoutSmoking() -> TimeWithoutSmokingModel
}


final class HomeService: HomeServiceProtocol {
    
    static let shared: HomeServiceProtocol = HomeService()
    
    func getCurrentTimeWithoutSmoking() -> TimeWithoutSmokingModel {

        guard let user = Auth.auth().currentUser, let finishSmokingDate = UserDefaults.standard.object(forKey: "com.SnoKEapp.SnoKE.finishSmokingDate.\(user.uid)") as? Date else {
            let phDays = TimeWithoutSmokingModel.Days(firstDigit: -1, secondDigit: -1)
            let phHours = TimeWithoutSmokingModel.Hours(firstDigit: -1, secondDigit: -1)
            let phMinutes = TimeWithoutSmokingModel.Minutes(firstDigit: -1, secondDigit: -1)
            let placeholder = TimeWithoutSmokingModel(days: phDays, hours: phHours, minutes: phMinutes)
            return placeholder
        }
        let currentDate = Date()
        let period = currentDate - finishSmokingDate
        print("[DEBUG] Current Date: \(currentDate)")
        print("[DEBUG] Finish Date: \(finishSmokingDate)")
        let daysAmount = (period / 86400)
        let daysAmountRounded = daysAmount.rounded(.towardZero)
        let hoursAmount = (period - daysAmountRounded*86400) / 3600
        let hoursAmountRounded = hoursAmount.rounded(.towardZero)
        let minutesAmount = (period - daysAmountRounded*86400 - hoursAmountRounded*3600) / 60
        let minutesAmountRounded = minutesAmount.rounded(.towardZero)
        
        let days2digit = Int(daysAmountRounded.truncatingRemainder(dividingBy: 10))
        let days1digit = Int((daysAmountRounded / 10).truncatingRemainder(dividingBy: 10))
        
        let hours2digit = Int(hoursAmountRounded.truncatingRemainder(dividingBy: 10))
        let hours1digit = Int((hoursAmountRounded / 10).truncatingRemainder(dividingBy: 10))
        
        let minutes2digit = Int(minutesAmountRounded.truncatingRemainder(dividingBy: 10))
        let minutes1digit = Int((minutesAmountRounded / 10).truncatingRemainder(dividingBy: 10))
        
        
        
        let modelDays = TimeWithoutSmokingModel.Days(firstDigit: days1digit, secondDigit: days2digit)
        let modelHours = TimeWithoutSmokingModel.Hours(firstDigit: hours1digit, secondDigit: hours2digit)
        let modelMinutes = TimeWithoutSmokingModel.Minutes(firstDigit: minutes1digit, secondDigit: minutes2digit)
        let model = TimeWithoutSmokingModel(days: modelDays, hours: modelHours, minutes: modelMinutes)
        
        return model
    }
    
    
    
}
