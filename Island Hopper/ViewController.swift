//
//  ViewController.swift
//  Island Hopper
//
//  Created by James Hall on 12/24/17.
//

import UIKit
import AACarousel
import Kingfisher
import SafariServices

class ViewController: UIViewController {

    @IBOutlet weak var mainStackView: UIStackView!
    var titleArray = [String]()
    @IBOutlet weak var iHLogo: UIImageView!
    @IBOutlet weak var iHCarousel: AACarousel!
    @IBOutlet weak var artistsButton: UIButton!
    @IBOutlet weak var venuesButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        mainStackView.bringSubview(toFront: iHLogo)
    }
    
    @objc func artistsButtonPressed(_ sender: Any) {
        // Creates an SFSafariViewController object with 'Artists' page as destination
        let artistsSafariVC = SFSafariViewController(url: NSURL(string: "https://www.island-hopper.fortmyers-sanibel.com/artists")! as URL)
        
        //Causes the safariVC to present on screen
        self.present(artistsSafariVC, animated: true, completion: nil)
        
        artistsSafariVC.delegate = self
    }
    
    @objc func venuesButtonPressed(_ sender: Any) {
        print("DERP")
        // Creates an SFSafariViewController object with 'Artists' page as destination
        let venuesSafariVC = SFSafariViewController(url: NSURL(string: "https://www.island-hopper.fortmyers-sanibel.com/2017-venues")! as URL)
        
        //Causes the safariVC to present on screen
        self.present(venuesSafariVC, animated: true, completion: nil)
        
        venuesSafariVC.delegate = self
    }
}

extension ViewController {
    
    func setupViews(){
        artistsButton.setBackgroundImage(UIImage(named:"Artists"), for: .normal)
        artistsButton.layer.shadowOffset = CGSize(width: 15, height: 15)
        artistsButton.layer.shadowColor = UIColor.black.cgColor
        artistsButton.layer.shadowOpacity = 1
        artistsButton.layer.shadowOffset = CGSize.zero
        artistsButton.addTarget(self, action: #selector(artistsButtonPressed), for: UIControlEvents.touchUpInside)
        
        venuesButton.setBackgroundImage(UIImage(named:"Venues"), for: .normal)
        venuesButton.layer.shadowOffset = CGSize(width: 15, height: 15)
        venuesButton.layer.shadowColor = UIColor.black.cgColor
        venuesButton.layer.shadowOpacity = 1
        venuesButton.layer.shadowOffset = CGSize.zero
        
        venuesButton.addTarget(self, action: #selector(venuesButtonPressed), for: UIControlEvents.touchUpInside)
//        venuesButton.addTarget(self, action: Selector("venuesButtonPressed"), for: UIControlEvents.touchUpInside)
        
//        self
//        action:@selector(myAction)
//        forControlEvents:UIControlEventTouchUpInside
        
        iHLogo.image = UIImage(named: "IH")
        iHLogo.contentMode = .scaleAspectFit
        iHLogo.clipsToBounds = true
        iHLogo.layer.shadowOffset = CGSize(width: 15, height: 15)
        iHLogo.layer.shadowColor = UIColor.black.cgColor
        iHLogo.layer.shadowOpacity = 1
        iHLogo.layer.shadowOffset = CGSize.zero
        
        setupCarousel()
        
//        setupConstraints()
    }
 
    func setupConstraints(){
        
        //Constraints for iHLogo
        iHLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        iHLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        
        iHCarousel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        iHCarousel.topAnchor.constraint(equalTo: iHLogo.bottomAnchor, constant: 10).isActive = true
        
        artistsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        artistsButton.topAnchor.constraint(equalTo: iHCarousel.bottomAnchor, constant: 10).isActive = true
        artistsButton.widthAnchor.constraint(equalToConstant: 85).isActive = true
        
        artistsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        artistsButton.topAnchor.constraint(equalTo: artistsButton.bottomAnchor, constant: 10).isActive = true
        artistsButton.widthAnchor.constraint(equalToConstant: 85).isActive = true
        
        backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: iHCarousel.bottomAnchor)
//        backgroundView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1)
    }
}

extension ViewController: AACarouselDelegate {
    
    func setupCarousel(){
        
        let pathArray = ["https://www.fortmyers-sanibel.com/media/28291/girl-near-pier_640x380.jpg?anchor=center&mode=crop&width=534&height=332&rnd=131480610670000000",
                         "https://pbs.twimg.com/media/DOxKzwmVAAEJvH5.jpg"]
        
        titleArray = ["Girl Near Pier","Artist Performing"]
        
        iHCarousel.delegate = self
        
        iHCarousel.setCarouselData(paths: pathArray,  describedTitle: titleArray, isAutoScroll: true, timer: 5.0, defaultImage: "defaultImage")
        
        //optional methods
        iHCarousel.setCarouselOpaque(layer: false, describedTitle: false, pageIndicator: false)
        
        iHCarousel.setCarouselLayout(displayStyle: 0, pageIndicatorPositon: 5, pageIndicatorColor: nil, describedTitleColor: nil, layerColor: nil)
        
        iHCarousel.layer.shadowOffset = CGSize(width: 15, height: 15)
        iHCarousel.layer.shadowColor = UIColor.black.cgColor
        iHCarousel.layer.shadowOpacity = 1
        iHCarousel.layer.shadowOffset = CGSize.zero
        
    }
    
    func didSelectCarouselView(_ view: AACarousel, _ index: Int) {
        
    }
    
    func downloadImages(_ url: String, _ index: Int) {
        
        let imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: url)!, placeholder: UIImage.init(named: "defaultImage"), options: [.transition(.fade(0))], progressBlock: nil, completionHandler: { (downloadImage, error, cacheType, url) in
            self.iHCarousel.images[index] = downloadImage!
        })
    }
    
    //optional method (show first image faster during downloading of all images)
    func callBackFirstDisplayView(_ imageView: UIImageView, _ url: [String], _ index: Int) {
        
        imageView.kf.setImage(with: URL(string: url[index]), placeholder: UIImage.init(named: "defaultImage"), options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
        
    }
    
    func startAutoScroll() {
        //optional method
        iHCarousel.startScrollImageView()
    }
    
    func stopAutoScroll() {
        //optional method
        iHCarousel.stopScrollImageView()
    }
}

extension ViewController: SFSafariViewControllerDelegate {
    
    // Ensures that the View Controller conforms SFSafariViewDelagate interface
    func safariViewControllerDidFinish(_ controller: SFSafariViewController){
        controller.dismiss(animated: true, completion: nil)
    }
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...){
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
