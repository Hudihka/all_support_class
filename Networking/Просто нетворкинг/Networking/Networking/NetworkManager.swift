//
//  NetworkManager.swift
//  Networking
//
//  Created by Alexey Efimov on 11.09.2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.
//

import UIKit


//let session = URLSession.shared
//session.dataTask(with: url) { (data, response, error) //response это ответ ответ

class NetworkManager {
    
    static func getRequest(url: String) {
        
        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            guard let response = response, let data = data else { return }

            print(response)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])// из даты получаем джейсон
                print(json)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    static func postRequest(url: String) {
        
        guard let url = URL(string: url) else { return }
        
        let userData = ["Course": "Networking", "Lesson": "GET and POST"]       //это данные для пост запросов

        //создаем реквест

        var request = URLRequest(url: url)                                      //создаем реквест
        request.httpMethod = "POST"                                             //говорим что он пост
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")//передаем параметры.
                        //application/json и Content-Type эти параметры берутся ответом с секрвера
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: userData, options: []) else { return } //создаем тело запроса, дата по сути из дикш

        request.httpBody = httpBody

        ///////////////////////////////////////////////

        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            guard let response = response, let data = data else { return }
            
            print(response)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])//получаем оттвет с сервера
                print(json)  //если статус код 201 то все хорошо
            } catch {
                print(error)
            }
        } .resume()
    }


    //загрузка изображения по урлу
    static func downloadImage(url: String, completion: @escaping (_ image: UIImage)->()) {
        
        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {  //ну собственно получаем изображение и обновляем в основном потоке
                    completion(image)
                }
            }
        } .resume() //запускаем сессию
    }
    
    static func fetchData(url: String, completion: @escaping (_ courses: [Course])->()) {//здесь мы получаем массив курсов
        
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()                                 //здесь создается декодер
                decoder.keyDecodingStrategy = .convertFromSnakeCase         //fee_fi_fo_fum Преобразует в: feeFiFoFum
                                                                            //после этого ключи получаемые совпадают с ключами модели
                                                                            //но лучше использовать мапер
                let courses = try decoder.decode([Course].self, from: data) //пролучаем массив курсов из даты
                completion(courses)
            } catch let error {
                print("Error serialization json", error)
            }
            
        }.resume()
    }
    
    static func uploadImage(url: String) {                                  //выгрузка изображения
        
        let image = UIImage(named: "Notification")!                         //изображение что отправляем
        let httpHeaders = ["Authorization": "Client-ID 1bd22b9ce396a4c"]    //эти параметры мы получаем при регистрации
        guard let imageProperties = ImageProperties(withImage: image, forKey: "image") else { return }
        
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = httpHeaders
        request.httpBody = imageProperties.data     //получаем дату из изображения
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)                     //здесь мы получаем ответ, здесь ссылку на изображение
                } catch {
                    print(error)
                }
            }
        }.resume()
        
    }
}
