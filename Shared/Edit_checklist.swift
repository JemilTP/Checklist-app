//
//  Edit_checklist.swift
//  Checklist
//
//  Created by Jemil Pepena on 20/4/2022.
//

import SwiftUI

struct Edit_checklist: View {
    @State var instc_checklist: Checklist
    
    @State  var name: String = ""
    var body: some View {
      
        
        VStack{
            
            
            if !self.instc_checklist.name.isEmpty{
                
                TextField("Checklist name", text:  $instc_checklist.name)
                
            }
           
        }
        
    }
}

struct Edit_checklist_Previews: PreviewProvider {
    static var previews: some View {
        
        let temp = Checklist(
            id: "jbsijb", name: "Example", items: Items (id: [0,1,2,3],itemNames: ["item1", "item2", "item3", "item4"], hasCompleted: [false,false,false,false])
        )
        
        
        Edit_checklist(instc_checklist: temp)
    }
}
