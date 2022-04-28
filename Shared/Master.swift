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
        if  let path = Bundle.main.path(forResource: "checklist_data", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
           
               
                print("start: ", URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
            print(String(data: data,encoding: .utf8)!)
                if let jsondata = try? decoder.decode(JSONData.self, from: data){
                    checklistArray = jsondata.checklists
                    
                    
                }
        }
  /*  }else{
        
        if let  urls =  Bundle.main.path(forResource: "checklist_data", ofType: "json"){
        
        //let documentFolderURL = urls.first!
     //   let fileURL = documentFolderURL.appendingPathComponent("checklist_data.json")
        let fileURL = URL(fileURLWithPath: urls)
        
        print("started: ", fileURL)
        if let data = try? Data(contentsOf: fileURL){
            let decoder = JSONDecoder()
            print("did not decode")
            print(String(data: data,encoding: .utf8)!)
            if let jsondata = try? decoder.decode(JSONData.self, from: data){
                checklistArray = jsondata.checklists
                print("actually decoded")
                
            }
        }
        }
    }*/
    
    print(checklistArray)
    print()
    print()
    print()
    print()
    
    return checklistArray
    
       
    
}

func writeToJson(Checklists: [Checklist]){
    do{
    if let  url =  Bundle.main.path(forResource: "checklist_data", ofType: "json"){
        let fileURL = URL(fileURLWithPath: url)
        
   // let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
  //  let documentFolderURL = urls.first!
   // let fileURL = documentFolderURL.appendingPathComponent("checklist_data.json")
    print("writing to: ", fileURL)
    let json = JSONEncoder()
    let data = try json.encode(Checklists)
        print(data)
     
    let data_ = "{ \"checklists\": " + String(data: data,encoding: .utf8)! + "}"
        print(data_)
      //  print("correct:", data_)
   
       // print(urls)
       // print(type(of: data))
       try  "".write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        try data_.write(to: fileURL ,atomically: true, encoding: String.Encoding.utf8)
    }
    
    }catch {
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
struct MasterView: View {
  
    @State private var Checklists : [Checklist] = []
  @State var isShowlingChecklist: Bool = false
    @State var toList: Bool = false
    @State var instc_checklist = load(strt: false)[0]
    @State var Edit_Main: Bool = false
    @State var Add_Checklist: Bool = false
    var body: some View {
        VStack{
           
           NavigationView{
              
               VStack{
    
                List{
                    ForEach(Checklists){ Checklist in
                      
                        Button(Checklist.name){
                            instc_checklist = return_instc_checklist(id: Checklist.id)
                            toList.toggle()
                        }
              
                   
                    }
                }
             
               
                
                   NavigationLink(
                                  destination: ContentView(instc_checklist: instc_checklist)
                                    // .navigationBarBackButtonHidden(true)
                                  ,
                                  isActive: $toList
                   ){ }
           }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                   .onAppear{
                       Checklists = load(strt: true)
                   }
                   .navigationTitle("Checklists")
                   .toolbar{
                       ToolbarItem(placement: .navigationBarTrailing){
                      Button("Add"){
                          Checklists.append(newChecklist(all_checklists: Checklists))
                          writeToJson(Checklists: Checklists)
                      }
                       }
                       
                       ToolbarItem(placement: .navigationBarLeading){
                           Button("Edit"){
                               
                           }
                       }
                   }
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
