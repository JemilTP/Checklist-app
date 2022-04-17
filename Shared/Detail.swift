//
//  MasterView.swift
//  Checklist
//
//  Created by Jemil Pepena on 17/4/2022.
//

import SwiftUI


struct ContentView: View {
    
    //var checklist:CheckList
    @State private var Checklists : [Checklist] = []
    
    func initiate(){
        self.Checklists = load()
        print(self.Checklists)
    }
    
    var body: some View {
       
        VStack{
            
            HStack{
                Button("Edit"){}
                    .padding(.leading, 30)
                    
                Spacer()
                Button("Done"){}
                    .padding(.trailing, 30)
            }
            .frame(alignment: .topLeading)
            
            Text("To-Do list")
                
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity,maxHeight: 100, alignment: .topLeading)
                .shadow(radius: 50)
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
        
            ContentView()
            
        
    }
}
