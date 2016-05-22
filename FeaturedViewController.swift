//
//  File.swift
//  test
//
//  Created by Alexandros Stamatopoulos on 1/05/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

class FeaturedViewController: UIViewController {
    
    var pageViewController: CustomPageViewController!
    
           
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let vc = storyboard?.instantiateViewControllerWithIdentifier("CustomPageViewController"){
            self.addChildViewController(vc)
            self.view.addSubview(vc.view)
            
            pageViewController = vc as! CustomPageViewController
           
            
        }
        
        stylePageControl()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func stylePageControl() {
        let pageControl = UIPageControl.appearanceWhenContainedInInstancesOfClasses([self.dynamicType])
        
        pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
        pageControl.pageIndicatorTintColor = UIColor.grayColor()
        pageControl.backgroundColor = UIColor.whiteColor()
    }
    
}
