//
//  ViewController.swift
//  IOS-Swift-ParsingJson01
//
//  Created by Pooya Hatami on 2018-05-16.
//  Copyright © 2018 Pooya Hatami. All rights reserved.
//

import UIKit

struct WebsiteDescription: Decodable {
    let name: String
    let description: String
    let courses: [Course]
}


struct Course: Decodable {
    let id : Int?
    let name : String?
    let link : String?
    
    let imageUrl : String?
}


class ViewController: UIViewController {

    @IBOutlet weak var readResult: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func readBtn(_ sender: Any) {
        var outputStr = ""
        
        //let jasonUrlString = "https://raw.githubusercontent.com/soonin/IOS-Swift-ParsingJson/master/IOS-Swift-ParsingJson/course.json"
        //let jasonUrlString = "https://raw.githubusercontent.com/soonin/IOS-Swift-ParsingJson/master/IOS-Swift-ParsingJson/courses.json"
        //let jasonUrlString = "https://raw.githubusercontent.com/soonin/IOS-Swift-ParsingJson/master/IOS-Swift-ParsingJson/website_description.json"
        //let jasonUrlString = "https://raw.githubusercontent.com/soonin/IOS-Swift-ParsingJson/master/IOS-Swift-ParsingJson/courses_missing.json"
        let jasonUrlString = "https://raw.githubusercontent.com/soonin/IOS-Swift-ParsingJson/master/IOS-Swift-ParsingJson/courses_snake_case.json"
        
        guard let url = URL(string: jasonUrlString) else { return }
        URLSession.shared.dataTask(with: url) {(data, respons, err) in
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                // swift 4.1
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let courses = try decoder.decode([Course].self, from: data)
                //let websiteDes = try decoder.decode(WebsiteDescription.self, from: data)
                
//                outputStr += "name: " + courses.name + "\n"
//                outputStr += "Link: " + courses.link + "\n"
                
                outputStr = courses.description
                
//                outputStr += "name: " + websiteDes.name + "\n"
//                outputStr += "description: " + websiteDes.description + "\n"
//                outputStr += "name: " + websiteDes.courses.description
                
                
                print(courses)
//                print(websiteDes)

                DispatchQueue.main.async {
                    self.readResult!.text = outputStr
                }
                
                
            } catch let jsonErr {
                print("Error serializing json: \(jsonErr)")
            }
        }.resume()
        
        
    }
    
    @IBAction func cleanBtn(_ sender: Any) {
        self.readResult!.text = ""
        
    }
}

