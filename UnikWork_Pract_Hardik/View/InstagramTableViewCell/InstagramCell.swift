
import UIKit
import SDWebImage

class InstagramCell: UITableViewCell {
    
    //MARK:- All Outlets
    @IBOutlet weak var UserProfilePhotoImageView: UIImageView!
    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var UserPostImageCollectionView: UICollectionView!
    @IBOutlet weak var LikeButton: UIButton!
    @IBOutlet weak var CommentButton: UIButton!
    @IBOutlet weak var LikeLabel: UILabel!
    @IBOutlet weak var ViewAllCommentButton: UIButton!
    @IBOutlet weak var ShareButton: UIButton!
    @IBOutlet weak var PostCreateTimeLabel: UILabel!
    @IBOutlet weak var UserPostHashTagLabel: UILabel!
    @IBOutlet weak var ImagePageController: UIPageControl!
    @IBOutlet weak var UserPostDescriptionLabel: UILabel!
    
    //MARK:- Store all Post Images
    var postImagesArray = [String]() {
        didSet{
            self.UserPostImageCollectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.registerCollectionViewCell()
        self.setupCollectionView()
        
    }
    
    //MARK:- Register collectionview cell
    func registerCollectionViewCell(){
        self.UserPostImageCollectionView.register(UINib(nibName: COLLECTIONVIEW_CELL_IDENT, bundle: nil), forCellWithReuseIdentifier: COLLECTIONVIEW_CELL_IDENT)
    }
    
    //MARK:- setup view
    func setupCollectionView(){
        self.UserPostImageCollectionView.delegate = self
        self.UserPostImageCollectionView.dataSource = self
        
        self.UserProfilePhotoImageView.layer.cornerRadius = self.UserProfilePhotoImageView.frame.size.height/2
        self.UserProfilePhotoImageView.layer.masksToBounds = true
        self.UserProfilePhotoImageView.layer.borderWidth = 1
        self.UserProfilePhotoImageView.layer.borderColor = UIColor.gray.cgColor
        
        self.UserPostImageCollectionView.layer.borderWidth = 1
        self.UserPostImageCollectionView.layer.borderColor = UIColor.gray.cgColor
    }
    
    //MARK:- set data to cell
    func configCellData(data:InstagramData){
        //DispatchQueue.main.async {
        
        //Load User Profile Image
        if data.user != nil && data.user?.profile != nil{
            self.UserProfilePhotoImageView.sd_setImage(with: URL(string: data.user!.profile!), placeholderImage: UIImage(named: "placeholder.png"))
        }
        
        //Load UserName
        self.UserNameLabel.text = data.user?.name
        
        //Get User Post Images
        self.postImagesArray = data.images ?? []
        
        //Load User Like
        self.LikeLabel.text = "\(data.likes ?? 0) Likes"
        
        //Load User Comment
        let title = "View all \(data.comments?.count ?? 0) comments"
        self.ViewAllCommentButton.setTitle(title, for: .normal)
        
        //Load Post Time
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd' 'HH':'mm':'ss"
        if data.date_time != nil{
            let date = dateFormatter.date(from: data.date_time!)
            dateFormatter.dateFormat = "MM-dd-yyyy hh:mm:ss a"
            self.PostCreateTimeLabel.text = dateFormatter.string(from: date!)
            
            //This is Time ago From Current Date
            //self.PostCreateTimeLabel.text = date?.timeAgoSinceDate()
        }
        //User Description
        self.UserPostDescriptionLabel.text = data.descriptions ?? ""
        self.UserPostHashTagLabel.text = data.hashtags ?? ""
        //}
    }
    
    //MARK:- Like button action
    @IBAction func likeButtonAction(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.tintColor = UIColor.red
        }else{
            sender.tintColor = UIColor.black
        }
    }
    @IBAction func ShowAllCommentClickButtonAction(_ sender: UIButton) {
        
    }
}


//MARK:- CollectionView delegate and Datasource
extension InstagramCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.postImagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell:ImageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:COLLECTIONVIEW_CELL_IDENT , for: indexPath) as? ImageCollectionViewCell{
            
            if postImagesArray.count > indexPath.row{
                cell.configCollectionView(urlString: postImagesArray[indexPath.row])
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.contentView.frame.size.width, height: self.contentView.frame.size.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    //MARK:- PageController 
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.ImagePageController.numberOfPages = postImagesArray.count
        self.ImagePageController.currentPage = indexPath.row
        
    }
}

extension Date {
    
    func timeAgoSinceDate() -> String {
        
        // From Time
        let fromDate = self
        
        // To Time
        let toDate = Date()
        
        // Estimation
        // Year
        if let interval = Calendar.current.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + "year ago" : "\(interval)" + " " + "years ago"
        }
        
        // Month
        if let interval = Calendar.current.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + "month ago" : "\(interval)" + " " + "months ago"
        }
        
        // Day
        if let interval = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + "day ago" : "\(interval)" + " " + "days ago"
        }
        
        // Hours
        if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {
            
            return interval == 1 ? "\(interval)" + " " + "hour ago" : "\(interval)" + " " + "hours ago"
        }
        
        // Minute
        if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {
            
            return interval == 1 ? "\(interval)" + " " + "minute ago" : "\(interval)" + " " + "minutes ago"
        }
        
        return "a moment ago"
    }
}
