//
//  TaskListModel.swift
//  Motilal-Test
//
//  Created by Prathamesh Mestry on 15/05/21.
//

import Foundation

struct TodoTaskModel: Codable {
    
    var title: String?
    var description : String?
    var taskDate : Date?
    var isReminder : Bool?
    var id: Int?
    
    init(){
        
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "todoDescription"
        case taskDate = "todoDate"
        case isReminder = "isReminder"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        taskDate = try values.decodeIfPresent(Date.self, forKey: .taskDate)
        isReminder = try values.decodeIfPresent(Bool.self, forKey: .isReminder)
    }
    
    func getJSONDataFromModel() -> String?{
        do{
            let codedjson = try JSONEncoder().encode(self)
            let json = String(data: codedjson, encoding: .utf8)
            return json
        }
        catch{
            print(error)
        }
        return nil
    }
    
}
