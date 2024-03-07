

import UIKit

protocol AlbumNavigationDelegate {
    func didRequestPreviousAlbum()
    func didRequestNextAlbum()
}

class LoadMoreCell: UITableViewCell {

    // MARK: - Properties

    var albumNavigationDelegate: AlbumNavigationDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
    }

    // MARK: - Button Actions

    
    //-----------  Action triggered when the "Previous" button is tapped.Notifies the delegate method -------------------------

    
    @IBAction func previousButtonAction(_ sender: Any) {
        albumNavigationDelegate?.didRequestPreviousAlbum()
    }

    
    //-----------  Action triggered when the "Next" button is tapped.Notifies the delegate method ----------------------------

    @IBAction func nextButtonAction(_ sender: Any) {
        albumNavigationDelegate?.didRequestNextAlbum()
    }
}
