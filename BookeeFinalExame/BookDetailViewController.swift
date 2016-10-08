//
//  BookDetailViewController.swift
//  BookeeFinalExame
//
//  Created by ycliang on 2016/10/7.
//  Copyright © 2016年 Alex Liang. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var shopAddrLabel: UILabel!
    
    @IBOutlet weak var shopPhoneNumLabel: UILabel!
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        coverImageView.image = UIImage(named: (book?.imageName)!)
        bookNameLabel.text = book?.name
        shopAddrLabel.text = "書局地址: \((book?.shopAddress)!)"
        shopPhoneNumLabel.text = "書局電話: \((book?.shopPhoneNum)!)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let identifier = segue.identifier!
        switch identifier {
        case "showBookCoverDetail":
            let vc = segue.destinationViewController as! BookCoverViewController
            vc.image = UIImage(named: (book?.imageName)!)
        case "showShopMap":
            let vc = segue.destinationViewController as! ShopMapViewController
            vc.address = book?.shopAddress
            vc.shopName = bookNameLabel.text
        default:
            break
        }
    }
    
    @IBAction func shopPhoneNumTap(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "tel://\((book?.shopPhoneNum)!)")!, options: [:], completionHandler: nil)
    }
}
