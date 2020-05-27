//
//  ProductsTableViewCell.swift
//  Projekti Faza 2 - Arber Asllani
//
//  Created by Cacttus Education 04 on 4/18/20.
//  Copyright © 2020 CacttusEducation. All rights reserved.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {

    @IBOutlet weak var productsImageView: UIImageView!
    @IBOutlet weak var productsTitle: UILabel!
    
    func setProducts(product: Products) {
          productsImageView.image = product.image
          productsTitle.text = product.title
      }
}
