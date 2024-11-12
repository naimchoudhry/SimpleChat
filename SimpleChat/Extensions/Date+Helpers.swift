//
//  Date+Helpers.swift
//  SimpleChat
//
//  Created by Naim Choudhry on 12/11/2024.
//

import Foundation

extension Date {
    
    /// Format date to strings rounded ro nearest from today
    /// - Returns: String representation of date
    func formatRelativeString() -> String {
        let dateFormatter = DateFormatter()
        let calendar = Calendar(identifier: .gregorian)
        dateFormatter.doesRelativeDateFormatting = true

        if calendar.isDateInToday(self) {
            dateFormatter.timeStyle = .short
            dateFormatter.dateStyle = .none
        } else if calendar.isDateInYesterday(self){
            dateFormatter.timeStyle = .short
            dateFormatter.dateStyle = .medium
        } else if calendar.compare(Date(), to: self, toGranularity: .weekOfYear) == .orderedSame {
            let weekday = calendar.dateComponents([.weekday], from: self).weekday ?? 0
            return dateFormatter.weekdaySymbols[weekday-1]
        } else {
            dateFormatter.timeStyle = .short
            dateFormatter.dateStyle = .medium
        }

        return dateFormatter.string(from: self)
    }
}
