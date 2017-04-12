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
    @IBOutlet weak var btnMap: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblYear: UILabel!

    weak var browser: SKPhotoBrowser?
    
    class func instanceFromNib() -> SKToolbar {
        return UINib(nibName: "SKToolbar", bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as! SKToolbar
    }
    
    func updateToolbar(_ currentPageIndex: Int) {
        guard let browser = browser else { return }
        let photo = browser.photoAtIndex(currentPageIndex)
        self.lblStatus.text = "\(photo.caption!)"
        
        // map
        if let mapURL = photo.mapURL {
            let url = URL(string: mapURL)
            if let img = SKCache.sharedCache.imageForKey(mapURL) {
                self.btnMap.setImage(img, for: .normal)
            }
            else {
                let data = try? Data(contentsOf: url!)
                let img = UIImage(data: data!)
                SKCache.sharedCache.setImage(img!, forKey: mapURL)
                self.btnMap.setImage(img, for: .normal)
            }
            self.btnMap.isHidden = false
            
            //            DispatchQueue.global().async {
            //                DispatchQueue.main.async {
            //
            //                }
            //            }
        }
        else {
            self.btnMap.isHidden = true
        }
    }
    
    @IBAction func btnMoreActionsPressed(_ sender: UIButton) {
        self.browser?.actionButtonPressed()
    }
    
    @IBAction func btnMapPressed(_ sender: UIButton) {
        self.browser?.mapButtonPressed()
    }
}
