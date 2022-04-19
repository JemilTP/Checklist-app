//
//  ContentView.swift
//  Shared
//
//  Created by Jemil Pepena on 13/4/2022.
//

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
       
        let decoder = JSONDecoder()
        if let jsondata = try? decoder.decode(JSONData.self, from: data){
            checklistArray = jsondata.checklists
            
            print("decoding")
        }
        }


    
    print(checklistArray)
    print()
    print()
    print()
    return checklistArray
    
       
    
}

struct MasterView: View {
  
    @State private var Checklists : [Checklist] = load()
    @State var isShowlingChecklist: Bool = false
    var body: some View {
        VStack{
        /*    if isShowlingChecklist == false{
                   HStack{
                        Button("Edit"){}
                            .padding(.leading, 30)
                        Spacer()
                        Button("Add"){}
                            .padding(.trailing, 30)
                    }
                    .frame(alignment: .topLeading)
                        
            }
            */
           
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
                List{
                    ForEach(Checklists){ Checklist in
                        NavigationLink{
                            
                            ContentView(instc_checklist: Checklist)
                            
                        }
                    label:{
                        Text(Checklist.name)
                           
                        
                        }
                    }
                } .navigationTitle("Checklists")
                .navigationBarHidden(true)
           }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
              
           }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            
    }
}

var Start = MasterView()

struct MasterView_Previews: PreviewProvider {
    static var previews: some View {
        
       Start
    }
}
