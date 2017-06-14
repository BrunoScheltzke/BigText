//
//  FontStyleViewController.swift
//  BigText
//
//  Created by Bruno Scheltzke on 14/06/17.
//  Copyright © 2017 Bruno Scheltzke. All rights reserved.
//

import UIKit

class FontStyleViewController: UIViewController {

    @IBOutlet weak var tableViewOfFontStyle: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOfFontStyle.delegate = self
        tableViewOfFontStyle.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVc = segue.destination as! SpecSelectionViewController
        
        destVc.whatToDisplay = sender as! Int
    }
}

extension FontStyleViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell")!
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Font"
            break
        case 1:
            cell.textLabel?.text = "Color"
            break
        case 2:
            cell.textLabel?.text = "Background Color"
            break
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showSelection", sender: indexPath.row)
    }
}
