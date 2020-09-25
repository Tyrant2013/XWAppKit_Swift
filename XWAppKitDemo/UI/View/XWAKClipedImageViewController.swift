//
//  XWAKClipedImageViewController.swift
//  XWAppKitDemo
//
//  Created by ZHXW on 2020/9/25.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import XWAppKit_Swift

class XWAKClipedImageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        let clipedView = XWAKImageClipedView(frame: view.bounds)
        clipedView.backgroundColor = .orange
        
        let img = UIImage(named: "scheme")!
        let imageView = UIImageView(image: img)
        clipedView.contentView = imageView
        clipedView.contentSize = img.size
        clipedView.contentOffset = CGPoint(x: (img.size.width - view.bounds.width) / 2, y: (img.size.height - view.bounds.height) / 2)
        view.addSubview(clipedView)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
