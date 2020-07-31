

import UIKit
import Alamofire

typealias ReloadAccauntData = (statusChange: Bool, requiresApprovement: Bool)

class OTApi: NSObject {
    private static let reqestHelper = ReqestHelper()
    private static let clientSecret = "clientSecret"

    // получаем токен в ответ
    // и сразу запрашиваем аккаунт
    static func check(login: String, password: String, completion: @escaping (Bool?, OTError?) -> Void) {
        let endpoint: Endpoint = OTEndpoint.AuthCode.auth

        let parameters: Parameters = ["username": login,
                                      "password" : password,
                                      "client_secret" : OTApi.clientSecret]

        reqestHelper.request(endpoint.url, method: .post, parameters: parameters) { (data, error) in

            if let json = data as? JSON, let tocken = Tokens(JSON: json) {
                DefaultsUtils.save(tokens: tocken)

                OTApi.getAccount(completion: { (answer, error) in
                    if let answer = answer, answer{
                        OTApi.reloadUserFairbaseToken()
                        completion(true, nil)
                    }
                })

            } else if error != nil {

                completion(nil, error)
            }
        }
    }


    //MARK: - USER

    static func getAccount(completion: @escaping (Bool?, OTError?) -> Void) {
        let endpoint: Endpoint = OTEndpoint.User.user

        reqestHelper.request(endpoint.url, method: .get) { (data, error) in
            if let json = data as? JSON, let accaunt = Account(JSON: json), accaunt.isNormAccount {

                CoreDataManager.shared.changeContext(for: "\(accaunt.id)")
                DefaultsUtils.save(account: accaunt)

                completion(true, nil)
            } else {
                completion(nil, error)
            }
        }
    }


    static func deleteDeviseToken(completion: @escaping (Bool?, OTError?) -> Void) {
        let endpoint: Endpoint = OTEndpoint.User.deleteTocken

        let tocken = UIDevice.current.identifierForVendor?.uuidString ?? appDelegateShared.token

        let parameters: Parameters = ["device_udid": tocken]

        reqestHelper.request(endpoint.url, method: .post, parameters: parameters) { (_, _) in
            completion(nil, nil)
        }
    }


    static func reloadPushDataAccount(newData: ReloadAccauntData, completion: @escaping (Bool?, OTError?) -> Void) {
        let endpoint: Endpoint = OTEndpoint.User.user

        let parameters: Parameters = ["notify_on_task_status_change": newData.statusChange,
                                      "notify_on_task_requires_approvement": newData.requiresApprovement]

        reqestHelper.request(endpoint.url, method: .put, parameters: parameters) { (data, error) in
            if let json = data as? JSON, let accaunt = Account(JSON: json), accaunt.isNormAccount {
                DefaultsUtils.save(account: accaunt)
                completion(true, nil)
            } else {
                completion(nil, error)
            }
        }
    }

    static func reloadUserFairbaseToken() {

        let endpoint: Endpoint = OTEndpoint.User.updateTocken

        var parameters: Parameters = ["device_token": appDelegateShared.token,
                                      "device_type": "IOS"]


        if let deviceId = UIDevice.current.identifierForVendor?.uuidString {
            print("UDID \(deviceId)")
            parameters["device_udid"] = deviceId
        }


        reqestHelper.request(endpoint.url, method: .post, parameters: parameters) { (answer, error) in

            if let answer = answer {
                print(answer)
            }
            if let error = error {
                print(error)
            }

        }
    }


    //MARK: - Notification

    static func notificationGet(completion: @escaping ([NotificationModel]?, OTError?) -> Void) {

        let endpoint: Endpoint = OTEndpoint.Notifications.notifications

        var parameters: Parameters = [:]

        if let search = MainViewController.searchTextNotification {
            parameters["search"] = search
        }

        reqestHelper.request(endpoint.url, method: .get, parameters: parameters) { (data, error) in

            if let data = data as? [JSON], let returnArray = NotificationModel.findCreateArray(json: data){
                completion(returnArray, nil)
            } else {
                completion(nil, nil)
            }
        }
    }



    static func notificationDelete(id: Int32, completion: @escaping (Bool?, OTError?) -> Void) {

        let url = OTEndpoint.Notifications.notifications.url + "/\(id)"

        reqestHelper.request(url, method: .delete, parameters: nil) { (data, _) in
            if data != nil {
                completion(true, nil)
            } else {
                completion(nil, nil)
            }
        }
    }

    static func notificationRead(id: Int32, completion: @escaping (NotificationModel?, OTError?) -> Void) {

        let url = OTEndpoint.Notifications.notifications.url + "/\(id)"

        reqestHelper.request(url, method: .get, parameters: nil) { (data, _) in

            if let data = data as? JSON, let notif = NotificationModel.findCreate(json: data){
                completion(notif, nil)
            }
        }
    }


    static func notificationCount(completion: @escaping (Int, OTError?) -> Void) {

        let url = OTEndpoint.Notifications.notificationsCount.url

        reqestHelper.request(url, method: .get, parameters: nil) { (data, _) in

            if let data = data as? Int {
                completion(data, nil)
            } else {
                completion(0, nil)
            }


        }
    }



