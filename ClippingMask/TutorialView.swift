//
//  TutorialView.swift
//  ClippingMask
//  
//  Created by ji-no on R 4/06/05
//  
//

import UIKit

class TutorialView: UIView {

    var headerHeight: CGFloat = 0
    var masked: Bool = false
    var label: UILabel?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    func start(to toRect: CGRect) {
        startMaskAnimation(to: toRect)
    }

    func clear() {
        clearMaskAnimation()
    }

}

extension TutorialView {

    private func setUp() {
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        isUserInteractionEnabled = false
        isHidden = true
    }

    private func startMaskAnimation(to toRect: CGRect) {
        guard masked == false else { return }
        masked = true

        isHidden = false

        let fromPath = fromRectPath()
        let toPath = toRectPath(toRect)

        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.fillColor = UIColor.black.cgColor
        maskLayer.path = fromPath.cgPath
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        layer.mask = maskLayer

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
        
        let label = UILabel(frame: .zero)
        label.text = "↓ Tap here"
        label.sizeToFit()
        label.backgroundColor = UIColor.white
        label.frame.origin = .init(x: toRect.origin.x, y: toRect.origin.y - label.frame.height - 10)
        self.addSubview(label)
        self.label = label
    }

    private func clearMaskAnimation() {
        guard masked == true else { return }
        masked = false

        let toPath = fromRectPath()

        let maskLayer = layer.mask as! CAShapeLayer

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
        self.label?.removeFromSuperview()
        self.label = nil
    }

    private func fromRectPath() -> UIBezierPath {
        let outerRectanglePath = UIBezierPath(rect: layer.bounds)
        let headerPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: bounds.width, height: headerHeight))

        let fromRect = CGRect(x: 0, y: headerHeight, width: bounds.width, height: bounds.height - headerHeight)
        let path = UIBezierPath(roundedRect: fromRect, cornerRadius: 1)
        path.append(headerPath)
        path.append(outerRectanglePath)
        return path
    }

    private func toRectPath(_ toRect: CGRect) -> UIBezierPath {
        let outerRectanglePath = UIBezierPath(rect: layer.bounds)
        let headerPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: bounds.width, height: headerHeight))

        let path = UIBezierPath(roundedRect: toRect, cornerRadius: toRect.height/2)
        path.append(headerPath)
        path.append(outerRectanglePath)
        return path
    }

}
