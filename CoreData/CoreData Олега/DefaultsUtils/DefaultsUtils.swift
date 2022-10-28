//
//  DefaultsUtils.swift
//  Ceorooms
//
//  Created by Oleg Matveev on 24/12/2018.
//

import Foundation
import UIKit

enum DefaultsKey: String {
    case currentAccount
    case accounts
    case sessionID
}

class DefaultsUtils: NSObject {
    private static func defaults() -> UserDefaults {
        return UserDefaults.standard
    }

    static func accountDefaults() -> UserDefaults? {
        guard let ID = currentAccount()?.id else {
            return nil
        }

        return UserDefaults(suiteName: "com.ginzaGO.\(ID)")
    }

    func deleteAllKey () {
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
    }
}

extension DefaultsUtils {
    static func sessionID() -> String? {
        return defaults().string(forKey: DefaultsKey.sessionID.rawValue)
    }

    static func set(sessionID: String?) {
        if let id = sessionID {
            defaults().set(id, forKey: DefaultsKey.sessionID.rawValue)
        } else {
            defaults().removeObject(forKey: DefaultsKey.sessionID.rawValue)
        }
    }

    static func set(currentAccount: Account?) {
        let id = currentAccount?.id

        if let account = currentAccount {
            self.save(account: account)
        }

        defaults().set(id, forKey: DefaultsKey.currentAccount.rawValue)
    }

    static func currentAccount() -> Account? {
        guard let ID = defaults().object(forKey: DefaultsKey.currentAccount.rawValue) as? Int else {
            return nil
        }

        return accountWith(ID: ID)
    }

    static func save(account: Account) {
        let json = defaults().array(forKey: DefaultsKey.accounts.rawValue) as? [JSON] ?? []
        var accounts = json.compactMap({ Account(JSON: $0) })

        if let index = accounts.firstIndex(where: { $0.id == account.id }) {
            accounts.remove(at: index)
            accounts.insert(account, at: index)
        } else {
            accounts.append(account)
        }

        defaults().set(accounts.map { $0.toJSON() }, forKey: DefaultsKey.accounts.rawValue)
    }

    static func deleteAccountAndSession() {
        defaults().removeObject(forKey: DefaultsKey.accounts.rawValue)
        defaults().removeObject(forKey: DefaultsKey.sessionID.rawValue)
        defaults().removeObject(forKey: DefaultsKey.currentAccount.rawValue)
    }

    static func accountWith(ID: Int) -> Account? {
        if let accountsJSON = defaults().array(forKey: DefaultsKey.accounts.rawValue) as? [JSON] {
            for accountJSON in accountsJSON {
                if let account = Account(JSON: accountJSON), account.id == ID {
                    return account
                }
            }
        }

        return nil
    }
}

extension DefaultsUtils {
    private static func archive(object: Any) -> Data {
        return NSKeyedArchiver.archivedData(withRootObject: object)
    }

    private static func unrchive(data: Data) -> Any? {
        return NSKeyedUnarchiver.unarchiveObject(with: data)
    }
}
