//
//  ContentView.swift
//  Shared
//
//  Created by Jemil Pepena on 13/4/2022.
//

import SwiftUI



struct Checklist: Codable, Identifiable, Hashable{
    var id : Int
    var name: String
    var  items: [String]
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
            
            
        }
        }
    print(checklistArray)
    return checklistArray
    
       
    
}

struct MasterView: View {
  
    @State private var Checklists : [Checklist] = load()
  
    var body: some View {
        VStack{
            HStack{
                Button("Edit"){}
                    .padding(.leading, 30)
                Spacer()
                Button("Done"){}
                    .padding(.trailing, 30)
            }
            .frame(alignment: .topLeading)
           
            NavigationView{
                List{
                    ForEach(Checklists, id: \.self){ Checklist in
                        NavigationLink{
                            
                            ContentView(instc_checklist: Checklist)
                        } label:{
                        Text(Checklist.name)
                        }
                    }
                }.navigationTitle("Checklists")
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
