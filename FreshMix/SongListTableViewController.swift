//
//  SongListTableViewController.swift
//  FreshMix
//
//  Created by Dunkley, Rachel A on 11/3/17.
//  Copyright © 2017 Dunkley, Rachel A. All rights reserved.
//

import UIKit

class SongListTableViewController: UITableViewController {
    
    var myIndex = 0
    var musicModel = MusicModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("******VIEW DID LOAD")
        musicModel.loadGenreIcons()
        
        
        
    }
 
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return musicModel.genreIconArray.count
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "SongTableViewCell"
        //need to downcast as our own tableViewCell type -> to be more specific
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! SongTableViewCell
        
        //Configure the cell::
        
        //display the Genre:
        cell.genreLabel?.text = musicModel.genreIconArray[indexPath.row].text
        cell.coverImage?.image = musicModel.genreIconArray[indexPath.row].coverImage
      
       
        return cell
    }
    
        
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationViewController = segue.destination
        
        if let navigationController = destinationViewController as? UINavigationController{
            destinationViewController = navigationController.visibleViewController ?? destinationViewController
        }
        if let playerViewController = destinationViewController as? PlayerViewController,
            let identifier = segue.identifier{
            
            playerViewController.musicModel.genre = identifier
            
            let indexPath = tableView.indexPathForSelectedRow!
                playerViewController.myIndex = indexPath.row
         
            playerViewController.navigationItem.title = musicModel.genrePlaylist[indexPath.row]
            
        }
    }
    
    
        
        
    
  
   

    
    
    
/*
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 
*/
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
 
}
