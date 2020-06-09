//
//  MainTableViewController.swift
//  Touch
//
//  Created by Tong Yi on 5/4/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController
{
    let cellID = "Touch_Cell"
    var makeupData = dataSouce
    let HeightOfSection: CGFloat = 28
    let makeupType = MakeupType.allCases
    @IBOutlet var trashButton: UIBarButtonItem!
    @IBOutlet var addButton: UIBarButtonItem!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup
    func setup() {
        self.title = "Touch"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        tableView.tableFooterView = UIView()
        tableView.allowsMultipleSelectionDuringEditing = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return MakeupType.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return makeupData[section].count
    }

    // MARK: - Table View delegate
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return HeightOfSection
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: HeightOfSection))
        button.backgroundColor = UIColor(red: 200.0/255.0, green: 220.0/255.0, blue: 196.0/255.0, alpha: 1)
        button.setTitleColor(.darkText, for: .normal)
        button.tag = section
        button.setTitle(makeupData[section][0].makeupType.rawValue, for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(headerTapped(_:)), for: UIControl.Event.touchUpInside)
        return button
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TouchCell
        let makeup = makeupData[indexPath.section][indexPath.row]
        
        cell.makeupImage.image = makeup.makeupPoster
        cell.titleLable.text = makeup.brand
        cell.subtitleLable.text = makeup.makeup
        cell.rateImage.image = makeup.rateImage
        cell.rateLable.text = makeup.rateNUm

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isEditing
        {
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return !tableView.isEditing
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            // Delete the row from the data source
            makeupData[indexPath.section].remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        var makeupMove = makeupData[fromIndexPath.section][fromIndexPath.row]
        makeupData[fromIndexPath.section].remove(at: fromIndexPath.row)
        if fromIndexPath.section != to.section
        {
            switch to.section {
            case 0:
                makeupMove.makeupType = .Face
            case 1:
                makeupMove.makeupType = .Eye
            case 2:
                makeupMove.makeupType = .Lip
            case 3:
                makeupMove.makeupType = .Brush
            default:
                makeupMove.makeupType = .Others
            }
        }
        makeupData[to.section].insert(makeupMove, at: to.row)
        self.tableView.reloadData()
    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    override func setEditing(_ editing: Bool, animated: Bool)
    {
        super.setEditing(editing, animated: animated)
        if isEditing
        {
            addButton.isEnabled = false
            trashButton.isEnabled = true
        }
        else{
            addButton.isEnabled = true
            trashButton.isEnabled = false
        }
    }

    @IBAction func deleteButtonTapped(_ sender: Any) {
        if let selectedRows = tableView.indexPathsForSelectedRows
        {
            
            for indexPath in selectedRows {
                makeupData[indexPath.section].remove(at: indexPath.row)
            }
    
            tableView.reloadData()
        }
    }
}

// MARK: - calling Function

extension MainTableViewController
{
    @objc func headerTapped(_ sender: UIButton)
    {
        var makeup: String = ""
        for item in makeupData[sender.tag] {
            makeup += item.brand + "\n"
        }
        
        let alertController = UIAlertController(title: makeupType[sender.tag].rawValue, message: "\(makeup)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
            NSLog ("OK Pressed.")}

        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Protocol Functions

extension MainTableViewController: DataArrangeDelegate
{
    
    func addNewMakeup(data: TouchMakeup) {
        var secNum = 0
        
        switch data.makeupType {
        case .Face:
            secNum = 0
        case .Eye:
            secNum = 1
        case .Lip:
            secNum = 2
        case .Brush:
            secNum = 3
        default:
            secNum = 4
        }
        makeupData[secNum].append(data)
        self.tableView.reloadData()
    }
    
    func modifyExistMakeup(sec: Int, row: Int, data: TouchMakeup) {
        makeupData[sec].remove(at: row)
        addNewMakeup(data: data)
    }
}

// MARK: - Segue function

extension MainTableViewController
{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sVC = segue.destination as! SecondViewController
        sVC.delegate = self
        
        if segue.identifier == "cellSegue"
        {
            let cell = sender.self as! TouchCell
            sVC.row = self.tableView.indexPath(for: cell)!.row
            sVC.sec = self.tableView.indexPath(for: cell)!.section
            let makeup = makeupData[sVC.sec][sVC.row]
            sVC.brand = makeup.brand
            sVC.makeup = makeup.makeup
            sVC.makeupType = makeup.makeupType.rawValue
            sVC.makeupPos = makeup.makeupPoster
            sVC.money = makeup.money
            sVC.rateImg = makeup.rateImage
            sVC.rateN = makeup.rateNUm
            sVC.detail = makeup.detail
            sVC.tagOfSave = 1
        }
    }
}
