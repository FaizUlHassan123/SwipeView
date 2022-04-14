//
//  CustomOverlayView.swift
//  swipeView
//
//  Created by Faiz Ul Hassan on 3/24/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import Koloda

private let overlayRightImageName = "overlay_like"
private let overlayLeftImageName = "overlay_skip"

class CustomOverlayView: OverlayView {

    @IBOutlet weak var overlayImageView: UIImageView?
    
    override var overlayState: SwipeResultDirection?  {
        didSet {
            for (_,single) in subviews.enumerated(){
                if let check = single as? UIImageView{

                }else{
                    single.removeFromSuperview()
                }
            }
            print("direction \(String(describing: overlayState?.rawValue))")
            switch overlayState {
            case .left :
                createLeftOverlay()
            case .right :
                createRightOverlay()
            default:
                print("defult")
            }
            
        }
    }


    private func createLeftOverlay() {

        let leftTextView = TinderCardOverlayLabelView(withTitle: "NOPE",
                                                      color: .sampleRed,
                                                      rotation: CGFloat.pi / 10)
        addSubview(leftTextView)
        leftTextView.anchor(top: topAnchor,
                            right: rightAnchor,
                            paddingTop: 30,
                            paddingRight: 14)
    }

    private func createRightOverlay() {
        let rightTextView = TinderCardOverlayLabelView(withTitle: "LIKE",
                                                       color: .sampleGreen,
                                                       rotation: -CGFloat.pi / 10)
        addSubview(rightTextView)
        rightTextView.anchor(top: topAnchor,
                             left: leftAnchor,
                             paddingTop: 26,
                             paddingLeft: 14)
    }

}

private class TinderCardOverlayLabelView: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = nil
        return label
    }()

    init(withTitle title: String, color: UIColor, rotation: CGFloat) {
        super.init(frame: CGRect.zero)
        layer.borderColor = color.cgColor
        layer.borderWidth = 4
        layer.cornerRadius = 4
        transform = CGAffineTransform(rotationAngle: rotation)

        addSubview(titleLabel)
        titleLabel.textColor = color
        titleLabel.attributedText = NSAttributedString(string: title,
                                                       attributes: NSAttributedString.Key.overlayAttributes)
        titleLabel.anchor(top: topAnchor,
                          left: leftAnchor,
                          bottom: bottomAnchor,
                          right: rightAnchor,
                          paddingLeft: 8,
                          paddingRight: 3)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}

extension NSAttributedString.Key {

    static var overlayAttributes: [NSAttributedString.Key: Any] = [
        // swiftlint:disable:next force_unwrapping
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 42)!,
        NSAttributedString.Key.kern: 5.0
    ]
}

extension UIColor {
    static var sampleRed = UIColor(red: 252 / 255, green: 70 / 255, blue: 93 / 255, alpha: 1)
    static var sampleGreen = UIColor(red: 49 / 255, green: 193 / 255, blue: 109 / 255, alpha: 1)
    static var sampleBlue = UIColor(red: 52 / 255, green: 154 / 255, blue: 254 / 255, alpha: 1)
}

import UIKit

extension UIView {

    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat = 0,
                height: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false

        var anchors = [NSLayoutConstraint]()

        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: paddingTop))
        }
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: paddingLeft))
        }
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom))
        }
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -paddingRight))
        }
        if width > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: width))
        }
        if height > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: height))
        }

        anchors.forEach { $0.isActive = true }

        return anchors
    }

    @discardableResult
    func anchorToSuperview() -> [NSLayoutConstraint] {
        return anchor(top: superview?.topAnchor,
                      left: superview?.leftAnchor,
                      bottom: superview?.bottomAnchor,
                      right: superview?.rightAnchor)
    }
}

extension UIView {

    func applyShadow(radius: CGFloat,
                     opacity: Float,
                     offset: CGSize,
                     color: UIColor = .black) {
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
    }
}
