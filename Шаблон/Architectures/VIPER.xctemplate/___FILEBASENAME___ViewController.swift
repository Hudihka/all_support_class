//___FILEHEADER___

import UIKit
import SMBCoreUI

protocol ___VARIABLE_productName:identifier___ViewControllerProtocol: BaseViewController {
}

class ___VARIABLE_productName:identifier___ViewController: BaseViewController, ___VARIABLE_productName:identifier___ViewControllerProtocol {
    private let presenter: ___VARIABLE_productName:identifier___PresenterProtocol

    // MARK: - Initialization

    required init(presenter: ___VARIABLE_productName:identifier___PresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
