//
//  ViewController.swift
//  Projekti Faza 2 - Arber Asllani
//
//  Created by Cacttus Education 04 on 4/17/20.
//  Copyright © 2020 CacttusEducation. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var products: [Products] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        products = createArray()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    func createArray() -> [Products] {
        
        let product1 = Products(image: #imageLiteral(resourceName: "cheerios"), title: "Cheerios")
        let product2 = Products(image: #imageLiteral(resourceName: "cocoapuffs"), title: "Cocoa Puffs")
        let product3 = Products(image: #imageLiteral(resourceName: "cornflakes"), title: "Corn Flakes")
        let product4 = Products(image: #imageLiteral(resourceName: "cocoapebbles"), title: "Cocoa Pebbles")
        let product5 = Products(image: #imageLiteral(resourceName: "cookiecrisp"), title: "Cookie Crisp")
        let product6 = Products(image: #imageLiteral(resourceName: "wafflecrisp"), title: "Waffle Crisp")
        let product7 = Products(image: #imageLiteral(resourceName: "frootloops"), title: "Froot Loops")
        let product8 = Products(image: #imageLiteral(resourceName: "appledracs"), title: "Apple Dracs")
        let product9 = Products(image: #imageLiteral(resourceName: "frootloops"), title: "Froot Loops")
        
        return [product1, product2, product3, product4, product5, product6, product7, product8, product9]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = products[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "productsCell") as! ProductsTableViewCell
        cell.setProducts(product: product)
        
        return cell
      }
    
}
