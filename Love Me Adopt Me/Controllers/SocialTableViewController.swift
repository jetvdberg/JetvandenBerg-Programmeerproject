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
import FirebaseAuth

class SocialTableViewController: UITableViewController, UISearchBarDelegate {
    
    // Properties
    var allUsers = [User]()
    var filteredUsers = [User]()
    var viewedUsers = [User]()
    let allUsersRef = Database.database().reference(withPath: "all-users")
    let viewedUsersRef = Database.database().reference(withPath: "viewed-users")
    let userID = (Auth.auth().currentUser?.uid)!
//    var users = [User]()
    var isSearching = false
    var socialHeaders = ["Recently Viewed Users", "Users"]
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    // UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
//        searchBar.returnKeyType = .done
        searchBar.autocapitalizationType = .none
        searchBar.keyboardType = .emailAddress
        
        getAllUsers()
        getSearchedUsers()

        
//        // Checks if a user is offline, removes user from Firebase
//        usersRef.observe(.childRemoved, with: { snap in
//            guard let emailToFind = snap.value as? String else { return }
//            for (index, email) in self.allUsers.enumerated() {
//                if email == emailToFind {
//                    let indexPath = IndexPath(row: index, section: 0)
//                    self.allUsers.remove(at: index)
//                    self.tableView.deleteRows(at: [indexPath], with: .fade)
//                }
//            }
//        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewDidLoad()
    }
    
    func getAllUsers() {
        allUsersRef.observeSingleEvent(of: .value, with: { snapshot in
            if !snapshot.exists() { return }
            self.allUsers = []
            for user in snapshot.children.allObjects as! [DataSnapshot] {
                let userObject = user.value as? [String: AnyObject]
                let email = userObject?["email"] as! String
                let uid = userObject?["uid"] as! String
                let user = User(uid: uid, email: email)
                if self.userID != uid {
                    self.allUsers.append(user)
                }
                self.tableView.reloadData()
            }
        })
    }
    
    func getSearchedUsers() {
        viewedUsersRef.child(userID).queryOrdered(byChild: "timestamp").observeSingleEvent(of: .value, with: { snapshot in
            if !snapshot.exists() { return }
            self.viewedUsers = []
            for user in snapshot.children.allObjects as! [DataSnapshot] {
                let userObject = user.value as? [String: AnyObject]
                let email = userObject?["email"] as! String
                let uid = userObject?["uid"] as! String
                let user = User(uid: uid, email: email)
                self.viewedUsers.insert(user, at: 0)
                if self.viewedUsers.count > 3 {
                    self.viewedUsers.removeLast()
                }
                self.tableView.reloadData()
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return socialHeaders[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return socialHeaders.count
    }
    
    // UITableView Delegate methods
    // Returns amount of online users
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
    
    // Fills in cell with online user
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        let onlineUserEmail: String!
        
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchedUserID = allUsers[indexPath.row].uid
        let timestamp = ServerValue.timestamp()

        Database.database().reference().child("viewed-users").child(userID).child(searchedUserID).setValue([
            "email": allUsers[indexPath.row].email,
            "uid": searchedUserID,
            "timestamp": timestamp
            ])
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        } else {
            isSearching = true
            filteredUsers = allUsers.filter({$0.email.localizedCaseInsensitiveContains(searchBar.text!)})
            tableView.reloadData()
        }
    }
    
    @IBAction func logoutButtonPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UserSegue" {
            let detailsUsersTableViewController = segue.destination as! DetailsUsersTableViewController
            let index = tableView.indexPathForSelectedRow!.row
            if isSearching {
                detailsUsersTableViewController.user = filteredUsers[index]
            } else {
                detailsUsersTableViewController.user = allUsers[index]
            }
            
        }
    }
    
}
