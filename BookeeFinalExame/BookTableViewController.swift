//
//  BookTableViewController.swift
//  BookeeFinalExame
//
//  Created by ycliang on 2016/10/7.
//  Copyright © 2016年 Alex Liang. All rights reserved.
//

import UIKit
import Firebase

class BookTableViewController: UITableViewController {
    @IBOutlet var bookTableView: UITableView!
    
    var books = [Book]()
    var rootRef: FIRDatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FIRApp.configure()
        rootRef = FIRDatabase.database().reference()
        loadDataFromFirebase()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    func loadDataFromFirebase() {
        let bookRef = self.rootRef!.child("Book")
        bookRef.observeSingleEventOfType(.Value, withBlock:  {
            (snapshot) in
            let bookDict = snapshot.value as! [String: AnyObject]
            for (bookName, bookData) in bookDict {
                let address = bookData["shop address"]! as! String
                let phoneNum = bookData["shop phone"]! as! Int
                let shopWebsite = bookData["shop website"]! as! String
                let introduction = bookData["introduction"]! as! String
                let imageName = bookData["cover"]! as! String
                
                let book = Book(name: bookName, shopAddress: address, shopPhoneNum: phoneNum, shopWebSite: shopWebsite, introduction: introduction, imageName: imageName)
                
                self.books.append(book)
                self.tableView.reloadData()
            }
        })
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BookCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = books[indexPath.row].name
        cell.imageView?.image = UIImage(named: books[indexPath.row].imageName!)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let removedBook = books.removeAtIndex(indexPath.row)
            
            // Remove Firebase data
            rootRef?.child("Book").child(removedBook.name!).removeValueWithCompletionBlock({ (error, ref) in
                if error != nil {
                    print("Failed to remove data", error)
                    return
                }
            })
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            tableView.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showBookDetail" {
            let vc = segue.destinationViewController as! BookDetailViewController
            if let cell = sender as? UITableViewCell, let indexPath = bookTableView.indexPathForCell(cell) {
                vc.book = books[indexPath.row]
            }
        } else if segue.identifier == "addNewBookIdentifier" {
            let vc = segue.destinationViewController as! CreateBookTableViewController
            vc.delegate = self
        }
    }
}

extension BookTableViewController: CreateBookDataDelegate {
    func addBook(book: Book) {
        self.books.insert(book, atIndex: 0)
    }
}