    //MARK: - Tasks

    static func getTasks(favorite: Bool? = nil,
                         archive: Bool? = nil,
                         completion: @escaping ([Task]?, OTError?) -> Void) {

        var endpoint = OTEndpoint.Task.tasks.url + "?"

        if let favorite = favorite {
            let text = favorite ? "1" : "0"
            endpoint += "favorite=\(text)&"

        }

        if let archive = archive {
            let text = archive ? "1" : "0"
            endpoint += "archive=\(text)&"
        }

        if let search = MainViewController.searchText {

            endpoint += "search=\(search)&"

        }

        if let filterParametrs = ManagerFilters.shared.parametrs {
            for (key, value) in filterParametrs {
                if key.contains("["), let first = key.components(separatedBy: "[").first {
                    endpoint += "\(first)=\(value)&"
                }
            }
        }


        reqestHelper.request(endpoint, method: .get, parameters: nil) { (data, error) in

            if let data = data as? [JSON], let arrayTask = Task.findCreateArray(json: data){
                completion(arrayTask, nil)
            } else if let error = error{
                completion(nil, error)
            } else {
                completion([], nil)
            }
        }
    }

    static func getTasksFull(id: Int32, completion: @escaping (TaskFull?, OTError?) -> Void) {

        let url = OTEndpoint.Task.tasks.url + "/\(id)"

        reqestHelper.request(url, method: .get, parameters: nil) { (data, error) in

            if let data = data as? JSON, let taskFull = TaskFull.findCreate(json: data){
                completion(taskFull, nil)
            } else {
                completion(nil, error)
            }
        }
    }


    static func reloadTaskFavorite(id: Int32, completion: @escaping (Task?, OTError?) -> Void) {

        /*
         я не знаю какого, но просто через запрос по изменению статуса не всегда меняет
         поэтому запрос в запросе
         */

        let url = OTEndpoint.Task.tasks.url + "/\(id)/fave"

        reqestHelper.request(url, method: .post, parameters: nil) { (data, error) in

            if let data = data as? JSON, let value = data["is_favorite"] as? Bool{
                print("пришло -----------------------------")
                print(value)
            }


            if let error = error {
                completion(nil, error)
            } else if let data = data as? JSON, let task = Task.findCreate(json: data) {
                completion(task, nil)
            }
        }
    }

    //согласовать

    static func reloadAproveTask(id: Int32,
                                 text: String?,
                                 keyBakend: String?,
                                 completion: @escaping (TaskFull?, OTError?) -> Void) {

        let url = OTEndpoint.Task.tasks.url + "/\(id)/approve"

        var parameters: Parameters = [:]

        if let text = text {
            parameters["comment"] = text
        }

        if let keyBakend = keyBakend {
            parameters["disposition"] = keyBakend
        }

        reqestHelper.request(url, method: .post, parameters: parameters) { (data, error) in

            if let data = data as? JSON, let task = TaskFull.findCreate(json: data){
                completion(task, nil)
            } else {
                completion(nil, error)
            }
        }
    }


    //отклонить

    static func reloadDeclineTask(id: Int32,
                                  text: String,
                                  keyBakend: String?,
                                  completion: @escaping (TaskFull?, OTError?) -> Void) {

        let url = OTEndpoint.Task.tasks.url + "/\(id)/decline"

        var parameters: Parameters = ["comment" : text]

        if let keyBakend = keyBakend {
            parameters["disposition"] = keyBakend
        }

        reqestHelper.request(url, method: .post, parameters: parameters) { (data, error) in

            if let data = data as? JSON, let task = TaskFull.findCreate(json: data){
                completion(task, nil)
            } else {
                print("---------------------------------------------------")
                print(error?.message)
                completion(nil, error)
            }
        }
    }



    //MARK - FILTERS

    static func getFiltersList(completion: @escaping (Any?, OTError?) -> Void) {

        let endpoint: Endpoint = OTEndpoint.Filters.filters

        reqestHelper.request(endpoint.url, method: .get, parameters: nil) { (data, error) in

            if let data = data as? [JSON] {
                var returnArray = [Filter]()

                for obj in data {
                    if let filtr = Filter(JSON: obj){
                        returnArray.append(filtr)
                    }
                }

                ManagerFilters.shared.chekNewFilter(returnArray)

                completion(nil, nil)
            } else {
                completion(nil, error)
            }
        }
    }


    static func getFiltersListValues(filter: Filter, completion: @escaping ([FilterValues]?, OTError?) -> Void) {

        let url = OTEndpoint.Filters.filters.url + "/\(filter.id)/values"

        reqestHelper.request(url, method: .get, parameters: nil) { (data, error) in

            if let data = data as? [JSON] {
                var returnArray = [FilterValues]()

                for obj in data {
                    if let task = FilterValues(JSON: obj){
                        returnArray.append(task)
                    }
                }

                returnArray = returnArray.filter({$0.sortedValue > $0.sortedValue})

                completion(returnArray, nil)
            } else {
                completion(nil, error)
            }
        }
    }

}



