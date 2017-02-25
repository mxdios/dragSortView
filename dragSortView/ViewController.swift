//
//  ViewController.swift
//  dragSortView
//
//  Created by 苗晓东 on 2017/2/25.
//  Copyright © 2017年 markmiao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let dragsort = DragSort(frame: CGRect(x: 20, y: 20, width: self.view.frame.size.width - 40, height: self.view.frame.size.height - 40))
        dragsort.backgroundColor = UIColor.orange
        self.view.addSubview(dragsort)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

