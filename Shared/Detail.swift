//
//  MasterView.swift
//  Checklist
//
//  Created by Jemil Pepena on 17/4/2022.
//

import SwiftUI


/// Updates json file with chnges to an individual checklist made by user
/// - Parameters:
///   - to_update: array of all checklists
///   - instc_checklist: individual checklists with changes already made
func update_Checklist(to_update: [Checklist], instc_checklist: Checklist){ //updates an individual checklist when it is edited
    var count: Int = 0
    var Checklists:[Checklist] = to_update
    for C in Checklists{
        if C.id == instc_checklist.id{ //identifies checklist using its ID
            Checklists[count] = instc_checklist //updates
            break
        }
        count += 1
        
    }
  
    
    writeToJson(Checklists: Checklists) //updates array to json file
}

/// Returns an individual checklists loaded straight from our json file
/// - Parameter id: string identifier of individual checklist
/// - Returns: returns individual checklists stored in the struct Checklist
func return_instc_checklist( id: String) -> Checklist{ //returns an individual checklist loaded from our json file
    let all_checklists = load(strt: false) //loads checklists from json file
    var ret: Checklist = all_checklists[0] //creates an instance of a checklist , give an initial value
    for c in all_checklists{
        if c.id == id{ //identifies checklist
            ret = c //sets return value
            break
        }
    }
  return ret //returns checklist
}

/// Adds an item to an individual checklist
/// - Parameters:
///   - instc_checklist: instance of the checklist that the item will be added to
///   - item: the string of the checklist item
/// - Returns: checklist with the item added
func add_item( instc_checklist: Checklist, item: String) -> Checklist {
    var updated = instc_checklist //mutable copy of the given checklist
    
    //adds items properties
    updated.items.id.append(updated.items.id.count)
    updated.items.itemNames.append(item)
    updated.items.hasCompleted.append(false)
    //returns checklist
    return updated
}

/// Struct of our content view showing the items of an individual checklist, checklists can be edited in this view
struct ContentView: View { //our detail view
     
    ///loads array of checklists from json file
    @State var all_checklists_ : [Checklist] = load(strt: false)
    ///checklist information recieved from master view
    @State var instc_checklist :  Checklist
    ///checklists information recieved from master view, holds the unedited information that will not be mutated
    @State var original: Checklist
    ///copy of our checklist, holds the checklist with changes made  by user
    @State var copy: Checklist
    ///if edit button is pressed, used to show different information based on if in edit mode
    @State var Edit: Bool = false
    ///status if view is in edit mode
    @State var mode: EditMode = .inactive
    ///if reset button is pressed, used to show undo button if reset is pressed
    @State var reset: Bool = false
    ///holds new item added to checklist
    @State var new_item: String = ""
   
    
    /// Deletes item from checklist
    /// - Parameter offsets: location of item in correspoding properties itemName array & hasCompleted array
    func delete(at offsets: IndexSet) {  //deletes an item when in edit mode
       
        instc_checklist.items.itemNames.remove(atOffsets: offsets)
        instc_checklist.items.hasCompleted.remove(atOffsets: offsets)
        instc_checklist.items.id.remove(atOffsets: offsets)
        var c: Int = 0
        for _ in instc_checklist.items.id{
            instc_checklist.items.id[c] = c
            c += 1
        }
     
       
       }
    
    /// Moves checklist item from one pos to another
    /// - Parameters:
    ///   - source: original location of item in itemName array and hasCompleted array
    ///   - destination: new location of item
    func move(from source: IndexSet, to destination: Int) { //rearranges checklists itmes
        instc_checklist.items.itemNames.move(fromOffsets: source, toOffset: destination)
        instc_checklist.items.hasCompleted.move(fromOffsets: source, toOffset: destination)
     
    }
    
    var body: some View {
       
                VStack{
                    HStack{
                     
                        if mode == .inactive{ //shows title as text if not in edit mode or a editable textfield if in editmode
                            Text(instc_checklist.name).font(.largeTitle)
                                .padding(.leading).onAppear{
                            
                        
                                }
                        }else{
                            TextField("", text: $instc_checklist.name)
                                .font(.largeTitle)
                                .padding(.leading)
                                
                        }
                        Spacer() //pushes to left
                    }.frame(maxWidth: .infinity)
                    
                    List{ //shows checklist items
                        
                        ForEach(self.instc_checklist.items.id, id: \.self) {id in //uses to to identify each checklist item position in itemname array
                                HStack{
        
                                    if mode == .inactive{ //items as button if not in edit mode or editable textfield if in edit mode
                                            Button(self.instc_checklist.items.itemNames[id]){
                                                self.instc_checklist.items.hasCompleted[id].toggle() //check or uncheck
                                       
                                            }
                                    }else{
                                        
                                        TextField("", text: $instc_checklist.items.itemNames[id]) //
                                        
                                    }
                                    
                                        Spacer()
                                        if self.instc_checklist.items.hasCompleted[id]{
                                            Text("✓").foregroundColor(.blue)
                                        }
                                   // }
                                }
                        }.onDelete(perform: delete)
                            .onMove(perform: move)
                            
                        
                       
                        if mode == .active{// adds list item when edit mode is activated
                            HStack{
                                TextField("Add list item", text: $new_item).onSubmit{
                                    instc_checklist = add_item( instc_checklist: instc_checklist, item: new_item) //updates list
                                    new_item = "" //resets new item var when when presses enter
                                }
                            }
                        }
                    }.toolbar{
                        
                        ToolbarItem(placement: .navigationBarTrailing){
                            if mode == .active{ // if in edit mode
                                
                                if !reset{
                                    Button("Reset"){ //reset button to reert to orignal checklist
                                        copy = instc_checklist //make copy of checklist with chnages mahe
                                        instc_checklist = original //set current checklist back to original data
                                        reset = true //data has been reset, undo button will show instead
                                    }.foregroundColor(.red)
                                }else{
                                    Button("Undo"){ //back to changes
                                        instc_checklist = copy //current displayed checklist back to show chnages made
                                        reset = false // reset has been undone
                                    }.foregroundColor(.green)
                                }
                            }
                            }
                        ToolbarItem(placement: .navigationBarTrailing){
                            
                            EditButton() //edit button
                        }
                    }.environment(\.editMode, $mode) //attach var mode to edit mode of the environment

        }
            .onDisappear{ //updates json file when detail view dissapears and not in edit mode i.e. done button pressed to exit edit mode
                if mode == .inactive{
                    update_Checklist(to_update: all_checklists_, instc_checklist: instc_checklist)
                }
            }
           
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
