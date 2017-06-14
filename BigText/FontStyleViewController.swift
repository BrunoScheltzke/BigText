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
    var heightConstraintOfContainerView: NSLayoutConstraint!
    
    var label: UILabel!
    var timer = Timer()
    var isCrazyModeon : Bool = false
    
    @IBOutlet weak var crazyModeButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOfFontStyle.delegate = self
        tableViewOfFontStyle.dataSource = self
    }
    
    @IBAction func dismissTextStyleViewContainer(_ sender: Any) {
        heightConstraintOfContainerView.constant = 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVc = segue.destination as! SpecSelectionViewController
        
        destVc.label = label
        destVc.whatToDisplay = sender as! Int
    }
    
    @IBAction func goCrazyMode(_ sender: Any) {
        heightConstraintOfContainerView.constant = 0
        if isCrazyModeon{
            timer.invalidate()
            crazyModeButton.title = "Crazy Mode"
            isCrazyModeon = false
        }else{
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
            crazyModeButton.title = "Stop Crazy Mode"
            isCrazyModeon = true
        }
        
    }
    
    func updateCounting(){
        let textColor = label.textColor
        let backgroundColor = label.backgroundColor
        label.textColor = backgroundColor
        label.backgroundColor = textColor
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
