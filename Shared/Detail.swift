//
//  MasterView.swift
//  Checklist
//
//  Created by Jemil Pepena on 17/4/2022.
//

import SwiftUI


struct ContentView: View {
    
    //var checklist:CheckList
    @State var instc_checklist :  Checklist
 
    var body: some View {
       
        VStack{
            
         
            Text(self.instc_checklist.name)
                
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .shadow(radius: 50)
                .padding(.leading, 30)
                .padding(.bottom ,20)
            
                HStack {
                    
                    VStack(alignment: .leading){
                
                        ForEach(self.instc_checklist.items, id: \.self){ item in
                            HStack{
                            Text(item)
                                Spacer()
                                Button("Done"){}
                                    .padding(.trailing, 30)
                                                       
                            }.padding(.leading, 30)
                                .padding(.bottom, 10)
                        }
                /*
                    Text("Clean room")
                            .padding(.leading, 30) .padding(.bottom,10)
                        
                        
                    Text("Buy groceries")
                        .padding(.leading, 30) .padding(.bottom,10)
                        
                    Text("Clean car")
                        .padding(.leading, 30) .padding(.bottom,10)
                        
                    Text("Call Mum")
                        .padding(.leading, 30) .padding(.bottom,10)
                       */
                }
                  
                    /*
                    VStack{
                      //  Button("Done"){} .padding(.bottom, 10)
                        Button("Done"){}.padding(.bottom, 10).padding(.trailing, 30)
                       // Button("Done"){}.padding(.bottom, 10)
                        Button("Done"){}.padding(.bottom, 10).padding(.trailing, 30)
                    } */
                }
                .frame(minWidth: 0,  maxWidth: .infinity)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let temp = Checklist(
            id: 0, name: "Example", items: ["item1", "item2", "item3", "item4"]
        )
        
        
            ContentView(instc_checklist: temp)
        
        
    }
}
