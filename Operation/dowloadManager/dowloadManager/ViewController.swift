//
//  ViewController.swift
//  dowloadManager
//
//  Created by Hudihka on 04/06/2021.
//  Copyright © 2021 OOO MegaStar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//	https://coolwallpapers.me/picsup/5620135-ice-wallpapers.jpg
	@IBOutlet weak var spiner: UIActivityIndicatorView!
	@IBOutlet weak var labelStatistic: UILabel!
//	https://stackoverflow.com/questions/34261309/how-to-pause-nsurlsessiondownloadtask/34261734
	

	var defaultSession: URLSession!
	var downloadTask: URLSessionDownloadTask!
	var resumeData: Data?
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
	
	}
	
	func load(){
		if let url = URL(string: "https://coolwallpapers.me/picsup/5620135-ice-wallpapers.jpg"){
			spiner.startAnimating()
			fetchFile(url: url)
		}
	}
	
	func fetchFile(url: URL) {
		
		defaultSession = Foundation.URLSession(configuration: .default, delegate: self, delegateQueue: nil)
		downloadTask = defaultSession.downloadTask(with: url)
		downloadTask.resume()
		
	 }
	
	@IBAction func goButton(_ sender: Any) {
		
		load()
		
	}
	
	@IBAction func playPayse(_ sender: Any) {
		
		if spiner.isAnimating {
			pause()
		} else {
			play()
		}
		
		
	}
	
	private func pause(){
		downloadTask.cancel(byProducingResumeData: {[weak self] data in
		  self?.resumeData = data
		})
		spiner.stopAnimating()
	}
	
	
	private func play(){
		if let resumeData = resumeData {
			downloadTask = defaultSession.downloadTask(withResumeData: resumeData)
			downloadTask.resume()
			spiner.startAnimating()
		} else {
		  load()
		}

	}

}

extension ViewController: URLSessionDelegate, URLSessionDataDelegate, URLSessionDownloadDelegate {
	
	func urlSession(_ session: URLSession,
					downloadTask: URLSessionDownloadTask,
					didWriteData bytesWritten: Int64,
					totalBytesWritten: Int64,
					totalBytesExpectedToWrite: Int64) {

		DispatchQueue.main.async {
			let progress = Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)
			self.labelStatistic.text = "\(progress)"
		}
	}
	

	  func urlSession(_ session: URLSession,
					  downloadTask: URLSessionDownloadTask,
					  didFinishDownloadingTo location: URL) {
		print(downloadTask.originalRequest?.url)
		
		
		print("Finished downloading to \(location).")
	  }
	
	func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
		
	}

	
}
