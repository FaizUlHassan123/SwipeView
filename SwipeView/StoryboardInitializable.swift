//
//  File.swift
//  Hypescreen
//
//  Created by Faiz Ul Hassan on 12/16/21.
//


import Foundation
import UIKit

protocol StoryboardInitializable {
    static var storyboardIdentifier: String { get }
}

enum StoryBoard:String{
    case LaunchScreen,Main
}

extension StoryboardInitializable where Self: UIViewController {

    static var storyboardIdentifier: String {
        return String(describing: Self.self)
    }

    static func initFromStoryboard(name: StoryBoard) -> Self {
        let storyboard = UIStoryboard(name: String(name.rawValue), bundle: Bundle.main)
        if let controller = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as? Self {
            return controller
        }
        fatalError("Controller didn't initialized")
    }
}
