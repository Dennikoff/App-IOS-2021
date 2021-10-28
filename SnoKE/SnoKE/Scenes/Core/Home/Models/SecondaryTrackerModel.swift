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
}

struct SecondaryTrackerModel {
    let type: SecondaryTrackerViewType
    let number: Int
    let icon: String
}
