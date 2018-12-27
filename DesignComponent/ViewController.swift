//
//  ViewController.swift
//  DesignComponent
//
//  Created by Admin on 27/12/18.
//  Copyright © 2018 VISHAL. All rights reserved.
//

import UIKit
//import PlayerKit
import AVKit
import ASPVideoPlayer
class ViewController: UIViewController {

    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    
    @IBOutlet weak var View1: UIView!
    @IBOutlet weak var View2: UIView!
    
    @IBOutlet weak var imageView1: UIImageView!
    
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var videoPlayerBackgroundView: UIView!
    @IBOutlet weak var videoPlayer: ASPVideoPlayer!
    
    let videoURL1 = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")
    let videoURL2 = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4")
    let videoURL3 = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4")
    let videoURL4 = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4")
    let videoURL5 = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4")
    let videoURL6 = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
    let videoURL7 = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4")
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.CallStoryDesign()
    }

    //MARK: Design Class
    func CallStoryDesign(){
        Utility.Button1(button: Button1)
        Utility.Button2(button: Button2)
        Utility.View1(view: View1)
        Utility.View2(view: View2)
        Utility.imageView1(imageView: imageView1)
        Utility.Label1(label: label1)
        Utility.View3(view: containerView)
        Utility.View3(view: videoPlayerBackgroundView)
        Utility.View3(view: videoPlayer)
        
        let firstAsset = AVURLAsset(url: videoURL1!)
        let secondAsset = AVURLAsset(url: videoURL2!)
        let thirdAsset = AVURLAsset(url: videoURL3!)
        let fourthAsset = AVURLAsset(url: videoURL4!)
        let fifthAsset = AVURLAsset(url: videoURL5!)
        
        videoPlayer.videoAssets = [firstAsset, secondAsset, thirdAsset, fourthAsset, fifthAsset]
        videoPlayer.resizeClosure = { [unowned self] isExpanded in
            self.rotate(isExpanded: isExpanded)
        }
        videoPlayer.delegate = self
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var previousConstraints: [NSLayoutConstraint] = []
    
    func rotate(isExpanded: Bool) {
        let views: [String:Any] = ["videoPlayer": videoPlayer,
                                   "backgroundView": videoPlayerBackgroundView]
        
        var constraints: [NSLayoutConstraint] = []
        
        if isExpanded == false {
            self.containerView.removeConstraints(self.videoPlayer.constraints)
            
            self.view.addSubview(self.videoPlayerBackgroundView)
            self.view.addSubview(self.videoPlayer)
            self.videoPlayer.frame = self.containerView.frame
            self.videoPlayerBackgroundView.frame = self.containerView.frame
            
            let padding = (self.view.bounds.height - self.view.bounds.width) / 2.0
            
            var bottomPadding: CGFloat = 0
            
            if #available(iOS 11.0, *) {
                if self.view.safeAreaInsets != .zero {
                    bottomPadding = self.view.safeAreaInsets.bottom
                }
            }
            
            let metrics: [String:Any] = ["padding":padding,
                                         "negativePaddingAdjusted":-(padding - bottomPadding),
                                         "negativePadding":-padding]
            
            constraints.append(contentsOf:
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-(negativePaddingAdjusted)-[videoPlayer]-(negativePaddingAdjusted)-|",
                                               options: [],
                                               metrics: metrics,
                                               views: views))
            constraints.append(contentsOf:
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(padding)-[videoPlayer]-(padding)-|",
                                               options: [],
                                               metrics: metrics,
                                               views: views))
            
            constraints.append(contentsOf:
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-(negativePadding)-[backgroundView]-(negativePadding)-|",
                                               options: [],
                                               metrics: metrics,
                                               views: views))
            constraints.append(contentsOf:
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(padding)-[backgroundView]-(padding)-|",
                                               options: [],
                                               metrics: metrics,
                                               views: views))
            
            self.view.addConstraints(constraints)
        } else {
            self.view.removeConstraints(self.previousConstraints)
            
            let targetVideoPlayerFrame = self.view.convert(self.videoPlayer.frame, to: self.containerView)
            let targetVideoPlayerBackgroundViewFrame = self.view.convert(self.videoPlayerBackgroundView.frame, to: self.containerView)
            
            self.containerView.addSubview(self.videoPlayerBackgroundView)
            self.containerView.addSubview(self.videoPlayer)
            
            self.videoPlayer.frame = targetVideoPlayerFrame
            self.videoPlayerBackgroundView.frame = targetVideoPlayerBackgroundViewFrame
            
            constraints.append(contentsOf:
                NSLayoutConstraint.constraints(withVisualFormat: "H:|[videoPlayer]|",
                                               options: [],
                                               metrics: nil,
                                               views: views))
            constraints.append(contentsOf:
                NSLayoutConstraint.constraints(withVisualFormat: "V:|[videoPlayer]|",
                                               options: [],
                                               metrics: nil,
                                               views: views))
            
            constraints.append(contentsOf:
                NSLayoutConstraint.constraints(withVisualFormat: "H:|[backgroundView]|",
                                               options: [],
                                               metrics: nil,
                                               views: views))
            constraints.append(contentsOf:
                NSLayoutConstraint.constraints(withVisualFormat: "V:|[backgroundView]|",
                                               options: [],
                                               metrics: nil,
                                               views: views))
            
            self.containerView.addConstraints(constraints)
        }
        
        self.previousConstraints = constraints
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [], animations: {
            self.videoPlayer.transform = isExpanded == true ? .identity : CGAffineTransform(rotationAngle: .pi / 2.0)
            self.videoPlayerBackgroundView.transform = isExpanded == true ? .identity : CGAffineTransform(rotationAngle: .pi / 2.0)
            
            self.view.layoutIfNeeded()
        })
    }
}
extension ViewController: ASPVideoPlayerViewDelegate {
    func startedVideo() {
        print("Started video")
    }
    
    func stoppedVideo() {
        print("Stopped video")
    }
    
    func newVideo() {
        print("New Video")
    }
    
    func readyToPlayVideo() {
        print("Ready to play video")
    }
    
    func playingVideo(progress: Double) {
        //        print("Playing: \(progress)")
    }
    
    func pausedVideo() {
        print("Paused Video")
    }
    
    func finishedVideo() {
        print("Finished Video")
    }
    
    func seekStarted() {
        print("Seek started")
    }
    
    func seekEnded() {
        print("Seek ended")
    }
    
    func error(error: Error) {
        print("Error: \(error)")
    }
    
    func willShowControls() {
        print("will show controls")
    }
    
    func didShowControls() {
        print("did show controls")
    }
    
    func willHideControls() {
        print("will hide controls")
    }
    
    func didHideControls() {
        print("did hide controls")
    }
}
