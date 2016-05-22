//
//  CustomPageViewController.swift
//  test
//
//  Created by Alexandros Stamatopoulos on 2/05/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

class CustomPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    
    let pages = ["FirstViewController", "SecondViewController", "ThirdViewController"]
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if let index = pages.indexOf(viewController.restorationIdentifier!){
            if index < pages.count-1
            {
                return viewControllerAtIndex(index+1)
            }
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if let index = pages.indexOf(viewController.restorationIdentifier!){
            if index > 0
            {
                return viewControllerAtIndex(index-1)
            }
        }
        
        
        return nil
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController?{
        let vc = storyboard?.instantiateViewControllerWithIdentifier(pages[index])
        return vc
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            firstViewControllerIndex = pages.indexOf(firstViewController.restorationIdentifier!) else {
                return 0
        }
        
        return firstViewControllerIndex
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        self.setViewControllers([viewControllerAtIndex(0)!], direction: .Forward, animated: true, completion:nil)
        self.didMoveToParentViewController(self)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
