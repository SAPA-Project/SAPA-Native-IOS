//
//  PhotoLibraryViewController.swift
//  SAPA-Native
//
//  Created by Brian Lai on 10/29/14.
//  Copyright (c) 2014 SAPA. All rights reserved.
//

import UIKit

class PhotoLibraryViewController: UIViewController {

    var viewWidth: Double!
    var viewHeight: Double!

    @IBOutlet var titlebar: UIView!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var titlebarTitle: UILabel!

    @IBOutlet var collectionView: UICollectionView!
    var collectionViewFlowLayout: UICollectionViewFlowLayout!

    var myPhotos: NSArray!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        //Get screen size
        let screenRect = view.bounds
        let screenWidth = Double(screenRect.size.width)
        let screenHeight = Double(screenRect.size.height)
        viewWidth = screenWidth
        viewHeight = screenHeight

        //Set photos array
        myPhotos = ["michael.png", "man-with-son.png", "clinic.png", "john.png", "chris.png", "facebook.png", "sagrada.png"]

        //Initialize elements
        initializeTitlebar()
        initializeCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initializeTitlebar() {
        
        let titlebarTopConstant = CGFloat(0)
        let titlebarHeightConstant = CGFloat(64.0)
        let titlebarWidthMultiplier = CGFloat(1.0)
        let titlebarHeight = CGFloat(64.0)
        let titlebarWidth = CGFloat(1.0*viewWidth)

        let cancelButtonTopConstant = CGFloat(23.0)
        let cancelButtonLeadingConstant = CGFloat(viewWidth - 41.0)
        let cancelButtonHeightConstant = CGFloat(41.0)
        let cancelButtonWidthConstant = CGFloat(41.0)

        let titlebarTitleTopConstant = CGFloat(10.0)
        let titlebarTitleHeightConstant = CGFloat(28.0)
        let titlebarTitleWidthMultiplier = CGFloat(0.55)

        let titlebarCenterXConstraint = NSLayoutConstraint(item: titlebar, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let titlebarTopConstraint = NSLayoutConstraint(item: titlebar, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: titlebarTopConstant)
        let titlebarHeightConstraint = NSLayoutConstraint(item: titlebar, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 0.0, constant: titlebarHeightConstant)
        let titlebarWidthConstraint = NSLayoutConstraint(item: titlebar, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: titlebarWidthMultiplier, constant: 0)
        view.addConstraints([titlebarCenterXConstraint, titlebarTopConstraint, titlebarHeightConstraint, titlebarWidthConstraint])
        var titlebarBottomBorder = UIView(frame: CGRectMake(0, titlebarHeight - 1.0, titlebarWidth, 1))
        titlebarBottomBorder.backgroundColor = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0)
        titlebar.addSubview(titlebarBottomBorder)

        let cancelButtonLeadingConstraint = NSLayoutConstraint(item: cancelButton, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1.0, constant: cancelButtonLeadingConstant)
        let cancelButtonTopConstraint = NSLayoutConstraint(item: cancelButton, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: cancelButtonTopConstant)
        let cancelButtonHeightConstraint = NSLayoutConstraint(item: cancelButton, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 0.0, constant: cancelButtonHeightConstant)
        let cancelButtonWidthConstraint = NSLayoutConstraint(item: cancelButton, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 0.0, constant: cancelButtonWidthConstant)
        view.addConstraints([cancelButtonLeadingConstraint, cancelButtonTopConstraint, cancelButtonHeightConstraint, cancelButtonWidthConstraint])

        let titlebarTitleCenterXConstraint = NSLayoutConstraint(item: titlebarTitle, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let titlebarTitleTopConstraint = NSLayoutConstraint(item: titlebarTitle, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: titlebarTitleTopConstant)
        let titlebarTitleHeightConstraint = NSLayoutConstraint(item: titlebarTitle, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 0.0, constant: titlebarHeightConstant)
        let titlebarTitleWidthConstraint = NSLayoutConstraint(item: titlebarTitle, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: titlebarTitleWidthMultiplier, constant: 0)
        view.addConstraints([titlebarTitleCenterXConstraint, titlebarTitleTopConstraint, titlebarTitleHeightConstraint, titlebarTitleWidthConstraint])

    }

    func initializeCollectionView() {

        collectionViewFlowLayout = UICollectionViewFlowLayout()

        let collectionViewTopConstant = CGFloat(64.0)
        let collectionViewHeight = CGFloat(viewHeight - 64.0)
        let collectionViewWidth = CGFloat(viewWidth)

        let collectionViewCenterXConstraint = NSLayoutConstraint(item: collectionView, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let collectionViewTopConstraint = NSLayoutConstraint(item: collectionView, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: collectionViewTopConstant)
        let collectionViewHeightConstraint = NSLayoutConstraint(item: collectionView, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 0.0, constant: collectionViewHeight)
        let collectionViewWidthConstraint = NSLayoutConstraint(item: collectionView, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 0.0, constant: collectionViewWidth)
        view.addConstraints([collectionViewCenterXConstraint, collectionViewTopConstraint, collectionViewHeightConstraint, collectionViewWidthConstraint])

        collectionView.backgroundColor = UIColor.whiteColor()
        collectionViewFlowLayout.itemSize = CGSizeMake(CGFloat(viewWidth/4), CGFloat(viewWidth/4))
        collectionViewFlowLayout.minimumInteritemSpacing = CGFloat(0.0)
        collectionViewFlowLayout.minimumLineSpacing = CGFloat(0.0)

        collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)

    }

    // MARK: UICollectionViewDataSource


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return myPhotos.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoLibraryCell", forIndexPath: indexPath) as PhotoLibraryCollectionViewCell
        
        var imageView = UIImageView()
        imageView.frame = CGRectMake(0, 0, collectionViewFlowLayout.itemSize.width, collectionViewFlowLayout.itemSize.height)
        cell.addSubview(imageView)
        cell.imageView = imageView

        cell.imageView.image = UIImage(named: myPhotos[indexPath.row] as String)
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */



    @IBAction func cancel() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
