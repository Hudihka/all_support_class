//___FILEHEADER___

import UIKit


final class ___VARIABLE_productName:identifier___ViewController: ViewController {
     private enum Constant {
    }

    private let router: ___VARIABLE_productName:identifier___RouterProtocol
    private let VM: (___VARIABLE_productName:identifier___ViewModelProtocolIn & ___VARIABLE_productName:identifier___ViewModelProtocolOut)

    // MARK: - Initialization

    required init(
	VM: ___VARIABLE_productName:identifier___ViewModelProtocolIn & ___VARIABLE_productName:identifier___ViewModelProtocolOut,
	router: ___VARIABLE_productName:identifier___RouterProtocol
	) {
        self.VM = VM
	self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func desingUI() {
    }

    override func lissenModel() {
    }
}
