//
//  HomeDetail.swift
//  App280
//
//  Created by Вячеслав on 12/13/23.
//

import SwiftUI

struct HomeDetail: View {
    
    @StateObject var viewModel: HomeViewModel
    
    let address: String
    
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text(address)
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
                        
                        HStack {
                            
                            Image("realty")
                                .resizable()
                                .frame(width: 90, height: 90)
                            
                            VStack(alignment: .leading, spacing: 7, content: {
                                
                                Text("Address: \(address)")
                                    .foregroundColor(.black)
                                    .font(.system(size: 14, weight: .medium))
                                
                                Text("Area: \(0) sq/m2")
                                    .foregroundColor(.black)
                                    .font(.system(size: 14, weight: .medium))
                                
                                Spacer()
                            })
                            
                            Spacer()
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                        
                        HStack {
                            
                            Text("Payment History")
                                .foregroundColor(.black)
                                .font(.system(size: 19, weight: .semibold))
                            
                            Spacer()
                            
                            Button(action: {
                                
                                withAnimation(.spring()) {
                                    
                                    viewModel.isPaymentHistory = true
                                }
                                
                            }, label: {
                                
                                Image(systemName: "plus")
                                    .foregroundColor(.black)
                                    .font(.system(size: 19, weight: .semibold))
                            })
                        }
                        
                        if viewModel.payments.isEmpty {
                            
                            Text("No payments Detected")
                                .foregroundColor(.black)
                                .font(.system(size: 26, weight: .semibold))
                                .padding()
                                .frame(maxHeight: .infinity, alignment: .center)
                            
                        } else {
                            
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
        .overlay (
        
            ZStack {
                
                Color.black.opacity(viewModel.isPaymentHistory ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isPaymentHistory = false
                        }
                    }
                
                VStack {
                    
                    Text("New Payment")
                        .foregroundColor(.black)
                        .font(.system(size: 17, weight: .semibold))
                        .padding(.bottom)
                    
                    VStack(alignment: .leading, spacing: 8, content: {
                        
                        Text("Price")
                            .foregroundColor(.gray)
                            .font(.system(size: 13, weight: .regular))
                        
                        ZStack(alignment: .leading, content: {
                            
                            Text("Enter Price")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.price.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.price)
                                .foregroundColor(.black)
                                .font(.system(size: 14, weight: .regular))
                                .keyboardType(.decimalPad)
                        })
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                    })
                    .padding(.bottom, 5)
                    
                    VStack(alignment: .leading, spacing: 8, content: {
                        
                        Text("Category")
                            .foregroundColor(.gray)
                            .font(.system(size: 13, weight: .regular))
                        
                        ZStack(alignment: .leading, content: {
                            
                            Text("Enter Category")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.category.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.category)
                                .foregroundColor(.black)
                                .font(.system(size: 14, weight: .regular))
                        })
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                    })
                    .padding(.bottom, 20)
                    
                    Button(action: {
                        
                        viewModel.addPayment(address)
                        viewModel.fetchPayments(address)
                        
                        UIApplication.shared.endEditing()
                        
                        viewModel.category = ""
                        viewModel.price = ""
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isPaymentHistory = false
                        }
                        
                    }, label: {
                        
                        Text("Save")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                    })
                    .opacity(viewModel.price.isEmpty || viewModel.category.isEmpty ? 0.5 : 1)
                    .disabled(viewModel.price.isEmpty || viewModel.category.isEmpty ? true : false)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg")))
                .padding()
                .offset(y: viewModel.isPaymentHistory ? 0 : UIScreen.main.bounds.height)
            }
        )
        .onAppear {
            
            viewModel.fetchPayments("address")
        }
    }
}

#Preview {
    HomeDetail(viewModel: HomeViewModel(), address: "address")
}
