




import UIKit
import Alamofire
import iProgressHUD

class ImageLoaderViewController: UIViewController, AlbumNavigationDelegate {

    // MARK: - Outlets and Properties
    
    @IBOutlet weak var ImageLoaderTableView: UITableView!
    
    var totalRecordsArray = [Photo]()
    var flagValue = false    // controlling the visibility of the "Load More" cell
    
    var albumID = 1   // API Input albumId
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up TableView======================
        ImageLoaderTableView.delegate = self
        ImageLoaderTableView.dataSource = self
        self.navigationController?.navigationBar.isHidden = true
        
        // Register CustomCell with TableView
        ImageLoaderTableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        ImageLoaderTableView.register(UINib(nibName: "LoadMoreCell", bundle: nil), forCellReuseIdentifier: "LoadMoreCell")
        
        // Check for network reachability
        if !(NetworkReachabilityManager()?.isReachable ?? false) {
            showAlertView(alertTitle: "", message: "No Network Connection")
            return
        }
        
        fetchData(forAlbumID: albumID, previous_next_bool: 0)  // Calling webServices
    }

    // MARK: - Data Fetching
    
    // Function to fetch data from the API
    func fetchData(forAlbumID albumID: Int, previous_next_bool: Int) {
        let urlString = "https://jsonplaceholder.typicode.com/albums/\(albumID)/photos"
        
        // iProgressLoader setup
        let iprogress: iProgressHUD = iProgressHUD()
        iprogress.iprogressStyle = .horizontal
        iprogress.indicatorStyle = .orbit
        iprogress.isShowModal = false
        iprogress.boxSize = 50
        
        iprogress.attachProgress(toViews: view)
        view.showProgress()  // Show the Loader
        
        // Alamofire request for data fetching
        AF.request(urlString, method: .get, parameters: nil, encoding: URLEncoding(destination: .httpBody), headers: nil).response { response in
            switch response.result {
            case .success(let data):
                // Hide the Loader
                self.view.dismissProgress()
                // Parse JSON data and update UI
                     if let data = data {
                         do {
                             let decoder = JSONDecoder()
                             let recordsArray = try decoder.decode([Photo].self, from: data)
                             self.flagValue = true
                             
                             if previous_next_bool == 1 {
                                 self.totalRecordsArray.removeLast(100)
                             }
                             
                             if recordsArray.count > 0 {
                                 for i in 0..<recordsArray.count {
                                     let dict = recordsArray[i]
                                     self.totalRecordsArray.append(dict)
                                 }
                             }
                            
                             // Update UI with fetched data (e.g., reload collection view)
                             DispatchQueue.main.async {
                                 self.ImageLoaderTableView.reloadData()
                             }
        
                         }
                         catch {
                             // Handle JSON parsing error
                             print("Error parsing JSON: \(error.localizedDescription)")
                             self.showAlertView(alertTitle: "Error", message: error.localizedDescription)
                         }
                     }

            case .failure(let error):
                // Hide the Loader
                self.view.dismissProgress()
                let error = error.localizedDescription
                print("error------\(error)")
                self.showAlertView(alertTitle: "Error", message: "An unexpected error occurred. Please try again later.")
            }
        }
    }
    
    // MARK: - AlbumNavigationDelegate Methods
    
    // ---------------------------Called when the Previous Button is clicked ---------------------------------------------
    
    func didRequestPreviousAlbum() {
        if self.albumID > 1 {
            // ---------------------------Drecemental API Input ------------------------------------
            albumID = albumID - 1
            fetchData(forAlbumID: albumID, previous_next_bool: 1)
        }
    }
    
    // ------------------------------------------Called when the Next Button is clicked-----------------------------------
    
    func didRequestNextAlbum() {
        // ---------------------------------Incremental API Input------------------------------------
        albumID = albumID + 1
        fetchData(forAlbumID: albumID, previous_next_bool: 0)
    }

    
    // MARK: - Helper Methods
    
    // ------------------------------------ Function to show alert ------------------------------------------------------
    func showAlertView(alertTitle: String, message: String) {
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { _ in })
        alert.addAction(ok)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}

// MARK: - TableView Delegate and DataSource

extension ImageLoaderViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if totalRecordsArray.count > 0 {
                return totalRecordsArray.count
            }
            return 0
        }
        if section == 1 {
            return flagValue ? 1 : 0
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        // ----------------------------------  for Section 0 ------------------------------------------------
        
        if indexPath.section == 0 {
            let imageCell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell

            if totalRecordsArray.count > 0 {
                let imageDict = totalRecordsArray[indexPath.row]
                if let imageURL = imageDict.thumbnailUrl as? String {
                    imageCell.getImageData(imageData: imageURL)
                }
            }

            return imageCell
        }

        // -----------------------------------  for Section 1 -----------------------------------------------
        
        if indexPath.section == 1 {
            let loadMoreCell = tableView.dequeueReusableCell(withIdentifier: "LoadMoreCell", for: indexPath) as! LoadMoreCell
            loadMoreCell.albumNavigationDelegate = self
            return loadMoreCell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 150 : 50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let imageDict = totalRecordsArray[indexPath.row]
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "ImageDetailsViewController") as! ImageDetailsViewController
        vc.imageDict = imageDict
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
