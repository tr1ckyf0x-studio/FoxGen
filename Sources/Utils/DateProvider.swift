//
//  DateProvider.swift
//
//
//  Created by Vladislav Lisianskii on 04.11.2023.
//

import Foundation

struct DateProvider {
    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: Date())
    }
}
