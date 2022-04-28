//
//  Edit_checklist.swift
//  Checklist
//
//  Created by Jemil Pepena on 20/4/2022.
//

import SwiftUI

func add_item( instc_checklist: Checklist, item: String) -> Checklist {
    var updated = instc_checklist
    
    updated.items.id.append(updated.items.id.count)
    updated.items.itemNames.append(item)
    updated.items.hasCompleted.append(false)
   
    return (updated)
}

struct Edit_checklist: View {
    @State var instc_checklist: Checklist
    @State var all_checklists: [Checklist]
    @State var original: Checklist
    @State var back: Bool = false
    @State var count: Int = 0
    @State var new_item: String = ""
    @State var reset_btn: Bool = false
    var body: some View {
      
    
        VStack{
         
            
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
                if id == instc_checklist.items.itemNames.count - 1{
                    HStack{
                        TextField("Add list item", text: $new_item).onSubmit{
                            instc_checklist = add_item( instc_checklist: instc_checklist, item: new_item)
                            new_item = ""
                        }
                    }
                  
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        /*    .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true) */
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                   
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
                        back.toggle()
                     }
                     .frame(maxWidth: .infinity, alignment: .trailing)
                     .padding(.trailing, 30)
                     
                };
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Reset"){
                        instc_checklist = original
                    }
                }
                
            }
       

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