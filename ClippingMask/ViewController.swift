//
//  ViewController.swift
//  
//  
//  Created by ji-no on R 4/05/27
//  
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var toView: UIView!
    
    let headerHeight: CGFloat = 70
    var masked: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @IBAction func onTappedStart(_ sender: Any) {
        startMaskAnimation(in: view, to: toView.frame)
    }

    @IBAction func onTappedClear(_ sender: Any) {
        clearMaskAnimation(in: view)
    }

    func startMaskAnimation(in view: UIView, to toRect: CGRect) {
        guard masked == false else { return }
        masked = true
        
        let headerPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: view.bounds.width, height: headerHeight))
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds
        maskLayer.fillColor = UIColor.black.cgColor
        let fromRect = CGRect(x: 0, y: headerHeight, width: view.bounds.width, height: view.bounds.height - headerHeight)
        let fromPath = UIBezierPath(roundedRect: fromRect, cornerRadius: 1)
        fromPath.append(headerPath)
        maskLayer.path = fromPath.cgPath
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        view.layer.mask = maskLayer

        let toPath = UIBezierPath(roundedRect: toRect, cornerRadius: toRect.height/2)
        toPath.append(headerPath)

        let anim = CABasicAnimation(keyPath: "path")
        anim.fromValue = maskLayer.path
        anim.toValue = toPath.cgPath
        anim.duration = 0.2
        anim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)

        maskLayer.add(anim, forKey: nil)

        CATransaction.begin()
        CATransaction.setDisableActions(true)
        CATransaction.setCompletionBlock({
            maskLayer.path = toPath.cgPath
            maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        })
        CATransaction.commit()
    }

    func clearMaskAnimation(in view: UIView) {
        guard masked == true else { return }
        masked = false

        let headerPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: view.bounds.width, height: headerHeight))

        let maskLayer = view.layer.mask as! CAShapeLayer

        let toRect = CGRect(x: 0, y: headerHeight, width: view.bounds.width, height: view.bounds.height - headerHeight)
        let toPath = UIBezierPath(roundedRect: toRect, cornerRadius: 1)
        toPath.append(headerPath)

        let anim = CABasicAnimation(keyPath: "path")
        anim.fromValue = maskLayer.path
        anim.toValue = toPath.cgPath
        anim.duration = 0.2
        anim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)

        maskLayer.add(anim, forKey: nil)

        CATransaction.begin()
        CATransaction.setDisableActions(true)
        CATransaction.setCompletionBlock({
            maskLayer.path = UIBezierPath(roundedRect: view.bounds, cornerRadius: 0).cgPath
            maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        })
        CATransaction.commit()

    }

}
