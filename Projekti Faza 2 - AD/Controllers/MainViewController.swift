//
//  MainViewController.swift
//  Projekti Faza 2 - Arber Asllani
//
//  Created by Cacttus Education 04 on 4/17/20.
//  Copyright © 2020 CacttusEducation. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var menuTable: UITableView!
    @IBOutlet var menuView: UIView!
    var isMenuOpen: Bool = false
    @IBOutlet weak var mainView: UIView!
    
    private var homeViewController: HomeViewController?
    private var secondViewController: SecondViewController?
    private var thirdViewController: ThirdViewController?
    
    var menuItems = ["Products", "I/O", "Web Browser", "Map"]
    
    func setUpMenu(){
        menuView.frame = CGRect(x: self.mainView.frame.width*2, y: 0, width: self.mainView.frame.width/2, height: self.mainView.frame.height)
            self.mainView.addSubview(menuView)
        
        scrollView.scrollRectToVisible(CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height), animated: true)
        
    }
    
    @IBAction func menuPressed(_ sender: Any) {
        if(isMenuOpen == false) {
            showMenu()
        } else {
            closeMenu()
        }
    }
    
     func showMenu(){
           UIView.animate(withDuration: 0.5) {
               self.menuView.frame = CGRect(x: 250, y: 0, width: self.mainView.frame.width, height: self.mainView.frame.height*2)
           }
           isMenuOpen = true
       }
    
     func closeMenu(){
          UIView.animate(withDuration: 0.5) {
              self.menuView.frame = CGRect(x: self.mainView.frame.width*2, y: 0, width: self.mainView.frame.width/2, height: self.mainView.frame.height)
          }
          isMenuOpen = false
      }

    func setUpMenuTable(){
        menuTable.delegate = self
        menuTable.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "menu_cell")!
            
        cell.textLabel?.text = self.menuItems[indexPath.row]

                return cell
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        closeMenu()
    }
    
    override func viewDidLoad() {
        
        setUpMenu()
        setUpMenuTable()
        
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "secondViewController") as! SecondViewController
        
        let thirdViewController = storyboard.instantiateViewController(withIdentifier: "thirdViewController") as! ThirdViewController
        
        let fourthViewController = storyboard.instantiateViewController(withIdentifier: "fourthViewController") as! FourthViewController
        
        let APIViewController = storyboard.instantiateViewController(withIdentifier: "APIViewController")
            as! APIViewController
        
        let bounds = UIScreen.main.bounds
        let width = bounds.size.width
        let height = bounds.size.height
        
        scrollView!.contentSize = CGSize(width: 5*width, height: height)
        
        let viewControllers = [homeViewController, APIViewController, secondViewController, thirdViewController, fourthViewController]
        
        var idx:Int = 0
        
        for viewController in viewControllers {
                
            addChild(viewController)
                let originX:CGFloat = CGFloat(idx) * width
            viewController.view.frame = CGRect(x: originX, y: 0, width: width, height: height)
                scrollView!.addSubview(viewController.view)
            viewController.didMove(toParent: self)
                idx+=1
            }
        }
    }
