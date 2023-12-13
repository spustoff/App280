//
//  CurrenciesDetail.swift
//  App280
//
//  Created by Вячеслав on 12/13/23.
//

import SwiftUI

struct CurrenciesDetail: View {
    
    @Environment(\.presentationMode) var router
    
    let pair: String
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text(pair)
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
                
                VStack(alignment: .leading, spacing: 5, content: {
                    
                    Text("Currency value")
                        .foregroundColor(.gray)
                        .font(.system(size: 13, weight: .regular))
                    
                    HStack(alignment: .bottom, spacing: 5) {
                        
                        Text("$\(Int.random(in: 1...3252))")
                            .foregroundColor(.black)
                            .font(.system(size: 19, weight: .semibold))
                        
                        Text("+\(Int.random(in: 1...245))%")
                            .foregroundColor(.green)
                            .font(.system(size: 13, weight: .regular))
                        
                        Spacer()
                    }
                })
                .padding()
                
                Image("graph")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Spacer()
                
                HStack {
                    
                    Button(action: {
                        
                        router.wrappedValue.dismiss()
                        
                    }, label: {
                        
                        Text("Back")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.red))
                    })
                    
                    Button(action: {
                        
                        router.wrappedValue.dismiss()
                        
                    }, label: {
                        
                        Text("Apply")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.green))
                    })
                }
                .padding()
            }
        }
    }
}

#Preview {
    CurrenciesDetail(pair: "EURUSD")
}
