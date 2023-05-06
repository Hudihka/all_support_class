//
//  RecieptViewController.swift
//  FooDoo.ai
//
//  Created by Hudihka on 12/01/2022.
//  Copyright © 2022 ITMegastar. All rights reserved.
//

import Foundation
import WebKit

final class UrlViewController: UIViewController {
    private enum Constants {
        static let loaderTop: CGFloat = 10
        static let labelSizeOffset: CGFloat = 16
    }
    
    static func recieptViewController(url: String) -> UIViewController {
        let stor = UIStoryboard(name: "Main", bundle: nil)
        let VC = stor.instantiateViewController(withIdentifier: "UrlViewController") as! UrlViewController
        let VM = RecieptViewControllerModel(url: url)

        VC.viewModel = VM

        return VC
    }

    @IBOutlet weak var webView: WKWebView!
    

    var viewModel: (RecieptViewControllerProtocolIn & RecieptViewControllerProtocolOut)?

    override func viewDidLoad() {
        super.viewDidLoad()
        desingUI()
        lissenModel()
        
        viewModel?.fetchData()
    }

    func desingUI() {

        webView.navigationDelegate = self
 
    }

    func lissenModel() {
        guard var viewModel = viewModel else {
            return
        }

        viewModel.content = { [weak self] url in
            guard
                let self = self,
                let url = url
            else {
                return
            }

            self.webView.load(URLRequest(url: url))
            self.webView.allowsBackForwardNavigationGestures = true
        }
    }
}

extension UrlViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        didFinish: WKNavigation!
    ) {
        
//        tickets-list with-topics single-ticket-list
        
        webView.evaluateJavaScript("document.documentElement.outerHTML.toString()",
                                   completionHandler: { (html: Any?, error: Error?) in
            print(html)
        })
    }
}
