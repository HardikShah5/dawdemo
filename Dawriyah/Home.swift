//
//  Home.swift
//  Dawriyah
//
//  Created by MehulS on 26/11/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit
import CoreData

let HIGHLIGHTS = 101
let TOP_RATED_NEWS = 102
let MOST_POPULAR_NEWS = 103
let ELECTRONIC_PRESS = 104

//private let LATEST_NEWS = 101
private let HOME_CATEGORY1 = 101
private let HOME_CATEGORY2 = 105
//private let LATEST_NEWS = 101
private let MOST_READ_ARTICLES = 102
private let FACEBOOK_TWITTER = 103
private let CLUB_PLAYER = 104

private let CLUBS = 201
private let PLAYERS = 202

private var kHeaderImageHeight: CGFloat = 200

class Home: SuperViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewHome: UITableView!
    @IBOutlet weak var scrollViewTopOptinos: UIScrollView!
    
//    @IBOutlet weak var btnNewsDetail: UIButton!
//    @IBOutlet weak var lblNewsTitle: UILabel!
    
//    @IBOutlet weak var lblNewsSubTitle: UILabel!
    
    var arrayTweets             = [NSDictionary]()
    var arrayFacebookPosts      = [NSDictionary]()
    var arrayTwitterFacebook    = [NSDictionary]()
    
    var arraySliderArticles     = [NSDictionary]()
    var arrayMostRatedArticles  = [NSDictionary]()
//    var arrayMostRatedNews      = [NSDictionary]()
    var arrayWriters            = [NSDictionary]()
    var arrayHomeCategory1      = [NSDictionary]()
    var arrayHomeCategory2      = [NSDictionary]()
    
    var arrayClubs              = [NSDictionary]()
    var arrayPlayers            = [NSDictionary]()
    
    var arrayAds = [NSDictionary]()
    
    var viewTopRatedNews: CollectionViewCustom! = nil
    var viewMostPopularNews: CollectionViewCustom! = nil
    var viewElectronicPress: CollectionViewCustom! = nil
    
    var arrayMostPopularNews    = [NSDictionary]()
    var arrayElectronicPress    = [NSDictionary]()
    var homeLabelTitles = [NSManagedObject]()
    
    
    var arrayTopOptions = [String]()
    var arrayNewImages = [String]()
    
    //Header News
    var imageViewNews: UIImageView!
    var lblTitleHeaderView: UILabel!
    var lblSubTitleHeaderView: UILabel!
    
    var counterCurrentImageNews: Int! = 0
    var viewBottomLineTopOptions: UIView!
    var viewBottomLineClubsPlayers: UIView!
    
    var indexForClubsPlayers: Int! = CLUBS
    var indexSelectedTopOption: Int! = HIGHLIGHTS
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Initialise bottom line view
        viewBottomLineTopOptions = UIView()
        viewBottomLineTopOptions.backgroundColor = Constants.Color.BLUE_UNDERLINE
        
        viewBottomLineClubsPlayers = UIView()
        viewBottomLineClubsPlayers.backgroundColor = Constants.Color.BLUE_UNDERLINE
        
        print("Lang : \(AppUtils.currentLanguage())")
        
        //GetPageLableFromDB
        //        SetLabelValues()
        homeLabelTitles = DataBaseHandler.getLabelTitleForPage(ScreenName: "02_Home")
        
        
        //Top options
