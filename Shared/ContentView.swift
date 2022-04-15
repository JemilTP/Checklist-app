//
//  ContentView.swift
//  Shared
//
//  Created by Jemil Pepena on 13/4/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            Text("To-Do list")
                // .padding(.init(top: 30, leading: 30, bottom: 40, trailing: 30))
                
                .font(.largeTitle)
                .frame(maxWidth: .infinity,maxHeight: 100, alignment: .topLeading)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .padding(.leading, 30)
                .padding(.top,20)
            
                HStack {
                    
                    VStack(alignment: .leading){
                
                
                    Text("Clean room")
                            .padding(.leading, 30) .padding(.bottom,10)
                        
                        
                    Text("Buy groceries")
                        .padding(.leading, 30) .padding(.bottom,10)
                        
                    Text("Clean car")
                        .padding(.leading, 30) .padding(.bottom,10)
                        
                    Text("Call Mum")
                        .padding(.leading, 30) .padding(.bottom,10)
                       
                }
                  Spacer(minLength: 50)
                    
                    VStack{
                      //  Button("Done"){} .padding(.bottom, 10)
                        Button("Done"){}.padding(.bottom, 10).padding(.trailing, 30)
                       // Button("Done"){}.padding(.bottom, 10)
                        Button("Done"){}.padding(.bottom, 10).padding(.trailing, 30)
                    }
                }
                .frame(minWidth: 0,  maxWidth: .infinity)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
        }
    }
}
