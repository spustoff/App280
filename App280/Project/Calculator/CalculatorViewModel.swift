//
//  CalculatorViewModel.swift
//  App280
//
//  Created by Вячеслав on 12/13/23.
//

import SwiftUI

final class CalculatorViewModel: ObservableObject {
    
    @Published var isResult: Bool = false
    
    @Published var service: String = ""
    @Published var cost: String = ""
    @Published var quantity: Int = 0
    
    
}
