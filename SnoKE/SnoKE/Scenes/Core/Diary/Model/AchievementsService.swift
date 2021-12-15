//
//  AchievementsModel.swift
//  SnoKE
//
//  Created by Ilya Buldin on 15.12.2021.
//

import UIKit
import FirebaseFirestore


enum AchievementType: Int {
    case health = 0
    case scope = 1
    case ecology = 2
    case budget = 3
    
    
    var category: String {
        switch self {
        case.budget:
            return "Бюджет"
        case.ecology:
            return "Экология"
        case .health:
            return "Здоровье"
        case .scope:
            return "Масштабы"
        }
    }
    
    var imageSystemName: String {
        switch self {
        case .budget:
            return "rublesign.square.fill"
        case .ecology:
            return "drop.fill"
        case .health:
            return "lessthan.square.fill"
        case .scope:
            return "globe"
        }
    }
}

struct AchievementModel {
    let date: String
    let chapter: String
    let description: String
    let text: String
    let numberCigarettes: Int
    let type: AchievementType
    
    init(data: [String:Any]) {
        chapter = data["chapter"] as? String ?? ""
        description = data["description"] as? String ?? ""
        text = data["text"] as? String ?? ""
        numberCigarettes = data["numberCigarettes"] as? Int ?? -1
        type = AchievementType(rawValue: data["category"] as? Int ?? 3) ?? .budget
        
        guard let numberPerDay = UserDefaults.standard.string(forKey: "com.SnoKEapp.SnoKE.numberPerDay.\(AuthManager.shared.currentUserID)") else {
            date = "error"
            return
        }
        guard let finishSmokingDate = UserDefaults.standard.object(forKey: "com.SnoKEapp.SnoKE.finishSmokingDate.\(AuthManager.shared.currentUserID)") as? Date else {
            date = "error"
            return
        }
        
        let tmp: Double = Double(numberCigarettes / Int(numberPerDay)!)
        
        let interval = TimeInterval(tmp.rounded(.up)*86400)
        
        let resultDate = Date(timeInterval: interval, since: finishSmokingDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dateString = dateFormatter.string(from: resultDate)
        date = dateString
        
    }
    
}

//protocol AchievementsServiceProtocol {
////    func getAppropriateAchievements(tableView: UITableView, achievements: inout [AchievementModel])
//}
//
//final class AchievementsService: AchievementsServiceProtocol {
//    
//    static let shared: AchievementsServiceProtocol = AchievementsService()
//     
//
//    
//    
//}

