//
//  HomeView.swift
//  App280
//
//  Created by Вячеслав on 12/13/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Home")
                    .foregroundColor(.black)
                    .font(.system(size: 25, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Rectangle()
                    .fill(.gray.opacity(0.2))
                    .frame(height: 1)
                
                HStack {
                    
                    VStack(alignment: .leading, spacing: 5, content: {
                        
                        Text("Your balance")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                        
                        Text("$\(viewModel.money)")
                            .foregroundColor(.black)
                            .font(.system(size: 21, weight: .semibold))
                    })
                    
                    Spacer()
                    
                    NavigationLink(destination: {
                        
                        CurrenciesView()
                            .navigationBarBackButtonHidden()
                        
                    }, label: {
                        
                        HStack {
                            
                            Image(systemName: "pencil")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .regular))
                            
                            Text("EUR/USD")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .regular))
                        }
                    })
                }
                .padding()
                
                Button(action: {
                    
                    withAnimation(.spring()) {
                        
                        viewModel.isTopUp = true
                    }
                    
                }, label: {
                    
                    Text("Top up balance")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                        .padding([.horizontal, .bottom])
                })
                
                HStack {
                    
                    Text("Realty")
                        .foregroundColor(.black)
                        .font(.system(size: 19, weight: .semibold))
                    
                    Spacer()
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddRealty = true
                        }
                        
                    }, label: {
                        
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                            .font(.system(size: 19, weight: .semibold))
                    })
                }
                .padding(.horizontal)
                
                if viewModel.realty.isEmpty {
                    
                    Text("Add Real Estate")
                        .foregroundColor(.black)
                        .font(.system(size: 26, weight: .semibold))
                        .padding()
                        .frame(maxHeight: .infinity, alignment: .center)
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack {
                            
                            ForEach(viewModel.realty, id: \.self) { index in
                            
                                NavigationLink(destination: {
                                    
                                    HomeDetail(viewModel: viewModel, address: index)
                                        .navigationBarBackButtonHidden()
                                    
                                }, label: {
                                    
                                    HStack {
                                        
                                        Image("realty")
                                            .resizable()
                                            .frame(width: 90, height: 90)
                                        
                                        VStack(alignment: .leading, spacing: 40, content: {
                                            
                                            Text("Address: \(index)")
                                                .foregroundColor(.black)
                                                .font(.system(size: 14, weight: .medium))
                                            
                                            Text("More")
                                                .foregroundColor(.black)
                                                .font(.system(size: 12, weight: .regular))
                                                .frame(maxWidth: .infinity, alignment: .trailing)
                                        })
                                    }
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                                })
                            }
                        }
                        .padding([.horizontal, .bottom])
                    }
                }
            }
        }
        .overlay (
        
            ZStack {
                
                Color.black.opacity(viewModel.isTopUp ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isTopUp = false
                        }
                    }
                
                VStack {
                    
                    Text("Replenichment of balance")
                        .foregroundColor(.black)
                        .font(.system(size: 17, weight: .semibold))
                    
                    ZStack(alignment: .leading, content: {
                        
                        Text("Enter Amount")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.topUpField.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.topUpField)
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .regular))
                            .keyboardType(.decimalPad)
                    })
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                    .padding(.bottom, 30)
                    
                    Button(action: {
                        
                        viewModel.money += Int(viewModel.topUpField) ?? 0
                        
                        UIApplication.shared.endEditing()
                        
                        viewModel.topUpField = ""
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isTopUp = false
                        }
                        
                    }, label: {
                        
                        Text("Top up")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                            .opacity(viewModel.topUpField.isEmpty ? 0.5 : 1)
                            .disabled(viewModel.topUpField.isEmpty ? true : false)
                    })
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isTopUp = false
                        }
                        
                    }, label: {
                        
                        Text("Close")
                            .foregroundColor(.gray)
                            .font(.system(size: 15, weight: .medium))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                    })
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg")))
                .padding()
                .offset(y: viewModel.isTopUp ? 0 : UIScreen.main.bounds.height)
            }
        )
        .overlay (
        
            ZStack {
                
                Color.black.opacity(viewModel.isAddRealty ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddRealty = false
                        }
                    }
                
                VStack {
                    
                    Text("New Realty")
                        .foregroundColor(.black)
                        .font(.system(size: 17, weight: .semibold))
                        .padding(.bottom)
                    
                    VStack(alignment: .leading, spacing: 8, content: {
                        
                        Text("Address")
                            .foregroundColor(.gray)
                            .font(.system(size: 13, weight: .regular))
                        
                        ZStack(alignment: .leading, content: {
                            
                            Text("Enter Address")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.address.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.address)
                                .foregroundColor(.black)
                                .font(.system(size: 14, weight: .regular))
                        })
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                    })
                    .padding(.bottom, 30)
                    
                    Button(action: {
                        
                        if !viewModel.realty.contains(viewModel.address) {
                            
                            viewModel.realty.append(viewModel.address)
                        }
                        
                        UIApplication.shared.endEditing()
                        
                        viewModel.address = ""
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddRealty = false
                        }
                        
                    }, label: {
                        
                        Text("Add")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                            .opacity(viewModel.address.isEmpty ? 0.5 : 1)
                            .disabled(viewModel.address.isEmpty ? true : false)
                    })
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg")))
                .padding()
                .offset(y: viewModel.isAddRealty ? 0 : UIScreen.main.bounds.height)
            }
        )
    }
}

#Preview {
    HomeView()
}
