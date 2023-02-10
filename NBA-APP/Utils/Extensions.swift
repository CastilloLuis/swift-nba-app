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

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension Date {
    
    func getDates(forLastNDays nDays: Int) -> [String] {
        let cal = NSCalendar.current
        // start with today
        var date = cal.startOfDay(for: Date())

        var arrDates = [String]()

        for _ in 1 ... nDays {
            // move back in time by one day:
            date = cal.date(byAdding: Calendar.Component.day, value: -1, to: date)!

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: date)
            arrDates.append(dateString)
        }
        return arrDates
    }
    
    func dateToHuman(_ dateStr: String) -> String {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let formattedBirthdayDate = dateFormatter.date(from: dateStr) else { return "-" }
        
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
        return dateFormatter.string(from: formattedBirthdayDate)
    }
    
    
    func calculateAge(_ dateStr: String) -> String {
        let today = Date.now
        
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            
        guard let date = dateFormatter.date(from: dateStr) else {
           return  "18"
        }
        
        dateFormatter.dateFormat = "yyyy"
        let todayYear = dateFormatter.string(from: today)
        let birthdayYear = dateFormatter.string(from: date)

        let age = Int(todayYear)! - Int(birthdayYear)!
        
        return String(age)
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

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    func swipe(
        up: @escaping (() -> Void) = {},
        down: @escaping (() -> Void) = {},
        left: @escaping (() -> Void) = {},
        right: @escaping (() -> Void) = {}
    ) -> some View {
        return self.gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onEnded({ value in
                if value.translation.width < 0 { left() }
                if value.translation.width > 0 { right() }
                if value.translation.height < 0 { up() }
                if value.translation.height > 0 { down() }
            }))
    }
}

extension String{
     func toCurrencyFormat() -> String {
        if let intValue = Int(self) {
           let numberFormatter = NumberFormatter()
            numberFormatter.locale = Locale.current
           numberFormatter.numberStyle = NumberFormatter.Style.currency
           return numberFormatter.string(from: NSNumber(value: intValue)) ?? ""
        }
         return ""
    }


    func dateToHuman(_ dateStr: String) -> String {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let formattedBirthdayDate = dateFormatter.date(from: dateStr) else { return "-" }
        
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
        return dateFormatter.string(from: formattedBirthdayDate)
    }
}
