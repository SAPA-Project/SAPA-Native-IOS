//
//  StatsViewController.swift
//  SAPA-Native
//
//  Created by Brian Lai on 11/20/14.
//  Copyright (c) 2014 SAPA. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {

    var viewWidth: Double!
    var viewHeight: Double!

    @IBOutlet var titlebar: UIView!
    @IBOutlet var menuButton: UIButton!
    @IBOutlet var titlebarTitle: UILabel!

    var currentListItemHeight: CGFloat!

    var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        //Get screen size
        let screenRect = view.bounds
        let screenWidth = Double(screenRect.size.width)
        let screenHeight = Double(screenRect.size.height)
        viewWidth = screenWidth
        viewHeight = screenHeight

        //Initialize list item height
        currentListItemHeight = 0.0

        //Initialize elements
        initializeTitlebar()
        initializeScrollView()
        initializeCharts()

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

        let menuButtonTopConstant = CGFloat(22.0)
        let menuButtonHeightConstant = CGFloat(41.0)
        let menuButtonWidthConstant = CGFloat(41.0)

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

        let menuButtonLeadingConstraint = NSLayoutConstraint(item: menuButton, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1.0, constant: 0.0)
        let menuButtonTopConstraint = NSLayoutConstraint(item: menuButton, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: menuButtonTopConstant)
        let menuButtonHeightConstraint = NSLayoutConstraint(item: menuButton, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 0.0, constant: menuButtonHeightConstant)
        let menuButtonWidthConstraint = NSLayoutConstraint(item: menuButton, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 0.0, constant: menuButtonWidthConstant)
        view.addConstraints([menuButtonLeadingConstraint, menuButtonTopConstraint, menuButtonHeightConstraint, menuButtonWidthConstraint])

        let titlebarTitleCenterXConstraint = NSLayoutConstraint(item: titlebarTitle, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let titlebarTitleTopConstraint = NSLayoutConstraint(item: titlebarTitle, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: titlebarTitleTopConstant)
        let titlebarTitleHeightConstraint = NSLayoutConstraint(item: titlebarTitle, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 0.0, constant: titlebarHeightConstant)
        let titlebarTitleWidthConstraint = NSLayoutConstraint(item: titlebarTitle, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: titlebarTitleWidthMultiplier, constant: 0)
        view.addConstraints([titlebarTitleCenterXConstraint, titlebarTitleTopConstraint, titlebarTitleHeightConstraint, titlebarTitleWidthConstraint])

    }

    func initializeScrollView() {
        let scrollViewHeight = CGFloat(viewHeight - 64.0)
        let scrollViewWidth = CGFloat(viewWidth)
        let scrollViewTopConstant = CGFloat(64.0)
        scrollView = UIScrollView()
        scrollView.frame = CGRectMake(0,scrollViewTopConstant,scrollViewWidth,scrollViewHeight)
        scrollView.showsVerticalScrollIndicator = true
        scrollView.scrollEnabled = true
        scrollView.userInteractionEnabled = true
        scrollView.keyboardDismissMode = .OnDrag
        scrollView.contentSize = CGSizeMake(scrollViewWidth,scrollViewHeight)
        view.addSubview(scrollView)
    }

    func initializeCharts() {
        var urlStrings = ["http://chart.googleapis.com/chart?cht=lc&chtt=Average+Daily+Energy+Levels&chco=000000&chs=300x250&chd=t:23,53,64,76,86,56,34,4,35&chxt=x,y&chxr=0,0,23,4|1,0,100,20",
                            "http://chart.googleapis.com/chart?cht=lc&chtt=Depression+Levels&chco=000000&chs=300x250&chd=t:29,10,5,6,8,56,30,35,35&chxt=x,y&chxr=0,0,23,4|1,0,100,20",
                            "http://chart.googleapis.com/chart?cht=lc&chtt=Anxiety+Levels&chco=000000&chs=300x250&chd=t:24,35,22,11,35,76,10,9,35&chxt=x,y&chxr=0,0,23,4|1,0,100,20",
                            "http://chart.googleapis.com/chart?cht=p&chtt=Introversion/Extraversion&chco=0066ff&chs=400x250&chd=t:67,33&chl=Introversion|Extraversion"]

        for i in 0..<urlStrings.count {
            initializeChart(urlStrings[i])
        }
    }

    func initializeChart(url: String) {

        let cellHeight = CGFloat(320.0)
        let cellWidth = CGFloat(320.0)

        let chartLeadingConstant = CGFloat((cellWidth - 300)/2)
        let chartTopConstant = CGFloat(35.0)
        let chartWidth = CGFloat(300.0)
        let chartHeight = CGFloat(250.0)

        var cell = UIView()
        cell.frame = CGRectMake(0.0, currentListItemHeight, cellWidth, cellHeight)

        var chart = UIImageView()
        chart.frame = CGRectMake(chartLeadingConstant, chartTopConstant, chartWidth, chartHeight)

        let chartType = "lc"
        let chartSize = "300x300"
        let chartData = "t:23,53,64,76,86,56,34,4,35"
        let chartAxes = "x,y"
        let chartAxesRanges = "0,0,23,4|1,0,100,20"

        // let urlString = "http://chart.googleapis.com/chart?cht=" + chartType + "&chs=" + chartSize + "&chd=" + chartData + "&chxt=" + chartAxes + "&chxr=" + chartAxesRanges
        let escapedString = url.stringByAddingPercentEscapesUsingEncoding(4)!

        let imgURL = NSURL(string: escapedString)!

        let request = NSURLRequest(URL: imgURL)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
            if error == nil {
                var chartImage = UIImage(data: data)
                chart.image = chartImage
            }
            else {
                println("Error: \(error.localizedDescription)")
            }
        })

        cell.addSubview(chart)

        scrollView.addSubview(cell)

        currentListItemHeight = currentListItemHeight + cellHeight

        if currentListItemHeight > scrollView.contentSize.height {
            NSLog("Increasing")
            scrollView.contentSize.height = currentListItemHeight + 15
        }

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func navigateBack() {
        self.view.endEditing(true)
        self.navigationController?.popViewControllerAnimated(true)
    }

}
