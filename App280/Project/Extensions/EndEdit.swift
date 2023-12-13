//
//  EndEdit.swift
//  App280
//
//  Created by Вячеслав on 12/13/23.
//

import SwiftUI

extension UIApplication {
    
    func endEditing() {
        
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
