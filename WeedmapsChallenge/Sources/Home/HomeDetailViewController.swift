//
//  Copyright © 2018 Weedmaps, LLC. All rights reserved.
//

import UIKit
import WebKit


class HomeDetailViewController: UIViewController {

    // MARK: Properties
    
    private var webView = WKWebView()
    
    // MARK: Control
    
    func configure(with business: Business) {
        if let url = URL(string: business.url ?? "") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    override func loadView() {
        super.loadView()
        self.view = webView
    }
}
