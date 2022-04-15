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
                .frame(width: 200,height: 100, alignment: .leading)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
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
            VStack{
              //  Button("Done"){} .padding(.bottom, 10)
                Button("Done"){}.padding(.bottom, 10)
               // Button("Done"){}.padding(.bottom, 10)
                Button("Done"){}.padding(.bottom, 10)
            }.padding(.leading, 165)
        }
        .frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
    }
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
