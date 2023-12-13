//
//  HomeViewModel.swift
//  App280
//
//  Created by Вячеслав on 12/13/23.
//

import SwiftUI
import CoreData

final class HomeViewModel: ObservableObject {
    
    @AppStorage("money") var money: Int = 10000

    @Published var isTopUp: Bool = false
    @Published var topUpField: String = ""
    
    @AppStorage("realty") var realty: [String] = []
    
    @Published var isAddRealty: Bool = false
    @Published var address: String = ""
    
    @Published var isPaymentHistory: Bool = false
    @Published var category: String = ""
    @Published var price: String = ""
    
    @Published var payments: [PaymentModel] = []
    
    func addPayment(_ addressValue: String) {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "PaymentModel", into: context) as! PaymentModel
        
        loan.price = Int16(price) ?? 0
        loan.category = category
        loan.date = Date()
        loan.address = addressValue
        
        CoreDataStack.shared.saveContext()
    }
    
    func fetchPayments(_ addressValue: String) {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<PaymentModel>(entityName: "PaymentModel")

        do {
            
            let result = try context.fetch(fetchRequest)
        
            self.payments = addressValue.isEmpty ? result : result.filter{$0.address == addressValue}
            
        } catch let error as NSError {
            
            print("catch")
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.payments = []
        }
    }
}
