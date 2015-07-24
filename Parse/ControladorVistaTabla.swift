//
//  ControladorVistaTabla.swift
//  Parse
//
//  Created by Apple on 21/07/15.
//  Copyright (c) 2015 mcanche. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ControladorVistaTabla: PFQueryTableViewController
{
 
    // Initialise the PFQueryTable tableview
    override init(style: UITableViewStyle, className: String!)
    {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        // Configure the PFQueryTableView
        self.parseClassName = "Correspondencia"
        self.textKey = "nombre"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery
    {
        var query = PFQuery(className: "Correspondencia")
        query.orderByAscending("nombre")
        //query.whereKey("currencyCode", equalTo:"EUR")
        return query
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("Celda") as! PFTableViewCell!
        if cell == nil
        {
            cell = PFTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Celda")
        }
        // Extract values from the PFObject to display in the table cell
        if let nameEnglish = object?["nombre"] as? String
        {
            cell?.textLabel?.text = nameEnglish
        }
        if let capital = object?["capital"] as? String
        {
            cell?.detailTextLabel?.text = capital
        }
        
        return cell
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        
        // Get the new view controller using [segue destinationViewController].
        var detailScene = segue.destinationViewController as! ControladorVistaDetalle
        
        // Pass the selected object to the destination view controller.
        if let indexPath = self.tableView.indexPathForSelectedRow() {
            let row = Int(indexPath.row)
            detailScene.currentObject = (objects?[row] as! PFObject)
        }
    }
    
    override func viewDidAppear(animated: Bool)
    {
        // Refresh the table to ensure any data changes are displayed
        tableView.reloadData()
    }
   
}
