
import UIKit
import SDWebImage

class ImageCollectionViewCell: UICollectionViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var postImagesImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK:- Load post images in view
    func configCollectionView(urlString: String){
        DispatchQueue.main.async {
            //Load Post Image
            self.postImagesImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.postImagesImageView.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "placeholder.png"))
        }
    }
}


