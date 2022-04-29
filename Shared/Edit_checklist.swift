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
   
    return updated
}

func delete_item(instc_checklist: Checklist, id: Int) -> Checklist{
    var ret = instc_checklist
    ret.items.id.remove(at:  id)
    ret.items.itemNames.remove(at: id)
    ret.items.hasCompleted.remove(at: id)
    
    var count: Int = 0
    for _ in ret.items.id{
        ret.items.id[count] = count
        count += 1
        
    }
    print(ret)
    return ret
}

struct Edit_checklist: View {
    @State var instc_checklist: Checklist
    @State var all_checklists: [Checklist]
    @State var original: Checklist
    @State var checklist_copy: Checklist 
    @State var back: Bool = false
    @State var count: Int = 0
    @State var new_item: String = ""
    @State var reset_btn: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
      
    
        VStack{
         
            
            TextField("Checklist name", text:  $instc_checklist.name)
                .padding(.leading, 30)
                .padding(.bottom, 10)
                .font(.largeTitle)
            if instc_checklist.items.itemNames.isEmpty{
                List{
                TextField("Add list item", text: $new_item).onSubmit{
                    instc_checklist = add_item( instc_checklist: instc_checklist, item: new_item)
                    new_item = ""
                }
            }
            }
            else{
            List(self.instc_checklist.items.id, id: \.self) {id in
            HStack{
                Button{
                    
                        instc_checklist = delete_item(instc_checklist: instc_checklist, id: id)
                } label: {
                Image(systemName: "trash").foregroundColor(.red)
                }
                    
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
        }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
          .navigationBarBackButtonHidden(true)
            
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                   
                    Button("Done"){
                      
                        update_Checklist(to_update: all_checklists, instc_checklist: instc_checklist)
                        back.toggle()
                        presentationMode.wrappedValue.dismiss()
                     }
                     .frame(maxWidth: .infinity, alignment: .trailing)
                     .padding(.trailing, 30)
                     
                };
                ToolbarItem(placement: .navigationBarTrailing){
                    if !reset_btn{
                    Button("Reset"){
                        checklist_copy = instc_checklist
                        instc_checklist = original
                        reset_btn = true
                    }.foregroundColor(.red)
                    }else{
                        Button("Undo"){
                            instc_checklist = checklist_copy
                            reset_btn = false
                        }.foregroundColor(.green)
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
