//
//  ContentView.swift
//  Shared
//
//  Created by Jemil Pepena on 13/4/2022.
//

import SwiftUI



struct Checklist: Codable{
    let name: String
    let  items: [String]
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
    return checklistArray
    
       
    
}

struct MasterView: View {
  
    @State private var Checklists : [Checklist] = []
    
    func initiate(){
        self.Checklists = load()
        print(self.Checklists)
    }
        
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
            
            Text("Checklists")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity,maxHeight: 100, alignment: .topLeading)
                .shadow(radius: 50)
                .padding(.leading, 30)
                .padding(.top,20)
        
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .onAppear(perform: initiate)
    }
}

struct MasterView_Previews: PreviewProvider {
    static var previews: some View {
        MasterView()
    }
}
