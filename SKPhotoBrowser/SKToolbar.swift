//
//  SKToolbar.swift
//  SKPhotoBrowser
//
//  Created by 鈴木 啓司 on 2016/08/12.
//  Copyright © 2016年 suzuki_keishi. All rights reserved.
//

import Foundation

// helpers which often used
private let bundle = Bundle(for: SKPhotoBrowser.self)

class SKToolbar: UIView {
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var btnMoreActions: UIButton!
    
    weak var browser: SKPhotoBrowser?
    
    class func instanceFromNib() -> SKToolbar {
        return UINib(nibName: "SKToolbar", bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as! SKToolbar
    }
    
    func updateToolbar(_ currentPageIndex: Int) {
        guard let browser = browser else { return }
        self.lblStatus.text = "\(browser.photoAtIndex(currentPageIndex).caption!)"
    }
    
    @IBAction func btnMoreActionsPressed(_ sender: UIButton) {
        self.browser?.actionButtonPressed()
    }
}
