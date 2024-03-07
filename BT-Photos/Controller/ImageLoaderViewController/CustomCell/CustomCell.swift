




import UIKit
import Alamofire

class CustomCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet weak var ImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // ---------------------------------Configure the image view with rounded corners---------------------------------------
        
        ImageView.layer.cornerRadius = 10
        ImageView.layer.masksToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    // MARK: - Image Loading

    // ----------------------This method loads the image from the provided URL and sets it in the cell's image view.------------
  
    func getImageData(imageData: String) {
        
        var imageurl = "emptyImageURL"

        // ---------------------------------Check if the provided imageURL is a valid string-------------------------------------
        if let imageURL = imageData as? String {
            // ----------------------Check if the imageURL has a sufficient length-----------------------------------------------
            if imageURL.count > 0 {
                imageurl = imageURL
            }
        }

        // ------------------------Use a placeholder image named "loader" if the imageURL is invalid or too short----------------
        let image = UIImage(named: "loader")

        // ----------------------------------------Create a URL from the imageurl string-----------------------------------------
        let url = URL(string: imageurl)!

        // ---------------------------------Set the image in the image view using AlamofireImage---------------------------------
        self.ImageView.hnk_setImageFromURL(url, placeholder: image)
 
        
    }
}
