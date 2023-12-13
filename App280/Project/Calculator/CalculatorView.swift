//
//  CalculatorView.swift
//  App280
//
//  Created by Вячеслав on 12/13/23.
//

import SwiftUI

struct CalculatorView: View {
    
    @StateObject var viewModel = CalculatorViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
             
                Text("Calculator")
                    .foregroundColor(.black)
                    .font(.system(size: 25, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                VStack(alignment: .leading, spacing: 8, content: {
                    
                    Text("Service")
                        .foregroundColor(.gray)
                        .font(.system(size: 13, weight: .regular))
                    
                    ZStack(alignment: .leading, content: {
                        
                        Text("Enter Service")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.service.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.service)
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .regular))
                    })
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                })
                .padding(.bottom, 30)
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 8, content: {
                    
                    Text("Cost")
                        .foregroundColor(.gray)
                        .font(.system(size: 13, weight: .regular))
                    
                    ZStack(alignment: .leading, content: {
                        
                        Text("Enter Cost")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.cost.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.cost)
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .regular))
                            .keyboardType(.decimalPad)
                    })
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                })
                .padding(.bottom, 30)
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 8, content: {
                    
                    Text("Quantity")
                        .foregroundColor(.gray)
                        .font(.system(size: 13, weight: .regular))
                        .padding(.horizontal)
                    
                    Stepper("\(viewModel.quantity)", value: $viewModel.quantity)
                        .padding(.horizontal)
                })
                .padding(.bottom, 30)
                
                Button(action: {
                    
                    UIApplication.shared.endEditing()
                    
                    withAnimation(.spring()) {
                        
                        viewModel.isResult = true
                    }
                    
                }, label: {
                    
                    Text("Calculate")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                        .padding()
                })
                .opacity(viewModel.service.isEmpty || viewModel.cost.isEmpty || viewModel.quantity == 0 ? 0.5 : 1)
                .disabled(viewModel.service.isEmpty || viewModel.cost.isEmpty || viewModel.quantity == 0 ? true : false)
                
                Spacer()
            }
        }
        .overlay (
        
            ZStack {
                
                Color.black.opacity(viewModel.isResult ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isResult = false
                        }
                    }
                
                VStack {
                    
                    Text("Result")
                        .foregroundColor(.black)
                        .font(.system(size: 17, weight: .semibold))
                    
                    Rectangle()
                        .fill(.gray.opacity(0.2))
                        .frame(height: 1)
                        .padding(.bottom)
                    
                    HStack {
                        
                        Text("Power Consumption:")
                            .foregroundColor(.black)
                            .font(.system(size: 15, weight: .medium))
                        
                        Text("\(Int.random(in: 1...235)) kWh")
                            .foregroundColor(.black)
                            .font(.system(size: 15, weight: .regular))
                        
                        Spacer()
                    }
                    .padding(.bottom, 10)
                    
                    HStack {
                        
                        Text("The cost of electricity")
                            .foregroundColor(.black)
                            .font(.system(size: 15, weight: .medium))
                        
                        Text("$\(Int.random(in: 1...235))")
                            .foregroundColor(.black)
                            .font(.system(size: 15, weight: .regular))
                        
                        Spacer()
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg")))
                .padding()
                .offset(y: viewModel.isResult ? 0 : UIScreen.main.bounds.height)
            }
        )
    }
}

#Preview {
    CalculatorView()
}
