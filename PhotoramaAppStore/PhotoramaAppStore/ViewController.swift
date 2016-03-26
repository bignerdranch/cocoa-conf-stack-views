//
//  ViewController.swift
//  PhotoramaAppStore
//
//  Copyright © 2016 Big Nerd Ranch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var screenshotStackView: UIStackView!
    @IBOutlet var screenshotView: UIView!
    @IBOutlet var descriptionView: UIView!
    @IBOutlet var outerStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let count = screenshotStackView.arrangedSubviews.count
        pageControl.numberOfPages = count
    }
    
    @IBAction func buyApp(sender: UIButton) {
        UIView.animateWithDuration(0.5) { () -> Void in
            sender.hidden = true
        }
        
        let ac = UIAlertController(title: "Thanks!", message: "Hope you enjoy. :)", preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: nil))
        
        presentViewController(ac, animated: true, completion: nil)
    }
    
    @IBAction func segmentChanged(sender: UISegmentedControl) {
        enum Segment: Int {
            case Screenshots
            case Slider
        }
        
        guard let segment = Segment(rawValue: sender.selectedSegmentIndex) else { return }
        
        switch segment {
        case .Screenshots:
            guard let index = outerStackView.arrangedSubviews.indexOf(descriptionView) else { return }
            descriptionView.removeFromSuperview()
            outerStackView.insertArrangedSubview(screenshotView, atIndex: index)
        case .Slider:
            guard let index = outerStackView.arrangedSubviews.indexOf(screenshotView) else { return }
            screenshotView.removeFromSuperview()
            outerStackView.insertArrangedSubview(descriptionView, atIndex: index)
        }
    }
    
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        updatePageControl(scrollView)
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate == false {
            updatePageControl(scrollView)
        }
    }
    
    func updatePageControl(scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.bounds.width
        pageControl.currentPage = Int(pageNumber)
    }
}
