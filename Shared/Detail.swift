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

func update_Checklist(to_update: [Checklist], instc_checklist: Checklist){
    var count: Int = 0
    var Checklists:[Checklist] = to_update
    for C in Checklists{
        if C.id == instc_checklist.id{
            Checklists[count] = instc_checklist
            break
        }
        count += 1
        
    }
    print("Updated")
    
    writeToJson(Checklists: Checklists)
}

func return_instc_checklist( id: String) -> Checklist{
    print("initialising list")
    let all_checklists = load(strt: false)
    var ret: Checklist = all_checklists[0]
    for c in all_checklists{
        if c.id == id{
            ret = c
            break
        }
    }
  return ret
}

struct ContentView: View {
     
    
    @State var all_checklists_ : [Checklist] = load(strt: false)
    @State var instc_checklist :  Checklist
    @State var Edit: Bool = false
   
    var body: some View {
       
        ZStack{
            if Edit {
                Edit_checklist(instc_checklist: instc_checklist, all_checklists: all_checklists_, original: instc_checklist)
            }
        if !Edit{
                
               
                VStack{
               
       
                List(self.instc_checklist.items.id, id: \.self) {id in
                HStack{
                    
                    Button(self.instc_checklist.items.itemNames[id]){
                        self.instc_checklist.items.hasCompleted[id].toggle()
                        print("toggled:  ")
                        load(strt: false)
                       
                            update_Checklist(to_update: all_checklists_, instc_checklist: self.instc_checklist)
                        
                        load(strt: false)
                        print("-----------")
                    }
                    Spacer()
                    if self.instc_checklist.items.hasCompleted[id]{
                        Text("✓").foregroundColor(.blue)
                    }
                }
                
            } //.navigationBarHidden(true)
               
              /*     NavigationLink(destination:
                         Edit_checklist(instc_checklist: instc_checklist, all_checklists: all_checklists_, original: instc_checklist)//.navigationBarBackButtonHidden(true)
                                   ,isActive: $Edit
                   ){}
                    */

        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            
            .navigationBarTitle(self.instc_checklist.name)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Edit"){
                        self.Edit.toggle()
                    }
                }
            }
            .navigationBarHidden(Edit)
        }
        }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let temp = load(strt: true)
        
        
            ContentView(all_checklists_: temp,instc_checklist: temp[0] )
        
        
    }
}

