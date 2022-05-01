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
    @State var original: Checklist
    @State var copy: Checklist
    @State var Edit: Bool = false
    @State var mode: EditMode = .inactive
    @State var reset: Bool = false
    @State var new_item: String = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    func delete(at offsets: IndexSet) {
       
        instc_checklist.items.itemNames.remove(atOffsets: offsets)
        instc_checklist.items.hasCompleted.remove(atOffsets: offsets)
        instc_checklist.items.id.remove(atOffsets: offsets)
        var c: Int = 0
        for _ in instc_checklist.items.id{
            instc_checklist.items.id[c] = c
            c += 1
        }
        
        update_Checklist(to_update: all_checklists_, instc_checklist: instc_checklist)
        print(instc_checklist)
       }
    
    func move(from source: IndexSet, to destination: Int) {
        instc_checklist.items.itemNames.move(fromOffsets: source, toOffset: destination)
        instc_checklist.items.hasCompleted.move(fromOffsets: source, toOffset: destination)
        
        update_Checklist(to_update: all_checklists_, instc_checklist: instc_checklist)
    }
    
    var body: some View {
       
                VStack{
                    HStack{
                     
                        if mode == .inactive{
                            Text(instc_checklist.name).font(.largeTitle)
                                .padding(.leading).onAppear{
                            
                            update_Checklist(to_update: all_checklists_, instc_checklist: instc_checklist)
                                }
                        }else{
                            TextField("", text: $instc_checklist.name)
                                .font(.largeTitle)
                             
                                .padding(.leading)
                                
                        }
                        Spacer()
                    }.frame(maxWidth: .infinity)
                    List{
                        
                        ForEach(self.instc_checklist.items.id, id: \.self) {id in
                                HStack{
                                   // if id <= instc_checklist.items.id.count - 1{
                                    if mode == .inactive{
                                            Button(self.instc_checklist.items.itemNames[id]){
                                                self.instc_checklist.items.hasCompleted[id].toggle()
                                             
                                                    update_Checklist(to_update: all_checklists_, instc_checklist: self.instc_checklist)
                                       
                                            }
                                    }else{
                                        
                                        TextField("", text: $instc_checklist.items.itemNames[id])
                                        
                                    }
                                    
                                        Spacer()
                                        if self.instc_checklist.items.hasCompleted[id]{
                                            Text("✓").foregroundColor(.blue)
                                        }
                                   // }
                                }
                        }.onDelete(perform: delete)
                            .onMove(perform: move)
                            
                        
                       
                        if mode == .active{
                            HStack{
                                TextField("Add list item", text: $new_item).onSubmit{
                                    instc_checklist = add_item( instc_checklist: instc_checklist, item: new_item)
                                    new_item = ""
                                }
                            }
                        }
                    }.toolbar{
                        
                        ToolbarItem(placement: .navigationBarTrailing){
                            if mode == .active{
                                
                                if !reset{
                                    Button("Reset"){
                                        copy = instc_checklist
                                        instc_checklist = original
                                        reset = true
                                    }.foregroundColor(.red)
                                }else{
                                    Button("Undo"){
                                        instc_checklist = copy
                                        reset = false
                                    }.foregroundColor(.green)
                                }
                            }
                            }
                        ToolbarItem(placement: .navigationBarTrailing){
                            
                            EditButton()
                        }
                    }.environment(\.editMode, $mode)

        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .navigationBarTitle("", displayMode: .inline)
           
            
       
        
        NavigationLink(destination: Edit_checklist(instc_checklist: instc_checklist, all_checklists: all_checklists_, original: instc_checklist, checklist_copy: instc_checklist) , isActive: $Edit){}
    }
}
/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let temp = load(strt: true)
        
        
            ContentView(all_checklists_: temp,instc_checklist: temp[0] )
        
        
    }
}

*/
