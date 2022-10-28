//
//  Array.swift
//  GinzaGO
//
//  Created by Username on 19.08.2019.
//  Copyright © 2019 Hudihka. All rights reserved.
//

import Foundation

class WeakRef<T> where T: AnyObject {
    private(set) weak var value: T?

    init(value: T?) {
        self.value = value
    }
}

extension Array where Element == WeakRef<AnyObject> {
    mutating func reap () {
        self = self.filter { nil != $0.value }
    }

    func strongify() -> [AnyObject] {
        return self.compactMap { $0.value }
    }
}

extension Collection { //,tpjgfcyjt
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Sequence {
    public func toDictionary<Key: Hashable>(with selectKey: (Iterator.Element) -> Key) -> [Key: Iterator.Element] {
        var dict: [Key: Iterator.Element] = [:]
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
}

extension Array {
    func unique<T: Hashable>(map: ((Element) -> (T))) -> [Element] { //возвращает массив уникальных элементов
        var set = Set<T>()
        var arrayOrdered = [Element]()
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }

        return arrayOrdered
    }

    func getFirstElements(upTo position: Int) -> Array<Element> {  //удаляет элементы в массив е начиная с 0 до position не включая
        let arraySlice = self[0 ..< position]
        return Array(arraySlice)
    }
}

extension Dictionary {
    static func == <K, V>(left: [K:V], right: [K:V]) -> Bool {
        return NSDictionary(dictionary: left).isEqual(to: right)
    }

    static func += <K, V> (left: inout [K:V], right: [K:V]) {
        for (k, v) in right {
            left[k] = v
        }
    }

    mutating func update(other:Dictionary) {
        for (key,value) in other {
                self.updateValue(value, forKey:key)

        }
    }
}
