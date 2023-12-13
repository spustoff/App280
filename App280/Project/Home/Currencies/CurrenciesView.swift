//
//  CurrenciesView.swift
//  App280
//
//  Created by Вячеслав on 12/13/23.
//

import SwiftUI

struct CurrenciesView: View {
    
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("Currency Pair")
                        .foregroundColor(.black)
                        .font(.system(size: 17, weight: .semibold))
                
                    HStack {
                        
                        Button(action: {
                            
                            router.wrappedValue.dismiss()
                            
                        }, label: {
                            
                            HStack {
                                
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.black)
                                    .font(.system(size: 16, weight: .regular))
                                
                                Text("Back")
                                    .foregroundColor(.black)
                                    .font(.system(size: 15, weight: .regular))
                            }
                        })
                        
                        Spacer()
                    }
                }
                .padding()
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    LazyVStack {
                        
                        ForEach(["EURUSD", "USDJPY", "GBPUSD", "AUDUSD", "EURJPY", "EURRUB"], id: \.self) { index in
                        
                            NavigationLink(destination: {
                                
                                CurrenciesDetail(pair: index)
                                    .navigationBarBackButtonHidden()
                                
                            }, label: {
                                
                                HStack {
                                    
                                    Text(index)
                                        .foregroundColor(.black)
                                        .font(.system(size: 16, weight: .medium))
                                        
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 12, weight: .regular))
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.1)))
                            })
                        }
                    }
                    .padding([.horizontal, .bottom])
                }
            }
        }
    }
}

#Preview {
    CurrenciesView()
}
