//
//  SpecSelectionViewController.swift
//  BigText
//
//  Created by Bruno Scheltzke on 14/06/17.
//  Copyright © 2017 Bruno Scheltzke. All rights reserved.
//

import UIKit

enum whatToShow: Int{
    case font = 0
    case fontColor = 1
    case backgroundColor = 2
}

class SpecSelectionViewController: UIViewController {
    @IBOutlet weak var tableViewWithSpecs: UITableView!
    
    var whatToDisplay : Int!
    var label : UILabel!
    
    let fontValues = ["Arial", "Verdana", "Normal"]
    let colors = ["Black", "White", "Green", "Yellow", "Blue", "Red"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewWithSpecs.delegate = self
        tableViewWithSpecs.dataSource = self
    }
}

extension SpecSelectionViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.whatToDisplay {
        case whatToShow.backgroundColor.rawValue:
            return colors.count
        case whatToShow.font.rawValue:
            return fontValues.count
        case whatToShow.fontColor.rawValue:
            return colors.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "specCell")!
        
        switch self.whatToDisplay {
        case whatToShow.backgroundColor.rawValue:
            cell.textLabel?.text = colors[indexPath.row]
            break
        case whatToShow.font.rawValue:
            cell.textLabel?.text = fontValues[indexPath.row]
            break
        case whatToShow.fontColor.rawValue:
            cell.textLabel?.text = colors[indexPath.row]
            break
        default:
            return cell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.whatToDisplay {
            case whatToShow.backgroundColor.rawValue:
                switch indexPath.row {
                case 0:
                    self.label.backgroundColor = UIColor.black
                    break
                case 1:
                    self.label.backgroundColor = UIColor.white
                    break
                case 2:
                    self.label.backgroundColor = UIColor.green
                    break
                case 3:
                    self.label.backgroundColor = UIColor.yellow
                    break
                case 4:
                    self.label.backgroundColor = UIColor.blue
                    break
                case 5:
                    self.label.backgroundColor = UIColor.red
                    break
                default:
                    break
                }
                break
            case whatToShow.fontColor.rawValue:
                switch indexPath.row {
                case 0:
                    self.label.textColor = UIColor.black
                    break
                case 1:
                    self.label.textColor = UIColor.white
                    break
                case 2:
                    self.label.textColor = UIColor.green
                    break
                case 3:
                    self.label.textColor = UIColor.yellow
                    break
                case 4:
                    self.label.textColor = UIColor.blue
                    break
                case 5:
                    self.label.textColor = UIColor.red
                    break
                default:
                    break
                }
                break
            case whatToShow.font.rawValue:
                switch indexPath.row {
                case 0:
                    self.label.font = UIFont(name: "Arial", size: label.font.pointSize)
                    break
                case 2:
                    self.label.font = UIFont(name: "Verdana", size: label.font.pointSize)
                    break
                case 3:
                    self.label.font = UIFont.systemFont(ofSize: label.font.pointSize)
                    break
                default:
                    break
                }
                break
            default:
                break
        }
    }
}
