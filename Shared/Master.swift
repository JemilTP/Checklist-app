//
//  ContentView.swift
//  Shared
//
//  Created by Jemil Pepena on 13/4/2022.
//
import Foundation
import SwiftUI


struct Checklist:   Codable, Identifiable{
    var id : String
    var name: String
    var  items: Items


}

struct Items: Codable, Equatable{
    var id: [Int]
    var itemNames: [String]
    var hasCompleted: [Bool]
   
   
   
}

struct JSONData: Codable{
    let checklists : [Checklist]
}
func load(strt: Bool) -> [Checklist]{
    var checklistArray: [Checklist] = []
   // if strt == true{
        let path = Bundle.main.url(forResource: "checklist_data", withExtension: "json")!
        
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let jsonURL = documentDirectory
        .appendingPathComponent("checklist_data")
        .appendingPathExtension("json")
    print(jsonURL.path)
    if !FileManager.default.fileExists(atPath: jsonURL.path){
        try? FileManager.default.copyItem(at: path, to: jsonURL)
        
    }


    if let jsondata = try? JSONDecoder().decode(JSONData.self, from: Data(contentsOf: jsonURL)){
        checklistArray = jsondata.checklists
    }
    return checklistArray
    
       
    
}

func writeToJson(Checklists: [Checklist]){

    do {
      let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
      let documentFolderURL = urls.first!
      let fileURL = documentFolderURL.appendingPathComponent("checklist_data.json")
      let json = JSONEncoder()
      let data = try json.encode(Checklists)
        let data_ = "{ \"checklists\": " + String(data: data,encoding: .utf8)! + "}"
            print(data_)
        
        try data_.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        
    } catch {
      print("Got \(error)")
    }
}

func newChecklist(all_checklists: [Checklist]) -> Checklist{
    var id_list: [String] = []
    for id in all_checklists{
        id_list.append(id.id)
    }
    
    var new_id = ""
    
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"    
   
    while id_list.contains(new_id) || new_id == ""{
        new_id = ""
        for _ in 0 ..< 10{
            new_id.append(letters.randomElement()!)
        }
    }
    print(new_id)
    let items = Items(
        id: [],
        itemNames: [],
        hasCompleted: []
    )
let new_Checklist =  Checklist(
    id : new_id,
    name: "New Checklist",
    items: items
    
)
    return new_Checklist
}

func delete_checklist(all_checklists: [Checklist], id: String) -> [Checklist]{
    
    var ret  = all_checklists
    var count: Int = 0
    for _ in ret{
        if ret[count].id == id{
            ret.remove(at: count)
            break
        }
        count += 1
    }
    return ret
}

struct MasterView: View {
  
    @State private var Checklists : [Checklist] = []
  //  @State private var Copy_Checklists : [Checklist] = []
 // @State var isShowlingChecklist: Bool = false
    @State var toList: Bool = false
    @State var instc_checklist = load(strt: false)[0]
   // @State var Edit_Main: Bool = false
  //  @State var Add_Checklist: Bool = false
    
    @State var mode: EditMode = .inactive
    
    func delete(at offsets: IndexSet){
        Checklists.remove(atOffsets: offsets)
        writeToJson(Checklists: Checklists)
    }
    
    func move(from source: IndexSet, to destination: Int){
        Checklists.move(fromOffsets: source, toOffset: destination)
        writeToJson(Checklists: Checklists)
    }
    var body: some View {
        VStack{
           
           NavigationView{
              
               VStack{
    
                List{
                    ForEach(Checklists){ Checklist in
                        HStack{
                            
                            Button {
                                instc_checklist = return_instc_checklist(id: Checklist.id)
                                toList.toggle()
                            }label:{
                                Text(Checklist.name).foregroundColor(.black)
                            }
                            }.environment(\.editMode, $mode)
                        
                   
                    
                    }.onMove(perform: move)
                        .onDelete(perform: delete)
             
               
                }.toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button("Add"){
                            Checklists.append(newChecklist(all_checklists: Checklists))
                            writeToJson(Checklists: Checklists)
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading){
                        
                        EditButton()
                    }
                }
                   
                   NavigationLink(
                    destination: ContentView(instc_checklist: instc_checklist, original: instc_checklist, copy: instc_checklist)
                                    // .navigationBarBackButtonHidden(true)
                                  ,
                                  isActive: $toList
                   ){ }
           }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                   .onAppear{
                       Checklists = load(strt: true)
                           // Copy_Checklists = load(strt: true)
                   }
                   .navigationTitle("Checklists")
                 
           }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            
            
    }
}

var Start = MasterView()

struct MasterView_Previews: PreviewProvider {
    static var previews: some View {
        
       Start
    }
}
