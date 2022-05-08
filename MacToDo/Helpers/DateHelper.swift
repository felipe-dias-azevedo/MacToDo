//
//  DateHelper.swift
//  MacToDo
//
//  Created by felipe azevedo on 08/05/22.
//

import Foundation

struct DateHelper {
    static func toString(_ date: Date) -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "dd/MM/YYYY"
        
        return dateFormatter.string(from: date)
    }
}
