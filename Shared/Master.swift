//
//  ContentView.swift
//  Shared
//
//  Created by Jemil Pepena on 13/4/2022.
//
import Foundation
import SwiftUI


struct Checklist:   Codable, Identifiable{
    var id = UUID().uuidString
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
func load() -> [Checklist]{
    var checklistArray: [Checklist] = []
    if  let path = Bundle.main.path(forResource: "checklist_data", ofType: "json"),
        let data = try? Data(contentsOf: URL(fileURLWithPath: path)){
        print(path)
        let decoder = JSONDecoder()
        if let jsondata = try? decoder.decode(JSONData.self, from: data){
            checklistArray = jsondata.checklists
            
            print("decoding")
        }
        }


      
    print()
    print()
    print()
    print()
    return checklistArray
    
       
    
}

func writeToJson(Checklists: [Checklist]){
    do{
    let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

    let documentFolderURL = urls.first!
    let fileURL = documentFolderURL.appendingPathComponent("checklist_data.json")
    let json = JSONEncoder()
    let data = try json.encode(Checklists)
    print()
    print()
       // print(String(data: data,encoding: .utf8)!)
    
       // print(urls)
       // print(type(of: data))
        try data.write(to: fileURL)
    
    }catch {
        print("Got \(error)")
      }
}
struct MasterView: View {
  
    @State private var Checklists : [Checklist] = load()
    @State var isShowlingChecklist: Bool = false
    var body: some View {
        VStack{
           
           NavigationView{
               VStack{
               HStack{
                    Button("Edit"){}
                        .padding(.leading, 30)
                    Spacer()
                    Button("Add"){}
                        .padding(.trailing, 30)
               }.frame(alignment: .topLeading)
                   
               Text("Checklists")
                       .font(.largeTitle)
                       .fontWeight(.bold)
                       .frame(maxWidth: .infinity, alignment: .topLeading)
                       .padding(.leading, 30)
                       .padding(.top, 10)
                      
                List{
                    ForEach(Checklists){ Checklist in
                        NavigationLink{
                            
                            ContentView(instc_checklist: Checklist, all_checklists_: Checklists)
                            
                        }
                    label:{
                        Text(Checklist.name)
                           
                        
                    }
                    }
                } .navigationTitle("Checklists")
                .navigationBarHidden(true)
           }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
               
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
