//
//  SocialTableViewController.swift
//  Love Me Adopt Me
//
//  Created by Jet van den Berg on 11-01-18.
//  Copyright © 2018 Jet van den Berg. All rights reserved.
//
//  This class holds all the users who have created an account for the app. A user can search other users with a searchbar. This class shows recently viewed accounts, and navigates the user to the list in DetailsUserTableViewController when selecting another user in the list. For this searchbar is some code used from a tutorial on YouTube: https://www.youtube.com/watch?v=zgP_VHhkroE.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class SocialTableViewController: UITableViewController, UISearchBarDelegate {
    
    // Properties
    var allUsers = [User]()
    var filteredUsers = [User]()
    var viewedUsers = [User]()
    let allUsersRef = Database.database().reference(withPath: "all-users")
    let viewedUsersRef = Database.database().reference(withPath: "viewed-users")
    let userID = (Auth.auth().currentUser?.uid)!
    var socialHeaders = ["Recently Viewed Users", "Users"]
    var isSearching = false
    var sectionTracker: Int = 0
    
    // Outlet
    @IBOutlet weak var searchBar: UISearchBar!
    
    // Loads view, performs functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets functions for searchbar
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        searchBar.autocapitalizationType = .none
        searchBar.keyboardType = .emailAddress
        
        getAllUsers()
    }
    
    // Updates viewed users
    override func viewWillAppear(_ animated: Bool) {
        getViewedUsers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewDidLoad()
    }
    
    // Gets list of all existing users from Firebase
    func getAllUsers() {
        allUsersRef.observeSingleEvent(of: .value, with: { snapshot in
            if !snapshot.exists() { return }
            self.allUsers = []
            
            // Iterates over snapshot from Firebase, adds them to list
            for user in snapshot.children.allObjects as! [DataSnapshot] {
                let userObject = user.value as? [String: AnyObject]
                let email = userObject?["email"] as! String
                let uid = userObject?["uid"] as! String
                let user = User(uid: uid, email: email)
                
                // Checks for not adding current user to list
                if self.userID != uid {
                    self.allUsers.append(user)
                }
                self.tableView.reloadData()
            }
        })
    }
    
    // Gets list of all viewed users of current user from Firebase
    func getViewedUsers() {
        viewedUsersRef.child(userID).queryOrdered(byChild: "timestamp").observeSingleEvent(of: .value, with: { snapshot in
            if !snapshot.exists() { return }
            self.viewedUsers = []
            
            // Iterates over snapshot from Firebase, adds them to list
            for user in snapshot.children.allObjects as! [DataSnapshot] {
                let userObject = user.value as? [String: AnyObject]
                let email = userObject?["email"] as! String
                let uid = userObject?["uid"] as! String
                let user = User(uid: uid, email: email)
                self.viewedUsers.insert(user, at: 0)
                
                // Checks if there are no more than 3 in list
                if self.viewedUsers.count > 3 {
                    self.viewedUsers.removeLast()
                }
                self.tableView.reloadData()
            }
        })
    }
    
    // Sets titles for headers in TableView
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return socialHeaders[section]
    }
    
    // Returns number of sections in TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return socialHeaders.count
    }
    
    // Returns amount of users, depending on which section is selected
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewedUsers.count
        default:
            if isSearching {
                return filteredUsers.count
            }
            return allUsers.count
        }
    }
    
    // Fills in cell with users, depending on which section
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        let onlineUserEmail: String!
        
        // Checks which sections should be filled with corresponding data
        switch indexPath {
        case [0,0]:
            onlineUserEmail = viewedUsers[indexPath.row].email
        case [0,1]:
            onlineUserEmail = viewedUsers[indexPath.row].email
        case [0,2]:
            onlineUserEmail = viewedUsers[indexPath.row].email
        default:
            if isSearching {
                onlineUserEmail = filteredUsers[indexPath.row].email
            } else {
                onlineUserEmail = allUsers[indexPath.row].email
            }
        }
        
        cell.textLabel?.text = onlineUserEmail
        
        return cell
    }
    
    // Keeps track of selected cell, updates list in Firebase using timestamp
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchedUserID = allUsers[indexPath.row].uid
        let timestamp = ServerValue.timestamp()
        sectionTracker = indexPath.section

        // Creates new path in Firebase for viewed users of current user
        Database.database().reference().child("viewed-users").child(userID).child(searchedUserID).setValue([
            "email": allUsers[indexPath.row].email,
            "uid": searchedUserID,
            "timestamp": timestamp
            ])
    }
    
    // Checks if searchbar is used
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
            
        // Filters out corresponding emails when searching
        } else {
            isSearching = true
            filteredUsers = allUsers.filter({$0.email.localizedCaseInsensitiveContains(searchBar.text!)})
            tableView.reloadData()
        }
    }
    
    // Button for logging out
    @IBAction func logoutButtonPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    // Performs segue to DetailsUsersViewController, sends corresponding data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UserSegue" {
            let detailsUsersTableViewController = segue.destination as! DetailsUsersTableViewController
            let index = tableView.indexPathForSelectedRow!.row
            
            // Checks for which section is tapped, or if user taps section when searching
            if sectionTracker == 0 {
                detailsUsersTableViewController.user = viewedUsers[index]
            } else if sectionTracker == 1 {
                detailsUsersTableViewController.user = allUsers[index]
            } else if isSearching {
                detailsUsersTableViewController.user = filteredUsers[index]
            }
        }
    }
    
}
