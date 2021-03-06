//
//  FilmsViewController.swift
//  MVC in iOS
//
//  Created by admin on 14/12/2021.
//

import UIKit

class FilmsViewController: UITableViewController {
    // Hardcoded data for now
          var films = [String]()
         
       override func viewDidLoad() {
               super.viewDidLoad()
           StarWarsModel.getAllFilms(completionHandler: { // passing what becomes "completionHandler" in the 'getAllPeople' function definition in StarWarsModel.swift
                      data, response, error in
                          do {
                              // Try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                              if let data = data {
                              if let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                                  if let results = jsonResult["results"] as? NSArray {
                                      for film in results {
                                          let filmDict = film as! NSDictionary
                                          self.films.append(filmDict["title"]! as! String)
                                      }
                                  }
                              }
                              }
                              DispatchQueue.main.async {
                                  self.tableView.reloadData()
                              }
                          } catch {
                              print("Something went wrong")
                          }
                  })
       }


          override func didReceiveMemoryWarning() {
              super.didReceiveMemoryWarning()
          }
          override func numberOfSections(in tableView: UITableView) -> Int {
              // if we return - sections we won't have any sections to put our rows in
              return 1
          }
          override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              // return the count of people in our data array
              return films.count
          }
          override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              // Create a generic cell
              let cell = UITableViewCell()
              // set the default cell label to the corresponding element in the people array
              cell.textLabel?.text = films[indexPath.row]
              // return the cell so that it can be rendered
              return cell
          }


}
