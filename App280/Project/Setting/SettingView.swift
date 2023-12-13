//
//  SettingView.swift
//  App280
//
//  Created by Вячеслав on 12/13/23.
//

import SwiftUI
import StoreKit

struct SettingView: View {
    
    @AppStorage("realty") var realty: [String] = []
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Setting")
                    .foregroundColor(.black)
                    .font(.system(size: 25, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                    
                    Button(action: {
                        
                        guard let url = URL(string: "https://docs.google.com/document/d/1xCg3Z9ge1iBKoYt4B56IkCh-SveETwUzUrBAbWiFKZM/edit?usp=sharing") else { return }
                        
                        UIApplication.shared.open(url)
                        
                    }, label: {
                        
                        VStack(spacing: 10) {
                            
                            Image(systemName: "doc.fill")
                                .foregroundColor(.black)
                                .font(.system(size: 18, weight: .regular))
                            
                            Text("Usage Policy")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .regular))
                        }
                        .frame(height: 150)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                    })
                    
                    Button(action: {
                        
                        SKStoreReviewController.requestReview()
                        
                    }, label: {
                        
                        VStack(spacing: 10) {
                            
                            Image(systemName: "star.fill")
                                .foregroundColor(.black)
                                .font(.system(size: 18, weight: .regular))
                            
                            Text("Rate Us")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .regular))
                        }
                        .frame(height: 150)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                    })
                    
                    Button(action: {
                        
                        CoreDataStack.shared.deleteAllData()
                        
                        realty.removeAll()
                        
                    }, label: {
                        
                        VStack(spacing: 10) {
                            
                            Image(systemName: "trash.fill")
                                .foregroundColor(.black)
                                .font(.system(size: 18, weight: .regular))
                            
                            Text("Reset Progress")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .regular))
                        }
                        .frame(height: 150)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                    })
                })
                .padding()
                
                Spacer()
            }
        }
    }
}

#Preview {
    SettingView()
}
