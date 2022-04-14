//
//  ExampleOverlayView.swift
//  swipeView
//
//  Created by Faiz Ul Hassan on 3/24/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import Koloda

private let overlayRightImageName = "yesOverlayImage"
private let overlayLeftImageName = "noOverlayImage"

class ExampleOverlayView: OverlayView {
    
    @IBOutlet var overlayImageView: UIImageView!

    override var overlayState: SwipeResultDirection? {
        didSet {
            switch overlayState {
            case .left? :
                overlayImageView.image = UIImage(named: overlayLeftImageName)
            case .right? :
                overlayImageView.image = UIImage(named: overlayRightImageName)
            default:
                overlayImageView.image = nil
            }
        }
    }

}
