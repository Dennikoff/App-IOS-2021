//
//  Date.swift
//  SnoKE
//
//  Created by Ilya Buldin on 13.12.2021.
//

import Foundation

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
