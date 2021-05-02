

import UIKit

internal class BitcoinViewController: UIViewController {
  
  @IBOutlet weak private var checkAgain: UIButton!
  @IBOutlet weak private var primary: UILabel!
  @IBOutlet weak private var partial: UILabel!
	
	let networking = HTTPNetworking()
  
  private let dollarsDisplayFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.maximumFractionDigits = 0
    formatter.numberStyle = .currency
    formatter.currencySymbol = ""
    formatter.currencyGroupingSeparator = ","
    return formatter
  }()
  
  private let standardFormatter = NumberFormatter()
  
  // MARK: - View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    requestPrice()
  }

  // MARK: - Actions
  @IBAction private func checkAgainTapped(sender: UIButton) {
    requestPrice()
  }
  
  // MARK: - Private methods
  private func updateLabel(price: Price) {
    guard let dollars = price.components().dollars,
          let cents = price.components().cents,
          let dollarAmount = standardFormatter.number(from: dollars) else { return }
    
    primary.text = dollarsDisplayFormatter.string(from: dollarAmount)
    partial.text = ".\(cents)"
  }
  
	private func requestPrice()  {
		
		networking.request(from: Coinbase.bitcoin) { data, error in
			// 1. Check for errors
			if let error = error {
				print("Error received requesting Bitcoin price: \(error.localizedDescription)")
				return
			}

			// 2. Parse the returned information
			let decoder = JSONDecoder()
			guard let data = data,
						let response = try? decoder.decode(PriceResponse.self, from: data)
			else { return }

			print("Price returned: \(response.data.amount)")

			// 3. Update the UI with the parsed PriceResponse
			DispatchQueue.main.async { [weak self] in
				self?.updateLabel(price: response.data)
			}
		}


	}
}
