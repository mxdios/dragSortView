//
//  DragSort.swift
//  dragSortView
//
//  Created by 苗晓东 on 2017/2/25.
//  Copyright © 2017年 markmiao. All rights reserved.
//

import UIKit

class DragSort: UIView {
    
    let list:CGFloat = 4
    let gap:CGFloat = 10
    var startPoint:CGPoint!
    var btnCenter:CGPoint!
    var btnArray:Array<Any>!
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        let btnWidth:CGFloat = (frame.width - (list + 1) * gap) / list
        let btnHeight:CGFloat = 50
        btnArray = Array()
        
        for item in 0..<20 {
            let x = CGFloat(item % Int(list)) * (btnWidth + gap) + gap
            let y = CGFloat(item / Int(list)) * (btnHeight + gap) + gap
            let btn = UIButton(frame: CGRect(x: x, y: y, width: btnWidth, height: btnHeight))
            btn.tag = item
            btn.setTitle("\(item)", for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btn.setTitleColor(UIColor.white, for: .normal)
            btn.backgroundColor = UIColor.red
            btn.layer.cornerRadius = 5
            let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressClick(longGes:)))
            btn.addGestureRecognizer(longPress)
            self.addSubview(btn)
            btnArray.append(btn)
        }
    }
    func longPressClick(longGes: UIGestureRecognizer) {
        let btnInn:UIButton = longGes.view as! UIButton
        let transform = CGAffineTransform.identity
        
        self.bringSubview(toFront: btnInn)
        if longGes.state == .began {
            UIView.animate(withDuration: 0.2, animations: {
                btnInn.transform = transform.scaledBy(x: 1.2, y: 1.2);
                btnInn.alpha = 0.7
            })
            startPoint = longGes.location(in: btnInn)
            btnCenter = btnInn.center
        }
        
        if longGes.state == .changed {
            let newPoint = longGes.location(in: btnInn)
            let changeX = min(max(btnInn.center.x + newPoint.x - startPoint.x, btnInn.frame.size.width / 2), self.frame.size.width - btnInn.frame.size.width / 2)
            let changeY = min(max(btnInn.center.y + newPoint.y - startPoint.y, btnInn.frame.size.height / 2), self.frame.size.height - btnInn.frame.size.height / 2)
            btnInn.center = CGPoint(x: changeX, y: changeY)
            
            let formIndex = btnInn.tag
            let toIndex = getMovedTargetIndex(btnTargetInn: btnInn)
            
            if toIndex < 0 {
                return
            } else {
                btnInn.tag = toIndex;
                
                if formIndex < toIndex {
                    for index in formIndex..<toIndex {
                        let btnInn:UIButton = btnArray[index + 1] as! UIButton
                        let oldCen = btnInn.center
                        UIView.animate(withDuration: 0.3, animations: {
                            btnInn.center = self.btnCenter
                        })
                        btnCenter = oldCen
                        btnInn.tag = index
                    }
                    
                } else if formIndex > toIndex {
                    for index in (toIndex + 1...formIndex).reversed() {
                        
                        let btnInn:UIButton = btnArray[index - 1] as! UIButton
                        let oldCen = btnInn.center
                        UIView.animate(withDuration: 0.3, animations: {
                            btnInn.center = self.btnCenter
                        })
                        btnCenter = oldCen
                        btnInn.tag = index
                    }
                }
                btnArray.sort(by: {($0 as! UIButton).tag < ($1 as! UIButton).tag})
            }
        }
        if longGes.state == .ended {
            UIView.animate(withDuration: 0.2, animations: {
                btnInn.transform = transform.inverted()
                btnInn.alpha = 1.0
                btnInn.center = self.btnCenter
            })
        }
    }
    func getMovedTargetIndex(btnTargetInn: UIButton) -> Int {
        for item in btnArray {
            let button = item as! UIButton
            if button.tag != btnTargetInn.tag && button.frame.contains(btnTargetInn.center) {
                return button.tag
            }
        }
        return -1
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
