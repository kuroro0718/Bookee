//
//  CreateBookTableViewController.swift
//  BookeeFinalExame
//
//  Created by ycliang on 2016/10/7.
//  Copyright © 2016年 Alex Liang. All rights reserved.
//

import UIKit
import Firebase

class CreateBookTableViewController: UITableViewController {

    @IBOutlet weak var bookNameTextField: UITextField!    
    @IBOutlet weak var bookCoverTextField: UITextField!
    @IBOutlet weak var shopAddrTextField: UITextField!
    @IBOutlet weak var shopWebSiteTextField: UITextField!
    @IBOutlet weak var shopPhoneNumTextField: UITextField!
    @IBOutlet weak var bookIntroTextField: UITextField!
    
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addBookButtonPressed(sender: AnyObject) {
        let name = bookNameTextField.text
        let address = shopAddrTextField.text
        let phoneNum = Int(shopPhoneNumTextField.text!)
        let webSite = shopWebSiteTextField.text
        let intro = bookIntroTextField.text
        let image = bookCoverTextField.text
        
        book = Book(name: name!, shopAddress: address!, shopPhoneNum: phoneNum!, shopWebSite: webSite!, introduction: intro!, imageName: image!)
        
        uploadBookInfoToFirebase()
        self.navigationController?.popViewControllerAnimated(true)
    }

    func uploadBookInfoToFirebase() {
        let rootRef = FIRDatabase.database().reference()
        let bookRef = rootRef.child("Book")
        
        if let newBook = book {
            let autoRef = bookRef.childByAutoId()
            let detailRef = autoRef.child(newBook.name!)
            
            detailRef.child("書本介紹").setValue(newBook.introduction!)
            detailRef.child("書本介紹").setValue(newBook.imageName!)
            detailRef.child("書局地址").setValue(newBook.shopAddress!)
            detailRef.child("書局電話").setValue(newBook.shopPhoneNum)
            detailRef.child("書局網站").setValue(newBook.shopWebSite!)
        }
    }
}
