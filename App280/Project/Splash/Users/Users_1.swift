//
//  Users_1.swift
//  App280
//
//  Created by Вячеслав on 12/13/23.
//

import SwiftUI

struct Users_1: View {
    
    let telegram: URL
    let isTelegram: Bool
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            Image("users_1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: .infinity, alignment: .bottom)
            
            VStack {
                
                VStack(alignment: .center, spacing: 6, content: {
                    
                    Text("Your financial instrument that allows  to earn")
                        .foregroundColor(.black)
                        .font(.system(size: 23, weight: .semibold))
                        .multilineTextAlignment(.center)
                    
                    Text("Rise higher and higher")
                        .foregroundColor(.black)
                        .font(.system(size: 15, weight: .regular))
                        .multilineTextAlignment(.center)
                })
                .padding()
                .padding([.horizontal, .top])
                
                Spacer()
                
                NavigationLink(destination: {
                    
                    Users_2(telegram: telegram, isTelegram: isTelegram)
                        .navigationBarBackButtonHidden()
                    
                }, label: {
                    
                    Text("Next")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                        .padding()
                })
            }
        }
    }
}

#Preview {
    Users_1(telegram: URL(string: "h")!, isTelegram: false)
}
