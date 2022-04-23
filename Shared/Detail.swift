//
//  MasterView.swift
//  Checklist
//
//  Created by Jemil Pepena on 17/4/2022.
//

import SwiftUI

struct isShowing{
    
    var showing: Bool = false
    
}
struct ContentView: View {
    
    //var checklist:CheckList
    @State var instc_checklist :  Checklist
    @State var all_checklists_ : [Checklist]
    var body: some View {
       
        VStack{
            NavigationView{
                VStack{
                    NavigationLink{
                        Edit_checklist(instc_checklist: instc_checklist, all_checklists: all_checklists_, original: instc_checklist)
                    }
                label:{
                    Text("Edit")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 30)
                .foregroundColor(.blue)
                }
            Text(self.instc_checklist.name)
                
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.top, 10)
                .padding(.leading, 30)
                    
 
        
           
                List(self.instc_checklist.items.id, id: \.self) {id in
                HStack{
                    
                    Button(self.instc_checklist.items.itemNames[id]){
                        self.instc_checklist.items.hasCompleted[id].toggle()
                    }
                    Spacer()
                    if self.instc_checklist.items.hasCompleted[id]{
                        Text("✓").foregroundColor(.blue)
                    }
                }
                
            }
               
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let temp = Checklist(
            id: "jbsijb", name: "Example", items: Items (id: [0,1,2,3],itemNames: ["item1", "item2", "item3", "item4"], hasCompleted: [false,false,false,false])
        )
        
        
            ContentView(instc_checklist: temp, all_checklists_: [temp])
        
        
    }
}
