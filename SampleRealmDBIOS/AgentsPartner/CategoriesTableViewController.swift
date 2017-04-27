/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit
import RealmSwift

class CategoriesTableViewController: UITableViewController {
  
    //var categories : [SpecimenAnnotation] = []

    let realm = try! Realm()
    lazy var categories : Results<Categories> = {self.realm.objects(Categories.self)}()
    var selectedCategory: Categories!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    populateDefaultCategories()

  }
  
  override var preferredStatusBarStyle : UIStatusBarStyle {
    return .default
  }
    
  //call this function when there is no data - for default data
    func populateDefaultCategories() {
        if self.categories.count == 0 {
            try! self.realm.write {
                let defaultCategories = ["Birds", "Mammals", "Flora", "Reptiles", "Arachnids" ]
                for category in defaultCategories{
                    let categoryObj = Categories()
                    categoryObj.name = category
                    self.realm.add(categoryObj)
                }
            }
            
        }
        self.categories = self.realm.objects(Categories)
    }
}

// MARK: - UITableViewDataSource
extension CategoriesTableViewController {
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categories.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
    let categoryObj = categories[indexPath.row]
    cell.textLabel?.text = categoryObj.name
    return cell
  }
    
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath {
    selectedCategory = categories[indexPath.row]
    return indexPath
  }
}
