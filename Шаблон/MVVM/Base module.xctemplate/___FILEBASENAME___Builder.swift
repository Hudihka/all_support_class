//___FILEHEADER___

import Foundation
import UIKit

protocol ___VARIABLE_productName:identifier___CallBack: AnyObject {
}

final class ___VARIABLE_productName:identifier___Builder {
    static func build() -> ViewController {
        let VM = ___VARIABLE_productName:identifier___ViewModel()
        let router = ___VARIABLE_productName:identifier___Router(dataStore: VM)
        let VC = ___VARIABLE_productName:identifier___ViewController(
            VM: VM,
            router: router
        )
	router.VC = VC

        return VC
    }
}
