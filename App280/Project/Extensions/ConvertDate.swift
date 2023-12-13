//
//  ConvertDate.swift
//  App280
//
//  Created by Вячеслав on 12/13/23.
//

import SwiftUI

extension Date {
    
    func convertDate(format: String) -> String {
        
        let date = self
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
}
