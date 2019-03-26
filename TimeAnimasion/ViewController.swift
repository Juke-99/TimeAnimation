//
//  ViewController.swift
//  TimeAnimasion
//
//  Created by 如月 二十日 on 2019/03/25.
//  Copyright © 2019 dreamseeker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let secondLayer = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let frame = view.frame
        let path = UIBezierPath()
        path.addArc(
            withCenter: CGPoint(x: frame.midX, y: frame.midY),
            radius: frame.width / 2.0 - 20.0,
            startAngle: CGFloat(-Double.pi / 2),
            endAngle: CGFloat(Double.pi * 1.5),
            clockwise: true
        )
        
        secondLayer.path = path.cgPath
        secondLayer.strokeColor = UIColor.black.cgColor
        secondLayer.fillColor = UIColor.clear.cgColor
        secondLayer.speed = 0.0
        
        view.layer.addSublayer(secondLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 60.0
        
        secondLayer.add(animation, forKey: "strokeCircle")
        
        let displayLink = CADisplayLink(target: self, selector: #selector(update(_:)))
        displayLink.preferredFramesPerSecond = 1
        displayLink.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
    }
    
    @objc func update(_ displayLink: CADisplayLink) {
        let time = Date().timeIntervalSince1970
        let seconds = time.truncatingRemainder(dividingBy: 60)
        //let seconds = time truncatingRemainder 60
        let milliseconds = time - floor(time)
        
        secondLayer.timeOffset = seconds + milliseconds
    }
}

