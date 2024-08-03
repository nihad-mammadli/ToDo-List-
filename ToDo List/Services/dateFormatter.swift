//
//  DateFormatter.swift
//  ToDo List
//
//  Created by Nebula on 03.08.24.
//

import UIKit

public class dateFormatter {
    static let shared: dateFormatter = dateFormatter()
    
    private init() { }
    
    func formatDate(date: Date?) -> String {
        guard let date = date else { return " "}
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MMMM d, YYYY HH:mm"
        let newDate = dateformatter.string(from: date)
        return newDate
    }
    
}
