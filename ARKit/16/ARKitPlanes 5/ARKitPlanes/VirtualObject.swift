//
//  VirtualObject.swift
//  ARKitPlanes
//
//  Created by Ivan Akulov on 06/01/2018.
//  Copyright © 2018 Ivan Akulov. All rights reserved.
//

import SceneKit

class VirtualObject: SCNReferenceNode {

    //здесь мы достаем все обьектты scn из папки art.scnnassets
    //поттом обращаемся к каждомы по индексу

    static let availableObjects: [SCNReferenceNode] = {

        //залазием в папку проекта "art.scnassets"

        guard let modelsURLs = Bundle.main.url(forResource: "art.scnassets", withExtension: nil) else { return [] }

        //берем все файлы из этой папки
        let fileEnumirator = FileManager().enumerator(at: modelsURLs, includingPropertiesForKeys: nil)!

        //получаем все не нил обьектты что имеютт разрешение "scn"
        return fileEnumirator.compactMap{ element in
            let url = element as! URL

            guard url.pathExtension == "scn" else { return nil }

            return VirtualObject(url: url)
        }
    }()
}
