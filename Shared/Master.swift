//
//  ContentView.swift
//  Shared
//
//  Created by Jemil Pepena on 13/4/2022.
//
import Foundation
import SwiftUI

/**
 Creates a new checklist
 Take the array of checklists as input
 appends a new empty checklists at the end
 returns the new array with the new checklist
 
 note: does not write to json, return value will need to be given to write to json function
 - Parameter all_checklists: array of all checklists
 - Returns: new array of all checklists
 */
func newChecklist(all_checklists: [Checklist]) -> Checklist{
    var id_list: [String] = [] // lists of all checklists ids
    for id in all_checklists{ // populates with ids of all checklists
        id_list.append(id.id)
    }
    
    var new_id = "" //new id for new checklist
    
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"    // used to generate new id
   
    while id_list.contains(new_id) || new_id == ""{ //loop while newly generted id doesnt already exist or is emtpy
        new_id = ""
        for _ in 0 ..< 10{ //creates new id
            new_id.append(letters.randomElement()!)
        }
    }
  
    let items = Items( //cretes new empty item struct
        id: [],
        itemNames: [],
        hasCompleted: []
    )
let new_Checklist =  Checklist( //new emtpy checklist with the generated id from aboe
    id : new_id,
    name: "New Checklist",
    items: items
    
)
    return new_Checklist //returns new checklist to be appended to array of checklists
}

/**Our master view struct
 Holds the navigation view of checklists
 Holds the edit mode to remove checklists
 Can add new checklists, using newChecklist
 
 */
struct MasterView: View { //our master view
    
    ///Main array of checklists that holds all checklists in Masterview
    @State private var Checklists : [Checklist] = []
    ///bool, toggled if link to individual checklists is pressed by user
    @State var toList: Bool = false
    ///instance of a checklist, given an initail value, will be passed to detail view
    @State var instc_checklist = load(strt: false)[0]
    ///toggled from .inactive to .acive in edit button is pressed
    @State var mode: EditMode = .inactive
    
    /**
     delete fucntion - deletes a checklist
     Takes location of checklist "offsets" in the array Checklists, and removes it
     Writes new array to json file
     - Parameter offsets: location of checklists to be deleted in the array of all checklists
     */
    func delete(at offsets: IndexSet){ //delete function
        Checklists.remove(atOffsets: offsets)
        writeToJson(Checklists: Checklists) //updates to json
    }
    /**
     Move function to rearrange checklists
     
     Takes location of checklist "offsets" in the array Checklists, and moves it to new position "destination"
     Then writes changes to json file
     - Parameters:
     - source: location of checklists to to relocated
     - destination: destination where checklist to be moved to
     */
    func move(from source: IndexSet, to destination: Int){ //rearrange function
        Checklists.move(fromOffsets: source, toOffset: destination)
        writeToJson(Checklists: Checklists) //updates to json
    }
    var body: some View {
      
           NavigationView{ //nav view for checklsits
              
               VStack{
    
                List{
                    ForEach(Checklists){ Checklist in //each checklist is listed
                        HStack{
                            
                            Button { //button to individual checklists
                                instc_checklist = return_instc_checklist(id: Checklist.id) //if pressed, get that specific checklists from json file
                                toList.toggle() //toggle nav link to detail page
                            }label:{
                                Text(Checklist.name).foregroundColor(.black)
                            }
                            }.environment(\.editMode, $mode)// toggle variable mode if edit mode is activated
                        
                   
                    
                    }.onMove(perform: move)
                        .onDelete(perform: delete)
             
               
                }.toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button("Add"){ //add button to add checklist
                            Checklists.append(newChecklist(all_checklists: Checklists)) //adds
                            writeToJson(Checklists: Checklists) //writes to json
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading){
                        
                        EditButton() //edit button
                    }
                }
                   
                   NavigationLink( //nav to to detail view of individual checklist
                    destination: ContentView(instc_checklist: instc_checklist, original: instc_checklist, copy: instc_checklist)
                                  ,
                                  isActive: $toList //activates nav link when toList (toggled when button press) is togglges
                   ){ }
           }
                   .onAppear{
                       Checklists = load(strt: true) //loads array holding all checklists when master view appears so data in up-to-date
                           
                   }
                   .navigationTitle("Checklists")
                 
           }
   
            
            
    }
}

var Start = MasterView()

struct MasterView_Previews: PreviewProvider {
    static var previews: some View {
        
       Start
    }
}
