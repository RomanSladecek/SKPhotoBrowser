//
//  SKCaptionView.swift
//  SKPhotoBrowser
//
//  Created by suzuki_keishi  on 2015/10/07.
//  Copyright © 2015 suzuki_keishi. All rights reserved.
//



import UIKit

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}

private let bundle = Bundle(for: SKCaptionView.self)


open class SKCaptionView: UIView {
    var photo: SKPhotoProtocol?
    @IBOutlet weak var photoMapButton: UIButton!
    
    class func instanceFromNib() -> SKCaptionView {
        return UINib(nibName: "SKCaptionView", bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as! SKCaptionView
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupUI()
    }
    
    func setupUI() {
        if let mapURL = photo?.mapURL {
            let url = URL(string: mapURL)
            if let img = SKCache.sharedCache.imageForKey(mapURL) {
                self.photoMapButton.setImage(img, for: .normal)
            }
            else {
                let data = try? Data(contentsOf: url!)
                let img = UIImage(data: data!)
                SKCache.sharedCache.setImage(img!, forKey: mapURL)
                self.photoMapButton.setImage(img, for: .normal)
            }
            self.isHidden = true

//            DispatchQueue.global().async {
//                DispatchQueue.main.async {
//
//                }
//            }
        }
        else {
            self.isHidden = false
        }
    }
    
}


