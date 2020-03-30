//
//  Copyright © 2018 Weedmaps, LLC. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {

    // MARK: Properties
    
    @IBOutlet private var collectionView: UICollectionView!
    
    private var searchController = UISearchController(searchResultsController: nil)
    private var searchResults = [Business]() {
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    private var searchDataTask: URLSessionDataTask?
    private let sessionProvider = URLSessionProvider()
    private let locationProvider = AppLocationManager()
    private var location = Location.error
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        setupCollectionView()
    }
    
    // MARK: Setup
    
    private func setupSearchController() {
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Businesses"
        searchController.searchBar.scopeButtonTitles = getLocationScopeData()
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: "BusinessCell", bundle: nil), forCellWithReuseIdentifier: "BusinessCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func dataCall(term: String) {
        
        switch location {
        case .coordinates(let latitude, let longitude):
            sessionProvider.request(type: BusinessResponse.self, service: BussinessesAPI.searchTermCoordiantes(searchTerm: term, latitude: String(latitude), longitude: String(longitude))) { (response) in
                switch response {
                case let .success(response):
                    self.searchResults = response.businesses
                case let .failure(error):
                    print(error)
                }
            }
        case .term(let location):
            sessionProvider.request(type: BusinessResponse.self, service: BussinessesAPI.searchTermLocationSearch(searchTerm: term, searchLocation: location)) { [weak self] response in
                switch response {
                case let .success(response):
                    self?.searchResults = response.businesses
                case let .failure(error):
                    print(error)
                }
            }
        case .error:
            print("Error")
            
        }
    }

    // MARK: Navigation
    
    private func goToSafari(url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
    
    private func goToWebView(business: Business) {
        let detailVC = HomeDetailViewController()
        detailVC.configure(with: business)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    private func showAlert(for business: Business) {
        let alert = UIAlertController(title: "View Yelp Page", message: "Please Select an Option", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Open with Safari", style: .default , handler:{ (UIAlertAction)in
            self.goToSafari(url: business.url)
        }))

        alert.addAction(UIAlertAction(title: "Open with in WebView", style: .default , handler:{ (UIAlertAction)in
            self.goToWebView(business: business)
        }))

        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        if let popoverController = alert.popoverPresentationController {
           popoverController.sourceView = self.view
           popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
           popoverController.permittedArrowDirections = []
         }

        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: Helpers
    
    private func getLocationScopeData() -> [String] {
        
        var arrayOfLocations = ["Miami", "New York"]
        if locationProvider.locationAllowed {
            arrayOfLocations.insert("Current Location", at: 0)
        }
        
        return arrayOfLocations
    }
    
    private func setLocationFromScope(text: String?) {
        if let location = text {
            if location == "Current Location" {
                self.location = .coordinates(latitude: locationProvider.currentLatitude, longitude: locationProvider.currentLongitude)
            } else {
                self.location = .term(location)
            }
        }
    }
}

// MARK: UISearchResultsUpdating

extension HomeViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        // IMPLEMENT: Be sure to consider things like network errors
        // and possible rate limiting from the Yelp API. If the user types
        // very quickly, how will you prevent unnecessary requests from firing
        // off? Be sure to leverage the searchDataTask and use it wisely!
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        setLocationFromScope(text: searchBar.scopeButtonTitles?[searchBar.selectedScopeButtonIndex])
        dataCall(term: searchBar.text!)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
       setLocationFromScope(text: searchBar.scopeButtonTitles?[searchBar.selectedScopeButtonIndex])
       dataCall(term: searchBar.text!)
    }
}

// MARK: UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        showAlert(for: searchResults[indexPath.row])
    }
}

// MARK: UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        cell.setupCellWith(business: searchResults[indexPath.row])
        
        return cell
    }
}
