//
//  functions.swift
//  Checklist
//
//  Created by Jemil Pepena on 2/5/2022.
//

import Foundation


/// This structure name **Checklist** holds the data of an individual checklist
struct Checklist:   Codable, Identifiable{
    /// unique string identifier of checklist
    var id : String
    /// name of checklist
    var name: String
    ///struct holding checklist items
    var  items: Items


}
////structure to hold the items of a checklist
struct Items: Codable, Equatable{
    ///holds pos of each checklist item from 0,1,2 .....3....
    var id: [Int]
    /// array of name of items
    var itemNames: [String]
    ///array of bools correspoding to item name and id, showing if a list item i checked or unchecked
    var hasCompleted: [Bool]
}
///struc that holds json data is loaded into
struct JSONData: Codable{
    /// array that checklists are stored in
    let checklists : [Checklist]
}

/// load fucntion that loads json from app bundle into file manager
/// - Returns: returns all checklist as an array of checklists
func load(strt: Bool) -> [Checklist]{
    var checklistArray: [Checklist] = []
  
        let path = Bundle.main.url(forResource: "checklist_data", withExtension: "json")! //path of jason file in bundle
        
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! // Initializing the url for the location where we store our data in filemanager
            let jsonURL = documentDirectory //apending the filename to the url
        .appendingPathComponent("checklist_data")
        .appendingPathExtension("json")
    
    if !FileManager.default.fileExists(atPath: jsonURL.path){ // The following condition copies the example file in our bundle to the correct location if it isnt present
        try? FileManager.default.copyItem(at: path, to: jsonURL)
        
    }


    if let jsondata = try? JSONDecoder().decode(JSONData.self, from: Data(contentsOf: jsonURL)){ //decodes data in json file in file manager
        checklistArray = jsondata.checklists //stores data into our array of cehcklists
    }
    return checklistArray // returns data
    
       
    
}
/**
 writes checklist information to json file
 
 1.Take an array of checklists stored using the Checklist struct,
 2.encodes it using json encoder
 3.wirtes it as a string to our json file
 
 
 - Parameter Checklists: writes to our json file in file manager
 */
func writeToJson(Checklists: [Checklist]){ //

    do {
      let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)//url of our local directory in an array
        
      let documentFolderURL = urls.first!
      let fileURL = documentFolderURL.appendingPathComponent("checklist_data.json") //appends name of ur json file
      let json = JSONEncoder()
      let data = try json.encode(Checklists) //encodes our checklists
        let data_ = "{ \"checklists\": " + String(data: data,encoding: .utf8)! + "}" //adds some missing information
            
        
        try data_.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8) //writes data
        
    } catch {
      print("Got \(error)") //error handling
    }
}
