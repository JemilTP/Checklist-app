//
//  Edit_checklist.swift
//  Checklist
//
//  Created by Jemil Pepena on 20/4/2022.
//

import SwiftUI

struct Edit_checklist: View {
    @State var instc_checklist: Checklist
    @State var all_checklists: [Checklist]
    @State var original: Checklist
   
    @State var count: Int = 0
    
    var body: some View {
      
    
        VStack{
            Button("Done"){
                for CList in all_checklists{
                   // print(CList)
                   // print(count)
                    if CList.id == instc_checklist.id{
                        all_checklists[count] = instc_checklist
                        print(all_checklists)
                        break
                    }
                    count += 1
                }
                writeToJson(Checklists: all_checklists)
            }
            TextField("Checklist name", text:  $instc_checklist.name)
                .padding(.leading, 30)
                .padding(.bottom, 10)
                .font(.largeTitle)
            
            List(self.instc_checklist.items.id, id: \.self) {id in
            HStack{
                
                TextField("", text: $instc_checklist.items.itemNames[id])
                Spacer()
                if instc_checklist.items.hasCompleted[id]{
                    Text("✓").foregroundColor(.blue)
                }
            }
           
        }
        
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
          
    }
}
/*
struct Edit_checklist_Previews: PreviewProvider {
    static var previews: some View {
        
        let temp = Checklist(
            id: "jbsijb", name: "Example", items: Items (id: [0,1,2,3],itemNames: ["item1", "item2", "item3", "item4"], hasCompleted: [false,false,false,false])
        )
        //let p: Checklist
      //  let temp2: List = [temp, temp]
        
        
        Edit_checklist()
    }
}
*/
