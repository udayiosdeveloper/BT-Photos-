# BT-Photos iOS App

## Overview

The BT-Photos iOS app is designed to fetch and display photos from a public API, providing a seamless user experience. This README provides essential information for building, running, and understanding the project.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Dependencies](#dependencies)
- [Project Structure](#project-structure)
- [Contributing](#contributing)
- [License](#license)

## Installation

### Prerequisites

- Xcode installed on your development machine.
- [CocoaPods](https://cocoapods.org/) for dependency management (if applicable).

### Steps

1. Clone the repository to your local machine:
   ```bash
   git clone <repository_url>
2. Open the Xcode project:
   ```bash
   open BT-Photos.xcodeproj
3. Install dependencies (if using CocoaPods):
     ```bash
   pod install
4. Build and run the project in Xcode.

## Usage

Launch the app on the simulator or a physical device.
Explore different album IDs using the provided buttons.
Click on images to view additional details.   

## Dependencies

The BT-Photos iOS app relies on the following dependencies:

- **Alamofire:** Used for network requests.
- **iProgressHUD:** Provides an elegant progress indicator.
- **HanekeSwift:** Used for asynchronous image loading.
  
## Project Structure

The project follows a standard iOS app structure, with key components:

- ImageLoaderViewController: Main view controller handling data fetching and display.
- CustomCell: Custom table view cell for image display.
- LoadMoreCell: Table view cell for navigation between albums.
- ImageDetailsViewController: View controller for displaying additional image details.
## Contributing

If you find a bug, have a feature request, or want to contribute, please open an issue or submit a pull request. Contributions are welcome!
