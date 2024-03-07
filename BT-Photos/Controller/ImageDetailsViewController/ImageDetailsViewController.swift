





import UIKit
import Alamofire


class ImageDetailsViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var ThumbNailImageView: UIImageView!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var AlbumID: UILabel!
    @IBOutlet weak var ID: UILabel!
    @IBOutlet weak var ImageTitle: UILabel!

    // MARK: - Properties

    var imageDict : Photo?

    override func viewDidLoad() {
        super.viewDidLoad()

        // --------------------- Configure thumbnail image view with rounded corners ---------------------
        
        ThumbNailImageView.layer.cornerRadius = 10
        ThumbNailImageView.clipsToBounds = true

        // -------------------------- Configure main image view with rounded corners ---------------------
        
        ImageView.layer.cornerRadius = 10
        ImageView.clipsToBounds = true
        
        // ----------------------------- Load and display thumbnail image --------------------------------
        
        var thumbnailImageURLString = "emptyImageURL"
        if let imageURL = imageDict?.thumbnailUrl as? String {
            if imageURL.count > 0 {
                thumbnailImageURLString = imageURL
            }
        }
        let placeholderImage = UIImage(named: "loader")
        if let thumbnailImageURL = URL(string: thumbnailImageURLString) {
     
            self.ThumbNailImageView.hnk_setImageFromURL(thumbnailImageURL, placeholder: placeholderImage)
        }
        
        
        // ------------------------------ Load and display main image ---------------------------------------
        
        var imageURLString = "emptyImageURL"
        if let imageURL = imageDict?.url as? String {
            if imageURL.count > 0 {
                imageURLString = imageURL
            }
        }
        
        if let mainImageURL = URL(string: imageURLString) {
            
            // ---------------------------  asynchronous Image Loading --------------------------------------
            
            self.ImageView.hnk_setImageFromURL(mainImageURL, placeholder: placeholderImage)
            
            // -------------------------------- synchronous Image Loading -----------------------------------
            
            
//            let data = try? Data(contentsOf: mainImageURL)
//            if let imageData = data {
//                let image = UIImage(data: imageData)
//                self.ImageView.image = image
//            }
            
            
        }

        // --------------------------- Set labels with corresponding data from imageDict ---------------------
        
        AlbumID.text = String((imageDict?.albumId as? Int)!)
        ID.text = String((imageDict?.id as? Int)!)
        ImageTitle.text = imageDict?.title as? String
        
    }

    // MARK: - Button Actions

    
    // --------- Action triggered when the "Back" button is tapped.---------------------------
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
