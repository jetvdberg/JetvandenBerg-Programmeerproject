//
//  SocialTableViewController.swift
//  Love Me Adopt Me
//
//  Created by Jet van den Berg on 11-01-18.
//  Copyright © 2018 Jet van den Berg. All rights reserved.
//
// searchbar: https://www.youtube.com/watch?v=zgP_VHhkroE

import UIKit
import Firebase
import FirebaseDatabase

class SocialTableViewController: UITableViewController, UISearchBarDelegate {
    
    // Properties
    
    var currentUsers: [String] = []
    var filteredUsers = [String]()
    let usersRef = Database.database().reference(withPath: "online-users")
    var isSearching = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    // UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        // Checks if a user is online, adds user to Firebase
        usersRef.observe(.childAdded, with: { snap in
            guard let email = snap.value as? String else { return }
            self.currentUsers.append(email)
            let row = self.currentUsers.count - 1
            let indexPath = IndexPath(row: row, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .top)
        })
        
        // Checks if a user is offline, removes user from Firebase
        usersRef.observe(.childRemoved, with: { snap in
            guard let emailToFind = snap.value as? String else { return }
            for (index, email) in self.currentUsers.enumerated() {
                if email == emailToFind {
                    let indexPath = IndexPath(row: index, section: 0)
                    self.currentUsers.remove(at: index)
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        })
    }
    
    // UITableView Delegate methods
    // Returns amount of online users
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            return filteredUsers.count
        }
        
        return currentUsers.count
    }
    
    // Fills in cell with online user
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        let onlineUserEmail: String!
        
        if isSearching {
            onlineUserEmail = filteredUsers[indexPath.row]
        } else {
            onlineUserEmail = currentUsers[indexPath.row]
        }
        
         cell.textLabel?.text = onlineUserEmail
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        } else {
            isSearching = true
            filteredUsers = currentUsers.filter({$0.localizedCaseInsensitiveContains(searchBar.text!)})
            tableView.reloadData()
        }
    }
    
    @IBAction func logoutButtonPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
}
