//
//  FriendsListController.swift
//  SwiftUIBase
//
//  Created by Владимир Поливников on 05.02.2021.
//

import UIKit

class FriendsListController: UITableViewController {

    var friends = [
        User(name: "Olga", surname: "Petrova", avatar: "female_avatar"),
        User(name: "Vladimir", surname: "Ivanov", avatar: "male_avatar"),
        User(name: "Alexey", surname: "Barkov", avatar: "male_avatar"),
        User(name: "Dmitriy", surname: "Stepanov", avatar: "male_avatar"),
        User(name: "Evgenia", surname: "Marchuk", avatar: "female_avatar"),
        User(name: "Viktoria", surname: "Klisheva", avatar: "female_avatar"),
        User(name: "Anna", surname: "Stepanova", avatar: "female_avatar")
    ]
    var filteredFriends = [User] ()
    
    var friendsSectionsTittles: [String] = [String]()
    var friendsInSections: [[User]] = [[User]]()
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.tableView.register(UINib(nibName: "FriendsListCell", bundle: nil), forCellReuseIdentifier: "friendsListCell")
        
        self.tableView.register(UINib(nibName: "FriendsListSectionHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "friendsListSectionHeader")
        
        friends.sort { $0 < $1 }
        parseFriendsToSections(source: self.friends)
        
        self.tableView.keyboardDismissMode = .onDrag
        
        let searchBar = UISearchBar(
            frame: CGRect(
                origin: .zero,
                size: CGSize(width: UIScreen.main.bounds.width, height: 44)
            )
        )
        searchBar.delegate = self
        self.tableView.tableHeaderView = searchBar
    }
    
    private func parseFriendsToSections(source: [User]) {
        
        //prepare for first section
        self.friendsSectionsTittles.removeAll()
        self.friendsInSections.removeAll()
        
        guard !source.isEmpty else { return }
        
        var currentSectionLetter = source[0].surname.prefix(1).uppercased()
        var currentSection = [User] ()
        
        //make sections
        for friend in source {
            let friendSurnameLetter = friend.surname.prefix(1).uppercased()
            
            if friendSurnameLetter == currentSectionLetter {
                currentSection.append(friend)
            } else {
                friendsSectionsTittles.append(currentSectionLetter)
                friendsInSections.append(currentSection)
                
                currentSectionLetter = friendSurnameLetter
                currentSection = [friend]
            }
        }
        
        //add last section if exists
        if friendsSectionsTittles.last != currentSectionLetter {
            friendsSectionsTittles.append(currentSectionLetter)
            friendsInSections.append(currentSection)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return friendsInSections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsInSections[section].count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "friendsListSectionHeader") as! FriendsListSectionHeader
        
        header.firstLetterOfSurnameLabel.text = friendsSectionsTittles[section]
        header.alpha = 0.5
        
        return header
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsListCell", for: indexPath) as! FriendsListCell

        let fullName = "\(friendsInSections[indexPath.section][indexPath.row].name) \(friendsInSections[indexPath.section][indexPath.row].surname)"
        cell.friendName.text = fullName
        cell.friendAvatar.imageView.image = UIImage(named: friendsInSections[indexPath.section][indexPath.row].avatar)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "friendController") as! FriendController
        vc.navigationItem.title = "\(friends[indexPath.row].name) \(friends[indexPath.row].surname)"
        self.navigationController?.pushViewController(vc, animated: true)
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FriendsListController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else {
            self.parseFriendsToSections(source: self.friends)
            self.tableView.reloadData()
            return
        }
        
        let lowercasedSearchText = searchText.lowercased()
        self.filteredFriends = self.friends.filter {
            $0.surname.lowercased().contains(lowercasedSearchText) || $0.name.lowercased().contains(lowercasedSearchText)
        }
        self.parseFriendsToSections(source: filteredFriends)
        self.tableView.reloadData()
    }
}
