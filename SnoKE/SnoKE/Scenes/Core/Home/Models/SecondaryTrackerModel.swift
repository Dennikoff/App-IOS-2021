//
//  SecondaryTrackerViewModel.swift
//  SnoKE
//
//  Created by Ilya Buldin on 21.10.2021.
//

import Foundation

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
    let number: Int
    let icon: String
}
