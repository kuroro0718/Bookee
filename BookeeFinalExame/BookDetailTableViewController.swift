//
//  BookDetailTableViewController.swift
//  BookeeFinalExame
//
//  Created by ycliang on 2016/10/7.
//  Copyright © 2016年 Alex Liang. All rights reserved.
//

import UIKit

class BookDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var bookNameLabel: UILabel!    
    @IBOutlet weak var bookCoverImage: UIImageView!
    @IBOutlet weak var shopAddrLabel: UILabel!
    @IBOutlet weak var shopPhoneLabel: UILabel!
    @IBOutlet weak var shopWebSiteLabel: UILabel!
    
    @IBOutlet weak var bookIntroLabel: UILabel!
    
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookNameLabel.text = book?.name
        bookCoverImage.image = UIImage(named: (book?.imageName)!)
        shopAddrLabel.text = "書局地址: \((book?.shopAddress)!)"
        shopPhoneLabel.text = "書局電話: \((book?.shopPhoneNum)!)"
        shopWebSiteLabel.text = "書局網站: \((book?.shopWebSite)!)"
        bookIntroLabel.text = "簡介: \((book?.introduction)!)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
}
