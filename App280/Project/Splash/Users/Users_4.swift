//
//  Users_4.swift
//  App280
//
//  Created by Вячеслав on 12/13/23.
//

import SwiftUI
import OneSignalFramework

struct Users_4: View {
    
    @AppStorage("status") var status: Bool = false
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            Image("users_4")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: .infinity, alignment: .bottom)
            
            VStack {
                
                VStack(alignment: .center, spacing: 6, content: {
                    
                    Text("Don’t miss anything")
                        .foregroundColor(.black)
                        .font(.system(size: 23, weight: .semibold))
                        .multilineTextAlignment(.center)
                    
                    Text("Don’t miss the most userful information")
                        .foregroundColor(.black)
                        .font(.system(size: 15, weight: .regular))
                        .multilineTextAlignment(.center)
                })
                .padding()
                .padding([.horizontal, .top])
                
                Spacer()
                
                Button(action: {
                    
                    OneSignal.Notifications.requestPermission({ accepted in
                      print("User accepted notifications: \(accepted)")
                    }, fallbackToSettings: true)
                    
                }, label: {
                    
                    Text("Enable Notifications")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                        .padding()
                })
            }
            
            VStack {
                
                HStack {
                    
                    Spacer()
                    
                    Button(action: {
                        
                        status = true
                        
                    }, label: {
                        
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .bold))
                            .frame(width: 30, height: 30)
                            .background(Circle().fill(Color("primary")))
                    })
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    Users_4()
}
