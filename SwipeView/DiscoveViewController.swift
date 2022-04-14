//
//  DiscoveViewController.swift
//  swipeView
//
//  Created by Faiz Ul Hassan on 3/24/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import Koloda
import AlamofireImage

private let frameAnimationSpringBounciness: CGFloat = 9
private let frameAnimationSpringSpeed: CGFloat = 16
private let kolodaCountOfVisibleCards = 2
private let kolodaAlphaValueSemiTransparent: CGFloat = 0.1

class DiscoverViewController: UIViewController, KolodaViewDataSource, KolodaViewDelegate , StoryboardInitializable{

    @IBOutlet var images_view: KolodaView!
    var user_id:String = ""
    var d_report_user_id:String = ""
    var d_report_user_name:String = ""
    var matchDATA: [matchData] = []
    var match_id:String = ""
    var param : [String:Any]!

    override func viewDidLoad() {
        super.viewDidLoad()
        images_view.alphaValueSemiTransparent = kolodaAlphaValueSemiTransparent
        images_view.countOfVisibleCards = kolodaCountOfVisibleCards
        images_view.delegate = self
        images_view.dataSource = self
        images_view.animator = BackgroundKolodaAnimator(koloda: images_view)

        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        self.get_matches()
    }

    @IBOutlet var like_btn: UIButton!
    @IBOutlet var unlike_button: UIButton!

    // MARK: IBActions

    @IBAction func unlineButtonTapped() {
        images_view.swipe(.left)
    }

    @IBAction func likeButtonTapped() {
        images_view.swipe(.right)
    }

    @IBAction func undoButtonTapped() {
        images_view.revertAction()
    }

    @objc func get_matches(){
        let d = matchData(age: "20", first_name: "Faiz", height: "Hassan", id: "1", last_name: "Faiz", lat: "lat", long: "long", location: "Siakot", looking_for: "Women", image_id: "2", image_url: "https://i.pinimg.com/originals/bf/81/5d/bf815d938ffb772dc37545e8b68ddac6.jpg")
        for _ in 0...100{
            self.matchDATA.append(d)
        }
        self.images_view.reloadData()
    }

    func setImages(direction: String){
        switch direction {
        case "left":
            let img = UIImage(named: "icon_unlike")
            //            self.logo.image = img!
        case "right":
            let img = UIImage(named: "icon_like")
            //            self.logo.image = img!
        case "down":
            let img = UIImage(named: "icon_down")
            //            self.logo.image = img!
        default:
            let img = UIImage(named: "icon_up")
            //            self.logo.image = img!
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            let img = UIImage(named: "icon_default")
            //            self.logo.image = img!
        }
    }

    func swipeRight(index:Int){
        //kill
        let match = matchDATA[index]
        print(#function,"\(match)")

    }

    func swipeLeft(index:Int){
        //kiss
        let match = matchDATA[index]
        print(#function,"\(match)")

    }

    func swipeBottom(index:Int){
        //marry
        print(#function)
    }

    func swipeUp(index:Int){
        let match = matchDATA[index]
        match_id = match.id
        print(#function)
    }

    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return matchDATA.count
    }

    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .moderate
    }
    

    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        koloda.delegate = self

        let match = matchDATA[index]
        let innerview = storyboard?.instantiateViewController(withIdentifier: "DiscoverView").view as! PhotoSwipeView

        innerview.dropShadow()
        if match.image_url != nil {

            let f_url = match.image_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let url = URL(string: f_url)
            innerview.image_view.af_setImage(withURL: url!)
            innerview.user_name.text = match.first_name + " " + match.last_name
            innerview.user_location.text = match.location
            innerview.user_age.text = match.age + " years"
            innerview.user_height.text = "Height: " + match.height
            innerview.looking_for.text = "Looking for: " + match.looking_for
            //            innerview.report_button.addTarget(self, action: #selector(report(_:)), for: .touchUpInside)

        }
        return innerview
    }

    @objc func report(_ sender:UIButton){
        let index  = sender.tag
        d_report_user_id  = matchDATA[index].id
        let a = matchDATA[index]
        d_report_user_name = a.first_name + " " + a.last_name
    }

    func koloda(_ koloda: KolodaView, allowedDirectionsForIndex index: Int) -> [SwipeResultDirection] {
        return [.left, .right, .up, .down]
    }

    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        print(direction.rawValue)
        switch direction.rawValue {
        case "right":
            self.swipeRight(index: index)
        case "left":
            self.swipeLeft(index: index)
        case "up":
            print("Up")
            self.swipeUp(index: index)
        case "down":
            self.swipeBottom(index: index)
        default:
            print("defaults")
        }
        self.setImages(direction: direction.rawValue)
    }

    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("CustomOverlayView", owner: self, options: nil)![0] as? CustomOverlayView
    }

    func koloda(_ koloda: KolodaView, draggedCardWithPercentage finishPercentage: CGFloat, in direction: SwipeResultDirection) {
        print("Pecent age \(finishPercentage) direction \(direction)")
    }

    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        let position = images_view.currentCardIndex
        let d = matchData(age: "20", first_name: "Faiz", height: "Hassan", id: "1", last_name: "Faiz", lat: "lat", long: "long", location: "Siakot", looking_for: "Women", image_id: "2", image_url: "https://i.pinimg.com/originals/bf/81/5d/bf815d938ffb772dc37545e8b68ddac6.jpg")
        for _ in 0...100{
            self.matchDATA.append(d)
        }
        images_view.insertCardAtIndexRange(position..<position + 4, animated: true)
    }

}

extension UIView {

    func dropShadow() {

        self.layer.cornerRadius = 16
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.clipsToBounds = true

    }
}
