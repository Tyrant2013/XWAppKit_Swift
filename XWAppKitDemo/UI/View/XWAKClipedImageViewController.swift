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
//        let clipedView = XWAKImageClipedView(frame: view.bounds)
//        clipedView.backgroundColor = .orange
//
//        let contentFrame = CGRect(x: 20, y: 100, width: view.bounds.width - 40, height: view.bounds.height - 200)
////        let contentFrame = view.bounds
//        let img = UIImage(named: "bcd")!
//        let imageView = UIImageView(image: img)
//        imageView.frame = contentFrame
//        imageView.layer.borderWidth = 1
//        imageView.layer.borderColor = UIColor.white.cgColor
//        clipedView.contentView = imageView
//        clipedView.contentSize = contentFrame.size
//        clipedView.contentOffset = -contentFrame.origin
//        clipedView.tag = 1111
//        clipedView.setupClip(contentFrame)
//        view.addSubview(clipedView)
        
        let clipedView = XWAKImageCropView()
        clipedView.image = UIImage(named: "bcd")
        clipedView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(clipedView)
        clipedView.xwak.edge(equalTo: view.safeAreaLayoutGuide.xwak, inset: 0, edges: [.all])
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