//        arrayTopOptions = ["HIGHLIGHTS",
//                            "TOP_RATED_NEWS",
//                            "MOST_POPULAR_NEWS"] //"ELECTRONIC_PRESS"
        
        arrayTopOptions = ["sction_1_label_1",
                           "sction_1_label_2",
                           "sction_1_label_3"] //"ELECTRONIC_PRESS"

        var x: CGFloat = 0.0
        var index: Int = 101
        for str in arrayTopOptions {
            
            let btnWidth: CGFloat = self.view.frame.width/3
//
//            if(str == "HIGHLIGHTS"){
//                btnWidth = 120
//            }else if(str == "TOP_RATED_NEWS"){
//                btnWidth = 130
//            }else if(str == "MOST_POPULAR_NEWS"){
//                btnWidth = 160
//            }else{
//                btnWidth = 150
//            }
            
            let button = UIButton(frame: CGRect(x: x, y: 0, width: btnWidth, height: scrollViewTopOptinos.frame.size.height))
            button.setTitle(DataBaseHandler.getTheLabelTitle(ScreenLabelData: homeLabelTitles, key: str), for: .normal)
            button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 15.0)
            
            button.translatesAutoresizingMaskIntoConstraints = true
            
            button.titleLabel?.numberOfLines = 0
            button.titleLabel?.textAlignment = NSTextAlignment.center
            scrollViewTopOptinos.addSubview(button)
            
            //Bottom Line
            if index == 101 {
                viewBottomLineTopOptions.frame = CGRect(x: x, y: button.frame.size.height - 3, width: btnWidth, height: 3.0)
                scrollViewTopOptinos.addSubview(viewBottomLineTopOptions)
            }
            
            button.tag = index
            index = index + 1
            
            x = x + btnWidth
            
            button.addTarget(self, action: #selector(btnTopOptionClicked), for: .touchUpInside)
        }
        scrollViewTopOptinos.contentSize = CGSize(width: x, height: scrollViewTopOptinos.frame.size.height)
        
        
        //lblNewsTitle.text = "يف ثلاثلا رودلا ىلإ ياروم";
        //lblNewsSubTitle.text = "استكمل آندي موراي بطل ويمبلدون ما بدأه عندما حصد اللقب الأولمبي في ريو دي جانيرو وتغلب على";
        
        //Load News Header
        //self.loadNewsHeader()
        
        
        //Load Email Subscription Footer 
        self.loadFooter()
        
        //Swipe to change views
        let swipeTopRatedNews = UISwipeGestureRecognizer(target: self, action: #selector(topRatedNews))
        swipeTopRatedNews.direction = .left
        self.view.addGestureRecognizer(swipeTopRatedNews)
        
        //self.tableViewHome.backgroundColor = UIColor.yellow
        
        //Get Facebook and Twitter POSTs
        
//        AppDelegate.getTitleTextAsPerLang()
        
        self.getSliderArticles()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - SET LABEL VALUES
    
//    func SetLabelValues() -> Void {
//        // Initialize Fetch Request
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Language")
//        
//        //Key : ScreenName
//        //Value : 01_Splash
//        fetchRequest.predicate = NSPredicate(format: "screenName == %@", "02_Home")
//        
//        do {
//
//            let results = try AppUtils.APPDELEGATE().managedObjectContext.fetch(fetchRequest)
//            
//            homeLabelTitles = results as! [NSManagedObject]
////            for item in homeLabelTitles {
////                print("Key : \(item.value(forKey: "key")!)")
////                print("Value : \(item.value(forKey: "value")!)")
////                print("\n")
////                
////                if(item.value(forKey: "key") as! String == "sction_4_label_1"){
////                    print("Tweeter Section found")
////                }
////            }
//        }catch {
//            let fetchError = error as NSError
//            print("\(fetchError), \(fetchError.userInfo)")
//        }
//    }
    
    
    //MARK: - Load News Header
    func loadNewsHeader() -> Void {
        let headerNews = tableViewHome.dequeueReusableCell(withIdentifier: "CellNews") as! CellHome
        tableViewHome.tableHeaderView = headerNews
        headerNews.backgroundColor = UIColor.white
        
        
        headerNews.lblTitleNews.text = AppUtils.localized("Title", value: "")
        headerNews.lblSubTitleNews.text = AppUtils.localized("SubTitle", value: "")
        
        //Get bigger image reference
        imageViewNews = headerNews.imageViewNews
        kHeaderImageHeight = imageViewNews.frame.size.height
        
        lblTitleHeaderView = headerNews.lblTitleNews
        lblSubTitleHeaderView = headerNews.lblSubTitleNews
        
        //Initialise Array for images
        //arrayNewImages = ["image1.png", "image2.png", "image3.png", "image4.png", "image5.png", "image6.png", "image7.png", "image8.png"]
        
        var x: CGFloat = 0.0
        var index: Int = 0
        for dict in arraySliderArticles {
            
            //Image URL
            let strImageURL = /*Constants.IMAGE_PREFIX + */(dict.value(forKey: "image1") as! String)
            let url = URL(string: strImageURL)
            
            let button = UIButton(frame: CGRect(x: x, y: 0, width: 80, height: headerNews.scrollViewNewsImages.frame.size.height))
            //button.setBackgroundImage(UIImage(named: strImageName), for: .normal)
            button.imageView?.contentMode = .scaleAspectFill
            button.imageView?.clipsToBounds = true
            
            //button.setImageFor(.normal, with: url!, placeholderImage: UIImage(named: ""))
            button.setBackgroundImageFor(.normal, with: url!, placeholderImage: UIImage(named: "DefaultImg"))
            
            if index == 0 {
                //Set First Text
                headerNews.lblTitleNews.text  = dict.value(forKey: "title") as? String
                headerNews.lblSubTitleNews.text = dict.value(forKey: "body") as? String
                
                //For setting image to Board
                //headerNews.imageViewNews.setImageWith(url!)
                headerNews.imageViewNews.setImageWith(url!, placeholderImage: UIImage(named: "DefaultImg"))
            }
            
            headerNews.scrollViewNewsImages.addSubview(button)
            
            button.tag = index
            index = index + 1
            
            x = x + 90
            
            button.addTarget(self, action: #selector(btnNewsImageClicked), for: .touchUpInside)
        }
        headerNews.scrollViewNewsImages.contentSize = CGSize(width: x, height: headerNews.scrollViewNewsImages.frame.size.height)
        
        //Add Target
        headerNews.btnPreviousNews.addTarget(self, action: #selector(btnPreviousNewsClicked), for: .touchUpInside)
        headerNews.btnNextNews.addTarget(self, action: #selector(btnNextNewsClicked), for: .touchUpInside)
    }
    
    func btnNewsImageClicked(sender: UIButton) -> Void {
        print("Tag : \(sender.tag)")
        
        counterCurrentImageNews = sender.tag
        
        //Set selected image
        imageViewNews.image = sender.image(for: .normal)
        
        //Set Text
        let dict = arraySliderArticles[sender.tag]
        lblTitleHeaderView.text = dict.value(forKey: "title") as? String
        lblSubTitleHeaderView.text = dict.value(forKey: "body") as? String
    }
    
    func btnPreviousNewsClicked() -> Void {
        if counterCurrentImageNews <= 0 {
            return
        }
        counterCurrentImageNews = counterCurrentImageNews - 1
        
        //Set selected image
        imageViewNews.image = UIImage(named: arrayNewImages[counterCurrentImageNews])
    }
    
    func btnNextNewsClicked() -> Void {
        if counterCurrentImageNews >= arrayNewImages.count - 1 {
            return
        }
        counterCurrentImageNews = counterCurrentImageNews + 1
        
        //Set selected image
        imageViewNews.image = UIImage(named: arrayNewImages[counterCurrentImageNews])
    }
    
    
    //MARK: - Load Email Subscription Footer
    func loadFooter() -> Void {
        let footer = tableViewHome.dequeueReusableCell(withIdentifier: "CellFooter") as! CellHome
        
        //Title
        footer.lblTitleNews.text = DataBaseHandler.getTheLabelTitle(ScreenLabelData: homeLabelTitles, key: "sction_8_label")//getTheLabelTitle(key: "sction_8_label") //AppUtils.localized("MAIL_LIST_SUBSCRIPTION", value: "")
        
        tableViewHome.tableFooterView = footer
    }
    
    
    //MARK: - Top Option Selected Option
    func setTopOptionsUnderline(sender: UIButton) -> Void {
        print("Tag : \(sender.tag)")
        
        //scrollViewTopOptinos.setContentOffset(CGPoint(x: sender.frame.origin.x, y: 0), animated: true)
        scrollViewTopOptinos.scrollRectToVisible(CGRect(x: sender.frame.origin.x, y: 0, width: scrollViewTopOptinos.frame.size.width, height: scrollViewTopOptinos.frame.size.height), animated: true)
        
        //Change frame of Bottom Line
        UIView.animate(withDuration: 0.2, animations: {
            var rect = self.viewBottomLineTopOptions.frame
            rect.origin.x = sender.frame.origin.x
            self.viewBottomLineTopOptions.frame = rect
        })

    }
    
    //MARK: - Top Option
    func btnTopOptionClicked(sender: UIButton) -> Void {
        print("Tag : \(sender.tag)")
        
        //If same option selected TWICE, we don't need to appear it again and again
        if indexSelectedTopOption == sender.tag {
            return
        }
        indexSelectedTopOption = sender.tag
        
        //Change frame of Bottom Line
        UIView.animate(withDuration: 0.2, animations: {
            var rect = self.viewBottomLineTopOptions.frame
            rect.origin.x = sender.frame.origin.x
            self.viewBottomLineTopOptions.frame = rect
        })
        
        
        //viewBottomLineTopOptions.frame = CGRect(x: x, y: button.frame.size.height - 3, width: 150, height: 3.0)
        
        if sender.tag == HIGHLIGHTS {
            print("Highlights")
            self.Highlights()
        }else if sender.tag == TOP_RATED_NEWS {
            print("TOP RATED NEWS")
            self.topRatedNews()
        }else if sender.tag == MOST_POPULAR_NEWS {
            print("MOST Popular NEWS")
            self.mostPopularNews()
        }else if sender.tag == ELECTRONIC_PRESS {
            print("Electronic Press")
            self.electronicPress()
        }
    }
    
    //MARK: - Highlights
    func Highlights() -> Void {
        //Select Option
        let button = scrollViewTopOptinos.viewWithTag(HIGHLIGHTS) as! UIButton
        self.setTopOptionsUnderline(sender: button)
        
        //Change frame of Top Rated News
        UIView.animate(withDuration: 0.3, animations: {
            //Top Rated News
            if self.viewTopRatedNews != nil {
                var rect = self.viewTopRatedNews.frame
                rect.origin.x = self.viewTopRatedNews.frame.size.width
                self.viewTopRatedNews.frame = rect
            }
            
            //MOST Popular NEWS
            if self.viewMostPopularNews != nil {
                var rect = self.viewMostPopularNews.frame
                rect.origin.x = self.viewMostPopularNews.frame.size.width
                self.viewMostPopularNews.frame = rect
            }
            
            //Electronic Press
            if self.viewElectronicPress != nil {
                var rect = self.viewElectronicPress.frame
                rect.origin.x = self.viewElectronicPress.frame.size.width
                self.viewElectronicPress.frame = rect
            }
        }, completion: { (finished) -> Void in
            //Hide other Views
            if self.viewTopRatedNews != nil {
                self.viewTopRatedNews.isHidden = true
            }
            
            if self.viewMostPopularNews != nil {
                self.viewMostPopularNews.isHidden = true
            }
            
            if self.viewElectronicPress != nil {
                self.viewElectronicPress.isHidden = true
            }
        })
    }
    
    func HighlightsRightSwipe() -> Void {
        //Select Option
        let button = scrollViewTopOptinos.viewWithTag(HIGHLIGHTS) as! UIButton
        self.setTopOptionsUnderline(sender: button)
        
        //Change frame of Top Rated News
        UIView.animate(withDuration: 0.3, animations: {
            var rect = self.viewTopRatedNews.frame
            rect.origin.x = self.viewTopRatedNews.frame.size.width
            self.viewTopRatedNews.frame = rect
        }, completion: { (finished) -> Void in
            //Hide other Views
            if self.viewTopRatedNews != nil {
                self.viewTopRatedNews.isHidden = true
            }
            
            if self.viewMostPopularNews != nil {
                self.viewMostPopularNews.isHidden = true
            }
            
            if self.viewElectronicPress != nil {
                self.viewElectronicPress.isHidden = true
            }
        })
    }
    
    //MARK: - TOP RATED NEWS
    func topRatedNews() -> Void {
        /*viewTopRatedNews = CollectionViewCustom.getCollectionView()
        viewTopRatedNews.collectionViewData.tag = TOP_RATED_NEWS
        viewTopRatedNews.showCollectionViewIn(viewCTR: self)*/
        
        
        //Select Option
        let button = scrollViewTopOptinos.viewWithTag(TOP_RATED_NEWS) as! UIButton
        self.setTopOptionsUnderline(sender: button)
        
        if viewTopRatedNews == nil {
            viewTopRatedNews = CollectionViewCustom()
            viewTopRatedNews = viewTopRatedNews.getCollectionView()
        }
        //Show View
        viewTopRatedNews.isHidden = false
        
        viewTopRatedNews.collectionViewData.tag = TOP_RATED_NEWS
        
        //Hide Electronic Press
        if viewMostPopularNews != nil && viewMostPopularNews.frame.origin.x == 0 {
            UIView.animate(withDuration: 0.3, animations: {
                var rect = self.viewMostPopularNews.frame
                rect.origin.x = self.viewMostPopularNews.frame.size.width
                self.viewMostPopularNews.frame = rect
            }, completion: { (finished) -> Void in
            })
        }else {
            viewTopRatedNews.showCollectionViewIn(viewCTR: self)
            viewTopRatedNews.showDataWithArray(array: self.arrayHomeCategory1)
            
            //Show Top Rated News
            //self.showTopRatedNews()
        }
        
        //Swipe Gesture
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(mostPopularNews))
        swipeRight.direction = .left
        viewTopRatedNews.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(HighlightsRightSwipe))
        swipeLeft.direction = .right
        viewTopRatedNews.addGestureRecognizer(swipeLeft)
    }
    
    func topRatedNewsRightSwipe() -> Void {
        //Select Option
        let button = scrollViewTopOptinos.viewWithTag(TOP_RATED_NEWS) as! UIButton
        self.setTopOptionsUnderline(sender: button)
        
        UIView.animate(withDuration: 0.3, animations: {
            var rect = self.viewMostPopularNews.frame
            rect.origin.x = self.viewMostPopularNews.frame.size.width
            self.viewMostPopularNews.frame = rect
        }, completion: { (finished) -> Void in
        })
    }
    
    
    
    
    
    
    
    //MARK: - MOST Popular NEWS
    func mostPopularNews() -> Void {
        /*viewMostPopularNews = CollectionViewCustom.getCollectionView()
        viewMostPopularNews.collectionViewData.tag = MOST_POPULAR_NEWS
        viewMostPopularNews.showCollectionViewIn(viewCTR: self)*/
        
        //Select Option
        let button = scrollViewTopOptinos.viewWithTag(MOST_POPULAR_NEWS) as! UIButton
        self.setTopOptionsUnderline(sender: button)
        
        if viewMostPopularNews == nil {
            viewMostPopularNews = CollectionViewCustom()
            viewMostPopularNews = viewMostPopularNews.getCollectionView()
        }
        //Show View
        viewMostPopularNews.isHidden = false
        
        viewMostPopularNews.collectionViewData.tag = MOST_POPULAR_NEWS
        
        //Hide Electronic Press
        if viewElectronicPress != nil && viewElectronicPress.frame.origin.x == 0 {
            UIView.animate(withDuration: 0.3, animations: {
                var rect = self.viewElectronicPress.frame
                rect.origin.x = self.viewElectronicPress.frame.size.width
                self.viewElectronicPress.frame = rect
            }, completion: { (finished) -> Void in
            })
        }else {
            viewMostPopularNews.showCollectionViewIn(viewCTR: self)
            
            if self.arrayMostPopularNews.count <= 0 {
                self.showMostViewedNews()
            }else {
                self.viewMostPopularNews.showDataWithArray(array: self.arrayMostPopularNews)
            }
            
        }
        
        //Swipe Gesture
//        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(electronicPress))
//        swipeRight.direction = .left
//        viewMostPopularNews.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(topRatedNewsRightSwipe))
        swipeLeft.direction = .right
        viewMostPopularNews.addGestureRecognizer(swipeLeft)
    }
    
    //MARK: - Show Most Viewed News
    func showMostViewedNews() -> Void {
        //Start Loading
        MBProgressHUD.showAdded(to: self.viewMostPopularNews, animated: true)
        
        HomeScreenHandler.getMostViewedNews { (responseObject, success) in
            
            print("Response : \(responseObject)")
            self.arrayMostPopularNews.append(contentsOf: responseObject as! [NSDictionary])
            
            //Relaod Content
            if self.arraySliderArticles.count > 0 {
                self.viewMostPopularNews.showDataWithArray(array: self.arrayMostPopularNews)
            }
            
            //Stop Loading
            MBProgressHUD.hideAllHUDs(for: self.viewMostPopularNews, animated: true)
        }
    }
    
    
    
    //MARK: - Electronic Press
    func electronicPress() -> Void {
        /*viewElectronicPress = CollectionViewCustom.getCollectionView()
        viewElectronicPress.collectionViewData.tag = ELECTRONIC_PRESS
        viewElectronicPress.showCollectionViewIn(viewCTR: self)*/
        
        //Select Option
        let button = scrollViewTopOptinos.viewWithTag(ELECTRONIC_PRESS) as! UIButton
        self.setTopOptionsUnderline(sender: button)
        
        if viewElectronicPress == nil {
            viewElectronicPress = CollectionViewCustom()
            viewElectronicPress = viewElectronicPress.getCollectionView()
        }
        //Show View
        viewElectronicPress.isHidden = false
        
        
        //Show Data
        if self.arrayElectronicPress.count <= 0 {
            self.showElectronicPress()
        }else {
            self.viewElectronicPress.showDataWithArray(array: self.arrayElectronicPress)
        }
        
        viewElectronicPress.collectionViewData.tag = ELECTRONIC_PRESS
        viewElectronicPress.showCollectionViewIn(viewCTR: self)
        
        //Swipe Gesture
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(mostPopularNews))
        swipeLeft.direction = .right
        viewElectronicPress.addGestureRecognizer(swipeLeft)
    }
    
    //MARK: - Show Electronic Press
    func showElectronicPress() -> Void {
        //Start Loading
        MBProgressHUD.showAdded(to: self.viewElectronicPress, animated: true)
        
        HomeScreenHandler.getElectronicPress { (responseObject, success) in
            
            print("Response : \(responseObject)")
            self.arrayElectronicPress.append(contentsOf: responseObject as! [NSDictionary])
            
            //Relaod Content
            if self.arrayElectronicPress.count > 0 {
                self.viewElectronicPress.showDataWithArray(array: self.arrayElectronicPress)
            }
            
            //Stop Loading
            MBProgressHUD.hideAllHUDs(for: self.viewElectronicPress, animated: true)
        }
    }
    
    
    
    @IBAction func btnNewsDetailClicked(_ sender: Any) {
        let newsVC = self.storyboard?.instantiateViewController(withIdentifier: "NewsListing") as! NewsListing
        self.navigationController?.pushViewController(newsVC, animated: true)
    }
    
    
    //MARK: - UITableView Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            //Writers
            return 150
        }else if indexPath.section == 1 {
            //Latest News
            print(arrayHomeCategory1.count)
            return CGFloat(arrayHomeCategory1.count * 118)
        }else if indexPath.section == 2 {
            //Latest News
            print(arrayHomeCategory2.count)
            return CGFloat(arrayHomeCategory2.count * 118)
        }else if indexPath.section == 3 {
            //Most Read Articles
            print(arrayMostRatedArticles.count)
            return CGFloat((arrayMostRatedArticles.count / 2) * 70)
        }else if indexPath.section == 4 {
            //Twitter & Facebook
            return 230
        }else if indexPath.section == 5 {
            //let size: CGFloat = (tableView.frame.size.width - 36) / 3
            //return (size * 6.0) + 60
            
            let size: CGFloat = (tableView.frame.size.width - 36) / 3
            if indexForClubsPlayers == CLUBS && arrayClubs.count > 0 {
                let row = (arrayClubs.count / 2)
                return CGFloat(size * CGFloat(row)) + CGFloat(row) * 10
            }else if indexForClubsPlayers == PLAYERS && arrayPlayers.count > 0 {
                let row = (arrayPlayers.count / 2)
                return CGFloat(size * CGFloat(row)) + CGFloat(row) * 10
            }else {
                return 0
            }
        }else if indexPath.section == 6 {
            return 40
        }else if indexPath.section == 7 {
            return 180
        }
        return 0
    }
