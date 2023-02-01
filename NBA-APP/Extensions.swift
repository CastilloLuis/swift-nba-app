//
//  Extensions.swift
//  NBA-APP
//
//  Created by Luis Castillo on 2/1/23.
//

import Foundation
import SwiftUI

struct Last7DaysFormat {
    let datesAsString: [String]
    let dates: [Date]
}

extension Date {
    func getLast7Days(asString: Bool = true) -> Last7DaysFormat  {
        let dateInWeek = Date()
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-DD"

        let calendar = Calendar.current
        let dayOfWeek = calendar.component(.weekday, from: dateInWeek)
        let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: dateInWeek.addingTimeInterval(60 * 60 * 24 * 7 * -1))!
        let dates = (weekdays.lowerBound ..< weekdays.upperBound)
            .compactMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: dateInWeek.addingTimeInterval(60 * 60 * 24 * 7 * -1)) }
        var stringDates: [String] = []
        
        for date in dates {
            let formattedDate = dateFormatter.string(from: date)
            stringDates.append(formattedDate)
        }
    
        return Last7DaysFormat(datesAsString: stringDates, dates: dates)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
