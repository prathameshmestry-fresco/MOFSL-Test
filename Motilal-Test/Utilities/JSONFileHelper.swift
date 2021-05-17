//
//  JSONFileHelper.swift
//  Motilal-Test
//
//  Created by Prathamesh Mestry on 16/05/21.
//

import UIKit

class JSONFileHelper{
    
    static let shared = JSONFileHelper()
    
    ///to get the url from documents directory
    private func getFileURLfromDirectory(filename: String) -> URL?{
        let manager = FileManager.default
        let urls = manager.urls(for: .documentDirectory, in: .userDomainMask)
        if let url = urls.first{
            let fileURL = url.appendingPathComponent(filename+".json")
            return fileURL
        }
        return nil
    }
    
    // read the json file
    func readDataFromJSONFile(filename:String) -> [TodoTaskModel]?{
        guard let fileURL = getFileURLfromDirectory(filename: filename) else {
            return nil
        }
        
        do {
            //get string from the path and then using Codable protocol, get the model created
            let savedString = try String(contentsOf: fileURL, encoding: .utf8)
            let model = getModelDataFromString(string: savedString)
            return model
        } catch {
            print("Error reading saved file")
        }
        return nil
    }
    
    func writeToJSONFile(filename:String, model: [TodoTaskModel]) -> Bool{
        
        guard let fileURL = getFileURLfromDirectory(filename: filename) else {
            return false
        }
               
        var json: String = ""      
        do {
            let codedjson = try JSONEncoder().encode(model)
            json = String(data: codedjson, encoding: .utf8) ?? ""
        } catch  {
            print("error: \(error)")
        }
        
        //get string by using codable from the model, and write the string to the file
        do {
            try json.write(to: fileURL, atomically: true, encoding: .utf8)//write(to: fileURL)
            return true
        } catch  {
            print("error: \(error)")
        }
        
        return false
    }
    
    
    func getModelDataFromString(string: String) -> [TodoTaskModel]?{
        do{
            guard let jsonData = string.data(using: .utf8) else { return nil }
            let person = try JSONDecoder().decode([TodoTaskModel].self, from: jsonData)
            return person
        }
        catch{
            print(error)
        }
        return nil
        
    }
    
}
