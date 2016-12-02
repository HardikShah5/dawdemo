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

class Home: SuperViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, SliderMenuDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewHome: UITableView!
    @IBOutlet weak var scrollViewTopOptinos: UIScrollView!
    
//    @IBOutlet weak var btnNewsDetail: UIButton!
//    @IBOutlet weak var lblNewsTitle: UILabel!
    
//    @IBOutlet weak var lblNewsSubTitle: UILabel!
    
    var viewTopRatedNews: CollectionViewCustom! = nil
    var viewMostPopularNews: CollectionViewCustom! = nil
    var viewElectronicPress: CollectionViewCustom! = nil
    var sliderMenu: SliderMenu! = nil
    
    var arrayTopOptions = [String]()
    var arrayNewImages = [String]()
    
    //Header News
    var imageViewNews: UIImageView!
    var counterCurrentImageNews: Int! = 0
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Set Up Navigation Bar Buttons
        self.setupNavigationBar()
        
        
        //Top options
        arrayTopOptions = ["Highlights",
                            "Top Rated News",
                            "Most Popular News",
                            "Electronic Press"]
        
        var x: CGFloat = 0.0
        var index: Int = 101
        for str in arrayTopOptions {
            let button = UIButton(frame: CGRect(x: x, y: 0, width: 150, height: scrollViewTopOptinos.frame.size.height))
            button.setTitle(str, for: .normal)
            button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 15.0)
            
            scrollViewTopOptinos.addSubview(button)
            
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
        
        //Get bigger image reference
        imageViewNews = headerNews.imageViewNews
        
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
        tableViewHome.tableFooterView = footer
    }
    
    
    //MARK: - Top Option
    func btnTopOptionClicked(sender: UIButton) -> Void {
        print("Tag : \(sender.tag)")
        
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
        //Hide other Views
        if viewTopRatedNews != nil {
            viewTopRatedNews.isHidden = true
        }
        
        if viewMostPopularNews != nil {
            self.viewMostPopularNews.isHidden = true
        }
        
        if viewElectronicPress != nil {
            viewElectronicPress.isHidden = true
        }
    }
    
    //MARK: - TOP RATED NEWS
    func topRatedNews() -> Void {
        /*viewTopRatedNews = CollectionViewCustom.getCollectionView()
        viewTopRatedNews.collectionViewData.tag = TOP_RATED_NEWS
        viewTopRatedNews.showCollectionViewIn(viewCTR: self)*/
        
        if viewTopRatedNews == nil {
            viewTopRatedNews = CollectionViewCustom()
            viewTopRatedNews = viewTopRatedNews.getCollectionView()
        }
        //Show View
        viewTopRatedNews.isHidden = false
        
        viewTopRatedNews.collectionViewData.tag = TOP_RATED_NEWS
        viewTopRatedNews.showCollectionViewIn(viewCTR: self)
    }
    
    //MARK: - MOST Popular NEWS
    func mostPopularNews() -> Void {
        /*viewMostPopularNews = CollectionViewCustom.getCollectionView()
        viewMostPopularNews.collectionViewData.tag = MOST_POPULAR_NEWS
        viewMostPopularNews.showCollectionViewIn(viewCTR: self)*/
        
        if viewMostPopularNews == nil {
            viewMostPopularNews = CollectionViewCustom()
            viewMostPopularNews = viewMostPopularNews.getCollectionView()
        }
        //Show View
        viewMostPopularNews.isHidden = false
        
        viewMostPopularNews.collectionViewData.tag = MOST_POPULAR_NEWS
        viewMostPopularNews.showCollectionViewIn(viewCTR: self)
    }
    
    //MARK: - Electronic Press
    func electronicPress() -> Void {
        /*viewElectronicPress = CollectionViewCustom.getCollectionView()
        viewElectronicPress.collectionViewData.tag = ELECTRONIC_PRESS
        viewElectronicPress.showCollectionViewIn(viewCTR: self)*/
        
        if viewElectronicPress == nil {
            viewElectronicPress = CollectionViewCustom()
            viewElectronicPress = viewElectronicPress.getCollectionView()
        }
        //Show View
        viewElectronicPress.isHidden = false
        
        viewElectronicPress.collectionViewData.tag = ELECTRONIC_PRESS
        viewElectronicPress.showCollectionViewIn(viewCTR: self)
    }
    
    
    //MARK: - Set Up Navigation Bar Buttons
    func setupNavigationBar() -> Void {
        //Left Buttons
        let leftMenu = UIBarButtonItem(image: UIImage(named: "Menu")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(btnMenuClicked))
        
        let leftSearch = UIBarButtonItem(image: UIImage(named: "Search")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(btnSearchClicked))
        
        self.navigationItem.leftBarButtonItems = [leftMenu, leftSearch]
        
        
        //Right Button
        let rightMore = UIBarButtonItem(image: UIImage(named: "More")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(btnMoreClicked))
        
        self.navigationItem.rightBarButtonItem = rightMore
        
        
        //Title View
        let imageView = UIImageView(image: UIImage(named: "logo_nav")?.withRenderingMode(.alwaysOriginal))
        self.navigationItem.titleView = imageView
    }
    
    
    func btnMenuClicked() -> Void {
        print("Menu Clicked.")
        
        sliderMenu = SliderMenu.getSliderMenuView()
        sliderMenu.delegate = self
        sliderMenu.showSliderMenu(viewCTR: self)
    }
    
    func indexSelectedFromSliderMenu(index: Int) {
        self.view.endEditing(true)
        
        print("Selected Index : \(index)")
    }
    
    func btnSearchClicked() -> Void {
        print("Search Clicked.")
    }

    func btnMoreClicked() -> Void {
        print("More Clicked.")
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 350
        }else if indexPath.section == 1 {
            return 230
        }else if indexPath.section == 2 {
            return 230
        }else if indexPath.section == 3 {
            return 740
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
            headerSection.lblTitleHeader.text = "Latest News"
        }else if section == 1 {
            //Latest News
            headerSection.imageViewIcon.image = UIImage(named: "icn_articles")
            headerSection.lblTitleHeader.text = "Most Read Articles"
        }else if section == 2 {
            //Facebook & Twitter
            headerSection = tableView.dequeueReusableCell(withIdentifier: "CellHeaderFacebookTwitter") as! CellHome
            
            //Set Title
            headerSection.lblTweets.text = "Latest Tweets"
            headerSection.lblFacebookPost.text = "Latest Facebook Post"
        }else if section == 3 {
            //Clubs & Players
            headerSection = tableView.dequeueReusableCell(withIdentifier: "CellClubPlayer") as! CellHome
            
            //Add Target
            headerSection.btnClubs.addTarget(self, action: #selector(btnClubsClicked), for: .touchUpInside)
            headerSection.btnPlayers.addTarget(self, action: #selector(btnPlayersClicked), for: .touchUpInside)
        }else if section == 4 {
            //Polls
            headerSection.imageViewIcon.image = UIImage(named: "icn_vote")
            headerSection.lblTitleHeader.text = "Poll"
        }else if section == 5 {
            //Advertisement
            headerSection.imageViewIcon.image = UIImage(named: "icn_advertisement")
            headerSection.lblTitleHeader.text = "Advertisement"
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
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    
    //MARK: - Clubs 
    func btnClubsClicked() -> Void {
        print("Clubs Clicked")
    }
    
    func btnPlayersClicked() -> Void {
        print("Players Clicked")
    }
}
