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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FIRApp.configure()
        initBooks()
//        loadDataFromFirebase()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
//    func loadDataFromFirebase() {
//        let rootRef = FIRDatabase.database().reference()
//        
//        rootRef.child("Book").observeEventType(.Value, withBlock: {
//            (snapshot) in
//            let dict = snapshot.value
//            print(dict)
//        })
//
//    }
    
    func initBooks() {
        let book1 = Book(name: "莊子", shopAddress: "台北市松山區復興南路一段39號", shopPhoneNum: 26535588, shopWebSite: "http://www.books.com.tw/products/0010730704?loc=P_003_1_002", introduction: "身心的安定，是面對混亂的時代最有力量的武器，以淺顯的語言，契合現代生活的事例，解讀莊子的治身心之道", imageName: "chung")
     
        let book2 = Book(name: "地獄", shopAddress: "台北市中山區復興北路386號", shopPhoneNum: 24535588, shopWebSite: "http://www.kingstone.com.tw/book/book_page.asp?kmcode=2018740788520&lid=book-index-newbook-first&actid=bookindex", introduction: "地獄最黑暗的地方，保留給那些在道德存亡之際袖手旁觀的人。", imageName: "hell")
        
        let book3 = Book(name: "這樣吃，體能回到20歲", shopAddress: "台北市大安區敦化南路一段245號", shopPhoneNum: 26535587, shopWebSite: "http://www.kingstone.com.tw/book/book_page.asp?kmcode=2014110747692&lid=book-class-newbook-first&actid=vertical", introduction: "現在的我，一動就累，連出門抓個寶可夢也氣喘吁吁，怎麼辦？", imageName: "health")
        
        let book4 = Book(name: "大地療癒力", shopAddress: "台北市大安區敦化南路一段245號", shopPhoneNum: 26535688, shopWebSite: "http://www.kingstone.com.tw/book/book_page.asp?kmcode=2014110748774&lid=book-class-newbook-first&actid=vertical", introduction: "大地是孩子最好的醫生！拒絕各種慢性病、文明病、遺傳病，就從讓孩子「吃對」食物開始！", imageName: "ground")
        
        let book5 = Book(name: "弘一大師的超脫之學", shopAddress: "台北市大安區敦化南路一段245號", shopPhoneNum: 26235688, shopWebSite: "http://www.kingstone.com.tw/book/book_page.asp?kmcode=2012250136703&lid=book-class-newbook-first&actid=vertical", introduction: "弘一法師 - 李叔同:「長亭外，古道邊，芳草碧連天」", imageName: "master")
        
        books.append(book1)
        books.append(book2)
        books.append(book3)
        books.append(book4)
        books.append(book5)
    }
    
    func uploadBookInfoToFirebase() {
        let rootRef = FIRDatabase.database().reference()
        let bookRef = rootRef.child("Book")
                
        for book in books {
            let autoRef = bookRef.childByAutoId()
            let detailRef = autoRef.child(book.name!)
            
            detailRef.child("書本介紹").setValue(book.introduction!)
            detailRef.child("書本介紹").setValue(book.imageName!)
            detailRef.child("書局地址").setValue(book.shopAddress!)
            detailRef.child("書局電話").setValue(book.shopPhoneNum)
            detailRef.child("書局網站").setValue(book.shopWebSite!)
        }
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
            books.removeAtIndex(indexPath.row)            
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            tableView.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showBookDetail" {
            let vc = segue.destinationViewController as! BookDetailTableViewController
            if let cell = sender as? UITableViewCell, let indexPath = bookTableView.indexPathForCell(cell) {
                vc.book = books[indexPath.row]
            }
        }
    }
}
