//
//  HistoryView.swift
//  App280
//
//  Created by Вячеслав on 12/13/23.
//

import SwiftUI

struct HistoryView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("History")
                    .foregroundColor(.black)
                    .font(.system(size: 25, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                if viewModel.payments.isEmpty {
                    
                    Text("No payments Detected")
                        .foregroundColor(.black)
                        .font(.system(size: 26, weight: .semibold))
                        .padding()
                        .frame(maxHeight: .infinity, alignment: .center)
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack {
                            
                            ForEach(viewModel.payments, id: \.self) { index in
                            
                                HStack {
                                    
                                    Image(systemName: "arrow.down")
                                        .foregroundColor(.red)
                                        .font(.system(size: 16, weight: .regular))
                                    
                                    VStack(alignment: .leading, spacing: 2, content: {
                                        
                                        Text(index.category ?? "")
                                            .foregroundColor(.black)
                                            .font(.system(size: 16, weight: .medium))
                                        
                                        Text((index.date ?? Date()).convertDate(format: "MMM d HH:MM"))
                                            .foregroundColor(.gray)
                                            .font(.system(size: 13, weight: .regular))
                                    })
                                    
                                    Spacer()
                                    
                                    Text("$\(index.price)")
                                        .foregroundColor(.black)
                                        .font(.system(size: 15, weight: .regular))
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.1)))
                            }
                        }
                    }
                    .padding([.horizontal, .bottom])
                }
            }
        }
        .onAppear {
            
            viewModel.fetchPayments("")
        }
    }
}

#Preview {
    HistoryView()
}
