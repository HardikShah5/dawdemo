//
//  Home.swift
//  Dawriyah
//
//  Created by MehulS on 26/11/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

let HIGHLIGHTS = 101
let TOP_RATED_NEWS = 102
let MOST_POPULAR_NEWS = 103
let ELECTRONIC_PRESS = 104

private let LATEST_NEWS = 101
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
    
    var viewTopRatedNews: CollectionViewCustom! = nil
    var viewMostPopularNews: CollectionViewCustom! = nil
    var viewElectronicPress: CollectionViewCustom! = nil
    
    
    var arrayTopOptions = [String]()
    var arrayNewImages = [String]()
    
    //Header News
    var imageViewNews: UIImageView!
    var counterCurrentImageNews: Int! = 0
    var viewBottomLineTopOptions: UIView!
    var viewBottomLineClubsPlayers: UIView!
    
    var indexForClubsPlayers: Int! = CLUBS
    
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
        
        //Top options
        arrayTopOptions = ["HIGHLIGHTS",
                            "TOP_RATED_NEWS",
                            "MOST_POPULAR_NEWS",
                            "ELECTRONIC_PRESS"]
        
        var x: CGFloat = 0.0
        var index: Int = 101
        for str in arrayTopOptions {
            let button = UIButton(frame: CGRect(x: x, y: 0, width: 150, height: scrollViewTopOptinos.frame.size.height))
            button.setTitle(AppUtils.localized(str, value: ""), for: .normal)
            button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 15.0)
            
            button.translatesAutoresizingMaskIntoConstraints = true
            scrollViewTopOptinos.addSubview(button)
            
            //Bottom Line
            if index == 101 {
                viewBottomLineTopOptions.frame = CGRect(x: x, y: button.frame.size.height - 3, width: 150, height: 3.0)
                scrollViewTopOptinos.addSubview(viewBottomLineTopOptions)
            }
            
            button.tag = index
            index = index + 1
            
            x = x + 150
            
            button.addTarget(self, action: #selector(btnTopOptionClicked), for: .touchUpInside)
        }
        scrollViewTopOptinos.contentSize = CGSize(width: x, height: scrollViewTopOptinos.frame.size.height)
        
        
        //lblNewsTitle.text = "يف ثلاثلا رودلا ىلإ ياروم";
        //lblNewsSubTitle.text = "استكمل آندي موراي بطل ويمبلدون ما بدأه عندما حصد اللقب الأولمبي في ريو دي جانيرو وتغلب على";
        
        //Load News Header
        self.loadNewsHeader()
        
        //Load Email Subscription Footer 
        self.loadFooter()
        
        //Swipe to change views
        let swipeTopRatedNews = UISwipeGestureRecognizer(target: self, action: #selector(topRatedNews))
        swipeTopRatedNews.direction = .left
        self.view.addGestureRecognizer(swipeTopRatedNews)
        
        //self.tableViewHome.backgroundColor = UIColor.yellow
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
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
        
        //Initialise Array for images
        arrayNewImages = ["image1.png", "image2.png", "image3.png", "image4.png", "image5.png", "image6.png", "image7.png", "image8.png"]
        
        var x: CGFloat = 0.0
        var index: Int = 0
        for strImageName in arrayNewImages {
            let button = UIButton(frame: CGRect(x: x, y: 0, width: 80, height: headerNews.scrollViewNewsImages.frame.size.height))
            button.setBackgroundImage(UIImage(named: strImageName), for: .normal)
            button.imageView?.contentMode = .scaleAspectFill
            button.imageView?.clipsToBounds = true
            
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
        imageViewNews.image = UIImage(named: arrayNewImages[sender.tag])
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
        footer.lblTitleNews.text = AppUtils.localized("MAIL_LIST_SUBSCRIPTION", value: "")
        
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
        }
        
        //Swipe Gesture
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(electronicPress))
        swipeRight.direction = .left
        viewMostPopularNews.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(topRatedNewsRightSwipe))
        swipeLeft.direction = .right
        viewMostPopularNews.addGestureRecognizer(swipeLeft)
        
        
        
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
        
        viewElectronicPress.collectionViewData.tag = ELECTRONIC_PRESS
        viewElectronicPress.showCollectionViewIn(viewCTR: self)
        
        //Swipe Gesture
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(mostPopularNews))
        swipeLeft.direction = .right
        viewElectronicPress.addGestureRecognizer(swipeLeft)
    }
    
    
    @IBAction func btnNewsDetailClicked(_ sender: Any) {
        let newsVC = self.storyboard?.instantiateViewController(withIdentifier: "NewsListing") as! NewsListing
        self.navigationController?.pushViewController(newsVC, animated: true)
    }
    
    
    //MARK: - UITableView Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
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
            return 350
        }else if indexPath.section == 1 {
            return 230
        }else if indexPath.section == 2 {
            return 230
        }else if indexPath.section == 3 {
            let size: CGFloat = (tableView.frame.size.width - 36) / 3
            return (size * 6.0) + 60
        }else if indexPath.section == 4 {
            return 40
        }else if indexPath.section == 5 {
            return 180
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerSection = tableView.dequeueReusableCell(withIdentifier: "CellHeaderSection") as! CellHome
        
        if section == 0 {
            //Latest News
            headerSection.imageViewIcon.image = UIImage(named: "icn_latest_news")
            headerSection.lblTitleHeader.text = AppUtils.localized("LATEST_NEWS", value: "")
        }else if section == 1 {
            //Latest News
            headerSection.imageViewIcon.image = UIImage(named: "icn_articles")
            headerSection.lblTitleHeader.text = AppUtils.localized("MOST_READ_ARTICLE", value: "")
        }else if section == 2 {
            //Facebook & Twitter
            headerSection = tableView.dequeueReusableCell(withIdentifier: "CellHeaderFacebookTwitter") as! CellHome
            
            //Set Title
            headerSection.lblTweets.text = AppUtils.localized("LATEST_TWEET", value: "")
            headerSection.lblFacebookPost.text = AppUtils.localized("LATEST_FACEBOOK_POST", value: "")
        }else if section == 3 {
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
            headerSection.btnClubs.setTitle(AppUtils.localized("CLUBS", value: ""), for: .normal)
            headerSection.btnPlayers.setTitle(AppUtils.localized("PLAYERS", value: ""), for: .normal)
            
            headerSection.btnClubs.addTarget(self, action: #selector(btnClubsClicked), for: .touchUpInside)
            headerSection.btnPlayers.addTarget(self, action: #selector(btnPlayersClicked), for: .touchUpInside)
        }else if section == 4 {
            //Polls
            headerSection.imageViewIcon.image = UIImage(named: "icn_vote")
            headerSection.lblTitleHeader.text = AppUtils.localized("POLL", value: "")
        }else if section == 5 {
            //Advertisement
            headerSection.imageViewIcon.image = UIImage(named: "icn_advertisement")
            headerSection.lblTitleHeader.text = AppUtils.localized("ADVERTISEMENT", value: "")
        }
        
        return headerSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CellCollectionView"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CellHome
        
        if indexPath.section == 0 {
            //Latest News
            cell.backgroundColor = UIColor.clear
            cell.collectionView.tag = LATEST_NEWS
            cell.collectionView.register(UINib(nibName: "CellCollectionViewCustom", bundle: nil), forCellWithReuseIdentifier: "CellData")
            cell.collectionView.isScrollEnabled = false
            cell.collectionView.reloadData()
        }else if indexPath.section == 1 {
            //Most Read Articles
            cell.backgroundColor = UIColor.clear
            cell.collectionView.tag = MOST_READ_ARTICLES
            cell.collectionView.isScrollEnabled = false
            cell.collectionView.reloadData()
        }else if indexPath.section == 2 {
            //Facebook & Twitter
            cell.backgroundColor = UIColor.clear
            cell.collectionView.tag = FACEBOOK_TWITTER
            cell.collectionView.isScrollEnabled = false
            cell.collectionView.reloadData()
        }else if indexPath.section == 3 {
            //Club Player
            cell.backgroundColor = UIColor.clear
            cell.collectionView.tag = CLUB_PLAYER
            cell.collectionView.isScrollEnabled = false
            cell.collectionView.reloadData()
        }else if indexPath.section == 4 {
            //Polls
            cell = tableView.dequeueReusableCell(withIdentifier: "CellVote") as! CellHome
            
        }else if indexPath.section == 5 {
            //Advertisement
            cell = tableView.dequeueReusableCell(withIdentifier: "CellAd") as! CellHome
        }
        
        cell.selectionStyle = . none
        return cell
    }
    
    
    //MARK: - UICollectionView Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView.tag == LATEST_NEWS {
            return CGSize(width: collectionView.frame.size.width - 20, height: 110)
        }else if collectionView.tag == MOST_READ_ARTICLES {
            return CGSize(width: (collectionView.frame.size.width - 26) / 2, height: 70)
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
        if collectionView.tag == LATEST_NEWS {
            return 3
        }else if collectionView.tag == MOST_READ_ARTICLES {
            return 6
        }else if collectionView.tag == FACEBOOK_TWITTER {
            return 6
        }else if collectionView.tag == CLUB_PLAYER {
            return 18
        }
        
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == LATEST_NEWS {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellData", for: indexPath) as! CellCollectionViewCustom
            cell.backgroundColor = UIColor.white
            
            //Layer Properties
            cell.layer.cornerRadius = 3.0
            cell.layer.masksToBounds = true
            
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
            
            return cell
        }else if collectionView.tag == MOST_READ_ARTICLES {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellQuickInfo", for: indexPath) as! CellCollectionViewCustom
            cell.backgroundColor = UIColor.white
            
            //Layer Properties
            cell.layer.cornerRadius = 3.0
            cell.layer.masksToBounds = true
            
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
            
            return cell
        }else if collectionView.tag == FACEBOOK_TWITTER {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellQuickInfo", for: indexPath) as! CellCollectionViewCustom
            cell.backgroundColor = UIColor.white
            
            //Layer Properties
            cell.layer.cornerRadius = 3.0
            cell.layer.masksToBounds = true
            
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
            
            return cell
        }else if collectionView.tag == CLUB_PLAYER {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellClubPlayer", for: indexPath) as! CellCollectionViewCustom
            cell.backgroundColor = UIColor.white
            
            //Layer Properties
            cell.layer.cornerRadius = 3.0
            cell.layer.masksToBounds = true
            
            //For few different images - Temporary Logic
            if indexPath.row % 3 == 0 {
                cell.imageViewClubPlayer.image = UIImage(named: "news_stripe_img.png")
            }else if indexPath.row % 3 == 1 {
                cell.imageViewClubPlayer.image = UIImage(named: "presskit_img@3x.png")
            }else {
                cell.imageViewClubPlayer.image = UIImage(named: "SliderImage.png")
            }
            
            cell.lblClubPlayerName.text = AppUtils.localized("Name", value: "")
            
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
    }
}