//    func getTheLabelTitle(key: String) -> String? {
//                    for item in homeLabelTitles {
////                        print("Key : \(item.value(forKey: "key")!)")
////                        print("Value : \(item.value(forKey: "value")!)")
////                        print("\n")
//                        
//                        if(item.value(forKey: "key") as! String == key){
//                           return item.value(forKey: "value") as? String
//                        }
//                    }
//        return ""
//    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerSection = tableView.dequeueReusableCell(withIdentifier: "CellHeaderSection") as! CellHome
        
        if section == 0 {
            //Writers
            headerSection.imageViewIcon.image = UIImage(named: "icn_latest_news")
            headerSection.lblTitleHeader.text = AppUtils.localized("WRITERS", value: "")
        }else if section == 1 {
            //Latest News
            headerSection.imageViewIcon.image = UIImage(named: "icn_latest_news")
            headerSection.lblTitleHeader.text = AppUtils.localized("LATEST_NEWS", value: "")
        }else if section == 2 {
            //Latest News
            headerSection.imageViewIcon.image = UIImage(named: "icn_latest_news")
            headerSection.lblTitleHeader.text = AppUtils.localized("LATEST_NEWS", value: "")
        }else if section == 3 {
            //Latest News
            headerSection.imageViewIcon.image = UIImage(named: "icn_articles")
            headerSection.lblTitleHeader.text = AppUtils.localized("MOST_READ_ARTICLE", value: "")
        }else if section == 4 {
            //Facebook & Twitter
            headerSection = tableView.dequeueReusableCell(withIdentifier: "CellHeaderFacebookTwitter") as! CellHome
            
            //Set Title
//            headerSection.lblTweets.text = AppUtils.localized("LATEST_TWEET", value: "")
//            headerSection.lblFacebookPost.text = AppUtils.localized("LATEST_FACEBOOK_POST", value: "")
            headerSection.lblTweets.text = DataBaseHandler.getTheLabelTitle(ScreenLabelData: homeLabelTitles, key: "sction_4_label_1") //getTheLabelTitle(key: "sction_4_label_1")
            headerSection.lblFacebookPost.text = DataBaseHandler.getTheLabelTitle(ScreenLabelData: homeLabelTitles, key: "sction_4_label_2") //getTheLabelTitle(key: "sction_4_label_2")
        }else if section == 5 {
            //Clubs & Players
            headerSection = tableView.dequeueReusableCell(withIdentifier: "CellClubPlayer") as! CellHome
            
            if indexForClubsPlayers == CLUBS {
                viewBottomLineClubsPlayers.frame = CGRect(x: 0, y: headerSection.btnClubs.frame.size.height - 3, width: headerSection.btnClubs.frame.size.width, height: 3.0)
                
                headerSection.btnClubs.addSubview(viewBottomLineClubsPlayers)
            }else {
                var rect = viewBottomLineClubsPlayers.frame
                rect.origin.x = headerSection.btnPlayers.frame.origin.x
                viewBottomLineClubsPlayers.frame = rect
                
                headerSection.btnPlayers.addSubview(viewBottomLineClubsPlayers)
            }
            
            //Add Target
//            headerSection.btnClubs.setTitle(AppUtils.localized("CLUBS", value: ""), for: .normal)
//            headerSection.btnPlayers.setTitle(AppUtils.localized("PLAYERS", value: ""), for: .normal)
            headerSection.btnClubs.setTitle(DataBaseHandler.getTheLabelTitle(ScreenLabelData: homeLabelTitles, key: "sction_5_label_1"), for: .normal)
            headerSection.btnPlayers.setTitle(DataBaseHandler.getTheLabelTitle(ScreenLabelData: homeLabelTitles, key: "sction_5_label_2"), for: .normal)
            
            headerSection.btnClubs.addTarget(self, action: #selector(btnClubsClicked), for: .touchUpInside)
            headerSection.btnPlayers.addTarget(self, action: #selector(btnPlayersClicked), for: .touchUpInside)
        }else if section == 6 {
            //Polls
            headerSection.imageViewIcon.image = UIImage(named: "icn_vote")
//            headerSection.lblTitleHeader.text = AppUtils.localized("POLL1", value: "")
            headerSection.lblTitleHeader.text = DataBaseHandler.getTheLabelTitle(ScreenLabelData: homeLabelTitles, key: "sction_6_label")//getTheLabelTitle(key: "sction_6_label")
            
        }else if section == 7 {
            //Advertisement
            headerSection.imageViewIcon.image = UIImage(named: "icn_advertisement")
//            headerSection.lblTitleHeader.text = AppUtils.localized("ADVERTISEMENT1", value: "")
            headerSection.lblTitleHeader.text = DataBaseHandler.getTheLabelTitle(ScreenLabelData: homeLabelTitles, key: "sction_7_label")//getTheLabelTitle(key: "sction_7_label")
        }
        
        return headerSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CellCollectionView"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CellHome
        
        if indexPath.section == 0 {
            //Writers
            cell = tableView.dequeueReusableCell(withIdentifier: "CellWriter") as! CellHome
            
            var xOrigin: CGFloat = 10.0
            let width = (UIScreen.main.bounds.size.width - 30) / 3
            
            if self.arrayWriters.count <= 0 {
                return cell
            }
            
            for index in 0...self.arrayWriters.count-1 {
                //let btnAd = UIButton(frame:  CGRect(x: xOrigin, y: 0, width: width, height: cell.scrollViewAds.frame.size.height))
                let imageViewAd = UIImageView(frame: CGRect(x: xOrigin, y: 0, width: width, height: 120))
                
                //imageViewAd.image = UIImage(named: "social_stripe_avatar@3x.png")
                
                //Set Image
                let dict = self.arrayWriters[index] as! [String : AnyObject]
                let strURL = dict["Img"] as! String
                if let url = URL(string: strURL) {
                    imageViewAd.setImageWith(url, placeholderImage: UIImage(named: "DefaultImg"))
                }else {
                    imageViewAd.image = UIImage(named: "DefaultImg")
                }
                
                //btnAd.imageView?.contentMode = .scaleAspectFill
                //btnAd.imageView?.clipsToBounds = true
                
                /*
                let strURL = dict.value(forKey: "image") as! String
                let url = URL(string: strURL)
                imageViewAd.setImageWith(url!)
                imageViewAd.setImageWith(url!, placeholderImage: UIImage(named: "DefaultImg"))
                */
                
                //btnAd.setImageFor(.normal, with: url!)
                //btnAd.setBackgroundImageFor(.normal, with: url!)
                
                imageViewAd.contentMode = .scaleAspectFill
                imageViewAd.clipsToBounds = true
                
                cell.scrollViewWriter.addSubview(imageViewAd)
                
                //Add Label for Name
                let lblName = UILabel(frame: CGRect(x: xOrigin, y: 120, width: width, height: 30))
                lblName.textAlignment = .center
                lblName.font = UIFont(name: "Helvetica", size: 16.0)
                //lblName.text = "Writer \(index)"
                lblName.text = dict["Name"] as? String
                lblName.textColor = UIColor.white
                lblName.backgroundColor = UIColor.clear
                cell.scrollViewWriter.addSubview(lblName)
                
                xOrigin = xOrigin + width + 10
            }
            cell.scrollViewWriter.contentSize = CGSize(width: xOrigin, height: cell.scrollViewWriter.frame.size.height)
        }else if indexPath.section == 1 {
            //Home Cate1 - Latest News
            cell.backgroundColor = UIColor.clear
            cell.collectionView.tag = HOME_CATEGORY1
            cell.collectionView.register(UINib(nibName: "CellCollectionViewCustom", bundle: nil), forCellWithReuseIdentifier: "CellData")
            cell.collectionView.isScrollEnabled = false
            cell.collectionView.reloadData()
        }else if indexPath.section == 2 {
            //Home Cate2 - Latest News
            cell.backgroundColor = UIColor.clear
            cell.collectionView.tag = HOME_CATEGORY2
            cell.collectionView.register(UINib(nibName: "CellCollectionViewCustom", bundle: nil), forCellWithReuseIdentifier: "CellData")
            cell.collectionView.isScrollEnabled = false
            cell.collectionView.reloadData()
        }else if indexPath.section == 3 {
            //Most Read Articles
            cell.backgroundColor = UIColor.clear
            cell.collectionView.tag = MOST_READ_ARTICLES
            cell.collectionView.isScrollEnabled = false
            cell.collectionView.reloadData()
        }else if indexPath.section == 4 {
            //Facebook & Twitter
            cell.backgroundColor = UIColor.clear
            cell.collectionView.tag = FACEBOOK_TWITTER
            cell.collectionView.isScrollEnabled = false
            cell.collectionView.reloadData()
        }else if indexPath.section == 5 {
            //Club Player
            cell.backgroundColor = UIColor.clear
            cell.collectionView.tag = CLUB_PLAYER
            cell.collectionView.isScrollEnabled = false
            cell.collectionView.reloadData()
        }else if indexPath.section == 6 {
            //Polls
            cell = tableView.dequeueReusableCell(withIdentifier: "CellVote") as! CellHome
            cell.btnVote.setTitle(DataBaseHandler.getTheLabelTitle(ScreenLabelData: homeLabelTitles, key: "sction_6_button"), for: .normal) //getTheLabelTitle(key: "sction_6_button")
        }else if indexPath.section == 7 {
            //Advertisement
            cell = tableView.dequeueReusableCell(withIdentifier: "CellAd") as! CellHome
            
            var xOrigin: CGFloat = 0.0
            let width = UIScreen.main.bounds.size.width
            for dict in arrayAds {
                //let btnAd = UIButton(frame:  CGRect(x: xOrigin, y: 0, width: width, height: cell.scrollViewAds.frame.size.height))
                let imageViewAd = UIImageView(frame: CGRect(x: xOrigin, y: 0, width: width, height: cell.scrollViewAds.frame.size.height))
                
                //btnAd.imageView?.contentMode = .scaleAspectFill
                //btnAd.imageView?.clipsToBounds = true
                
                let strURL = dict.value(forKey: "image") as! String
                let url = URL(string: strURL)
                imageViewAd.setImageWith(url!)
                imageViewAd.setImageWith(url!, placeholderImage: UIImage(named: "DefaultImg"))
                
                //btnAd.setImageFor(.normal, with: url!)
                //btnAd.setBackgroundImageFor(.normal, with: url!)
                
                imageViewAd.contentMode = .scaleAspectFill
                imageViewAd.clipsToBounds = true
                
                cell.scrollViewAds.addSubview(imageViewAd)
                
                xOrigin = xOrigin + width
            }
            cell.scrollViewAds.contentSize = CGSize(width: xOrigin, height: cell.scrollViewAds.frame.size.height)
        }
        
        cell.selectionStyle = . none
        return cell
    }
    
    
    //MARK: - UICollectionView Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView.tag == HOME_CATEGORY1 {
            return CGSize(width: collectionView.frame.size.width - 20, height: 110)
        }else if collectionView.tag == HOME_CATEGORY2 {
            return CGSize(width: collectionView.frame.size.width - 20, height: 110)
        }else if collectionView.tag == MOST_READ_ARTICLES {
            return CGSize(width: (collectionView.frame.size.width - 26) / 2, height: CGFloat(arrayMostRatedArticles.count * 35))
        }else if collectionView.tag == FACEBOOK_TWITTER {
            return CGSize(width: (collectionView.frame.size.width - 26) / 2, height: 70)
        }else if collectionView.tag == CLUB_PLAYER {
            let size: CGFloat = (collectionView.frame.size.width - 36) / 3
            return CGSize(width: size, height: size)
        }
        return CGSize(width: collectionView.frame.size.width - 20, height: 110)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == HOME_CATEGORY1 {
            return arrayHomeCategory1.count
        }else if collectionView.tag == HOME_CATEGORY2 {
            return arrayHomeCategory2.count
        }else if collectionView.tag == MOST_READ_ARTICLES {
            return arrayMostRatedArticles.count
        }else if collectionView.tag == FACEBOOK_TWITTER {
            return arrayTwitterFacebook.count
        }else if collectionView.tag == CLUB_PLAYER {
            if indexForClubsPlayers == CLUBS {
                return arrayClubs.count
            }
            return arrayPlayers.count
        }
        
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == HOME_CATEGORY1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellData", for: indexPath) as! CellCollectionViewCustom
            cell.backgroundColor = UIColor.white
            
            //Layer Properties
            cell.layer.cornerRadius = 3.0
            cell.layer.masksToBounds = true
            
            //For few different images - Temporary Logic
            /*if indexPath.row % 3 == 0 {
                cell.imageViewPost.image = UIImage(named: "news_stripe_img.png")
            }else if indexPath.row % 3 == 1 {
                cell.imageViewPost.image = UIImage(named: "presskit_img@3x.png")
            }else {
                cell.imageViewPost.image = UIImage(named: "SliderImage.png")
            }*/
            
            let dict = arrayHomeCategory1[indexPath.row]
            
            //Image URL
            let strImageURL = /*Constants.IMAGE_PREFIX + */(dict.value(forKey: "image1") as! String)
            let url = URL(string: strImageURL)
            //cell.imageViewPost.setImageWith(url!)
            cell.imageViewPost.setImageWith(url!, placeholderImage: UIImage(named: "DefaultImg"))
            
            //Set First Text
            cell.lblTitle.text  = dict.value(forKey: "title") as? String
            cell.lblDescription.text = dict.value(forKey: "body") as? String
            cell.lblDate.text = dict.value(forKey: "publishdate") as? String
            
            return cell
        }else if collectionView.tag == HOME_CATEGORY2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellData", for: indexPath) as! CellCollectionViewCustom
            cell.backgroundColor = UIColor.white
            
            //Layer Properties
            cell.layer.cornerRadius = 3.0
            cell.layer.masksToBounds = true
            
            //For few different images - Temporary Logic
            /*if indexPath.row % 3 == 0 {
             cell.imageViewPost.image = UIImage(named: "news_stripe_img.png")
             }else if indexPath.row % 3 == 1 {
             cell.imageViewPost.image = UIImage(named: "presskit_img@3x.png")
             }else {
             cell.imageViewPost.image = UIImage(named: "SliderImage.png")
             }*/
            
            let dict = arrayHomeCategory2[indexPath.row]
            
            //Image URL
            let strImageURL = /*Constants.IMAGE_PREFIX + */(dict.value(forKey: "image1") as! String)
            let url = URL(string: strImageURL)
            //cell.imageViewPost.setImageWith(url!)
            cell.imageViewPost.setImageWith(url!, placeholderImage: UIImage(named: "DefaultImg"))
            
            //Set First Text
            cell.lblTitle.text  = dict.value(forKey: "title") as? String
            cell.lblDescription.text = dict.value(forKey: "body") as? String
            cell.lblDate.text = dict.value(forKey: "publishdate") as? String
            
            return cell
        }else if collectionView.tag == MOST_READ_ARTICLES {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellQuickInfo", for: indexPath) as! CellCollectionViewCustom
            cell.backgroundColor = UIColor.white
            
            //Layer Properties
            cell.layer.cornerRadius = 3.0
            cell.layer.masksToBounds = true
            
            let dict = arrayMostRatedArticles[indexPath.row]
            
            //Image URL
            let strImageURL = /*Constants.IMAGE_PREFIX + */(dict.value(forKey: "image1") as! String)
            let url = URL(string: strImageURL)
            //cell.imageViewPost.setImageWith(url!)
            cell.imageViewPost.setImageWith(url!, placeholderImage: UIImage(named: "DefaultImg"))
            
            //Set First Text
            cell.lblTitle.text  = dict.value(forKey: "title") as? String
            cell.lblDescription.text = dict.value(forKey: "body") as? String
            cell.lblDate.text = dict.value(forKey: "publishdate") as? String
            
            return cell
        }else if collectionView.tag == FACEBOOK_TWITTER {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellQuickInfo", for: indexPath) as! CellCollectionViewCustom
            cell.backgroundColor = UIColor.white
            
            //Layer Properties
            cell.layer.cornerRadius = 3.0
            cell.layer.masksToBounds = true
            
            let dict = self.arrayTwitterFacebook[indexPath.row]
            
            //Image
            let strURL = dict.value(forKey: "profile_pic") as! String
            let url = URL(string: strURL)
            cell.imageViewPost.setImageWith(url!, placeholderImage: UIImage(named: "ProfilePic"))
            
            //Data
            cell.lblTitle.text = dict.value(forKey: "profile_name") as? String
            cell.lblDescription.text = dict.value(forKey: "message") as? String
            cell.lblDate.text = dict.value(forKey: "created_time") as? String
            
            /*
            //For few different images - Temporary Logic
            if indexPath.row % 3 == 0 {
                cell.imageViewPost.image = UIImage(named: "news_stripe_img.png")
            }else if indexPath.row % 3 == 1 {
                cell.imageViewPost.image = UIImage(named: "presskit_img@3x.png")
            }else {
                cell.imageViewPost.image = UIImage(named: "SliderImage.png")
            }
            
            cell.lblTitle.text = AppUtils.localized("Title", value: "")
            cell.lblDescription.text = AppUtils.localized("SubTitle", value: "")
            */
            
            return cell
        }else if collectionView.tag == CLUB_PLAYER {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellClubPlayer", for: indexPath) as! CellCollectionViewCustom
            cell.backgroundColor = UIColor.white
            
            //Layer Properties
            cell.layer.cornerRadius = 3.0
            cell.layer.masksToBounds = true
            
            var dict: NSDictionary!
            if indexForClubsPlayers == CLUBS {
                //Club
                dict = arrayClubs[indexPath.row]
            }else {
                //Players
                dict = arrayPlayers[indexPath.row]
            }
            
            
            //Image
            let strURL = /*Constants.IMAGE_PREFIX + */(dict.value(forKey: "image1") as! String)
            let url = URL(string: strURL)
            cell.imageViewClubPlayer.setImageWith(url!, placeholderImage: UIImage(named: "ProfilePic"))
            
            //Title
            cell.lblClubPlayerName.text = dict.value(forKey: "classification") as? String
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    
    //MARK: - Clubs 
    func btnClubsClicked(sender: UIButton) -> Void {
        print("Clubs Clicked")
        
        indexForClubsPlayers = CLUBS
        
        UIView.animate(withDuration: 0.2, animations: {
            var rect = self.viewBottomLineClubsPlayers.frame
            rect.origin.x = sender.frame.origin.x
            self.viewBottomLineClubsPlayers.frame = rect
        })
        
        self.tableViewHome.reloadData()
    }
    
    //MARK: - Players
    func btnPlayersClicked(sender: UIButton) -> Void {
        print("Players Clicked")
        
        indexForClubsPlayers = PLAYERS
        
        UIView.animate(withDuration: 0.2, animations: {
            var rect = self.viewBottomLineClubsPlayers.frame
            rect.origin.x = sender.frame.origin.x
            self.viewBottomLineClubsPlayers.frame = rect
        })
        
        self.tableViewHome.reloadData()
    }
    
    
    
    
    //MARK: - Web Services
    //MARK: - Slider Articles
    func getSliderArticles() -> Void {
        //Start Loading
        MBProgressHUD.showAdded(to: self.view, animated: true)
        //AppUtils.startLoading(view: self.view)
        
        HomeScreenHandler.getSliderArticles { (responseObject, success) in
            
            print("Response : \(responseObject)")
            
            if success == true {
                self.arraySliderArticles.append(contentsOf: responseObject as! [NSDictionary])
            }else {
                self.arraySliderArticles.removeAll()
            }
                
            //Relaod Content
            if self.arraySliderArticles.count > 0 {
                self.loadNewsHeader()
            }
            
            //Get Most Rated Articles
            //self.getHomeCate1()
            
            //Get Writers
            self.getWriters()
        }
    }
    
    
    //MARK: - Home Cate1
    func getWriters() -> Void {
        
        HomeScreenHandler.getWriters { (responseObject, success) in
            
            print("Response : \(responseObject)")
            
            if success == true {
                let data = responseObject?.value(forKey: "data") as! NSDictionary
                let writers = data.value(forKey: "writers") as! [NSDictionary]
                self.arrayWriters = writers
            }else {
                self.arrayWriters.removeAll()
            }
            
            //Relaod Content
            if self.arrayWriters.count > 0 {
                self.tableViewHome.reloadData()
            }
            
            //Get Most Rated Articles
            self.self.getHomeCate1()
        }
    }
    
    
    //MARK: - Home Cate1
    func getHomeCate1() -> Void {
        
        HomeScreenHandler.getHomeCate1 { (responseObject, success) in
            
            print("Response : \(responseObject)")
            
            if success == true {
                self.arrayHomeCategory1.append(contentsOf: responseObject as! [NSDictionary])
            }else {
                self.arrayHomeCategory1.removeAll()
            }
                
            //Relaod Content
            if self.arrayHomeCategory1.count > 0 {
                self.tableViewHome.reloadData()
            }
            
            //Get Most Rated Articles
            self.getHomeCate2()
        }
    }

    //MARK: - Home Cate2
    func getHomeCate2() -> Void {
        
        HomeScreenHandler.getHomeCate2 { (responseObject, success) in
            
            print("Response : \(responseObject)")
            
            if success == true {
                self.arrayHomeCategory2.append(contentsOf: responseObject as! [NSDictionary])
            }else {
                self.arrayHomeCategory2.removeAll()
            }
                
            //Relaod Content
            if self.arrayHomeCategory2.count > 0 {
                self.tableViewHome.reloadData()
            }
            
            //Get Most Rated Articles
            self.getMostRatedArticles()
        }
    }
    
    
    //MARK: - Most Rated Articles
    func getMostRatedArticles() -> Void {
        
        HomeScreenHandler.getMostRatedArticles { (responseObject, success) in
            
            print("Response : \(responseObject)")
            
            if success == true {
                self.arrayMostRatedArticles.append(contentsOf: responseObject as! [NSDictionary])
            }else {
                self.arrayMostRatedArticles.removeAll()
            }
                
            //Get Most Rated Articles
            self.getTwitterPosts()
        }
    }
    
    
    
    
    
    //MARK: - Twitter
    func getTwitterPosts() -> Void {
        //Start Loading
        AppUtils.startLoading(view: self.view)
        
        HomeScreenHandler.getLatestTweets { (responseObject, success) in
            
            print("Response : \(responseObject)")
            
            if success == true {
                self.arrayTweets.append(contentsOf: responseObject as! [NSDictionary])
            }else {
                self.arrayTweets.removeAll()
            }
            
            //Get Facebook Posts
            self.getFacebookPosts()
        }
    }
    
    //MARK: - Facebook
    func getFacebookPosts() -> Void {
        
        HomeScreenHandler.getLatestFacebookPosts { (responseObject, success) in
            
            print("Response : \(responseObject)")
            
            if success == true {
                self.arrayFacebookPosts.append(contentsOf: responseObject as! [NSDictionary])
            }else {
                self.arrayFacebookPosts.removeAll()
            }
            
            //Arrange Twitter and Facebook Response
            self.arrangeTwitterAndFacebookData()
        }
    }
    
    func arrangeTwitterAndFacebookData() -> Void {
        var totalData: Int = self.arrayTweets.count + self.arrayFacebookPosts.count
        totalData = (totalData - 1) / 2
        
        for i in 0...totalData {
            
            arrayTwitterFacebook.append(self.arrayTweets[i])
            arrayTwitterFacebook.append(self.arrayFacebookPosts[i])
            
            /*
            if i % 2 == 0 {
                //Twitter
                arrayTwitterFacebook.append(self.arrayTweets[i])
            }else {
                //Facebook
                let index = i - 1
                arrayTwitterFacebook.append(self.arrayFacebookPosts[index])
            }*/
        }
        
        //Get Club News
        self.getClubsNews()
    }
    
    
    //MARK: - Facebook
    func getClubsNews() -> Void {
        
        HomeScreenHandler.getClubNews { (responseObject, success) in
            
            print("Response : \(responseObject)")
            
            if success == true {
                self.arrayClubs.append(contentsOf: responseObject as! [NSDictionary])
            }else {
                self.arrayClubs.removeAll()
            }
            
            //Get Players News
            self.getPlayersNews()
        }
    }
    
    
    //MARK: - Facebook
    func getPlayersNews() -> Void {
        
        HomeScreenHandler.getPlayersNews { (responseObject, success) in
            
            print("Response : \(responseObject)")
            
            if success == true {
                self.arrayPlayers.append(contentsOf: responseObject as! [NSDictionary])
            }else {
                self.arrayPlayers.removeAll()
            }
            
            //Relaod Content
            if self.arrayTwitterFacebook.count > 0 {
                self.tableViewHome.reloadData()
            }
            
            //Stop Loading
            MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
            //AppUtils.stopLoading()
            
            //Get Ads
            self.loadAds()
        }
    }
    
    
    //MARK: - Ads
    func loadAds() -> Void {
        HomeScreenHandler.getAds { (responseObject, success) in
            
            print("Response : \(responseObject)")
            
            if success == true {
                self.arrayAds.append(contentsOf: responseObject as! [NSDictionary])
            }else {
                self.arrayAds.removeAll()
            }
                
            //Relaod Content
            if self.arrayAds.count > 0 {
                self.tableViewHome.reloadData()
            }
        }
    }
}
