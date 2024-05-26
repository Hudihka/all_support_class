//
//  IlandAlgoritm.swift
//  test
//
//  Created by Константин Ирошников on 20.10.2022.
//

//import Foundation
//
//final class IlandAlgoritm {
//    let arrays =
//    [
//    [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
//    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
//    [1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
//    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
//    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
//    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1],
//    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1],
//    [1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1],
//    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
//    ]
//
//
//    var algoritm: Int {
//        var arraysCord = [Cordinats]()
//
//        for (indI, objI) in arrays.enumerated() {
//            for (indJ, objJ) in objI.enumerated() {
//                if objJ == 0 {
//                    let cord = Cordinats(i: indI, j: indJ)
//                    arraysCord.append(cord)
//                }
//            }
//        }
//
//        var ilands = [[Cordinats]]()
//
//        for cord in arraysCord {
//            if let firstIndex = ilands.firstIndex(where: { $0.isConteinsNear(ellement: cord) }) {
//                ilands[firstIndex].append(cord)
//            } else {
//                ilands.append([cord])
//            }
//        }
//
//
//
//        return ilands.count
//    }
//
//}
//
//struct Cordinats: Hashable {
//    let i: Int
//    let j: Int
//}
//
//extension Array where Element == Cordinats {
//    func isConteinsNear(ellement: Cordinats) -> Bool {
//        self.contains(where: { $0 ~= ellement })
//    }
//}
//
//infix operator ~=
//extension Cordinats {
//    static func ~=(lhs: Cordinats, rhs: Cordinats) -> Bool {
//        if lhs.i == rhs.i {
//            return abs(lhs.j - rhs.j) == 1
//        } else if lhs.j == rhs.j {
//            return abs(lhs.i - rhs.i) == 1
//        }
//
//        return false
//    }
//}
//
//extension Collection {
//    subscript (safe index: Index) -> Element? {
//        return indices.contains(index) ? self[index] : nil
//    }
//}
//
//
//
//
//
//extension Character {
//    var isInt: Bool {
//        Int(String(self)) != nil
//    }
//}
//
////class Trecker {
////    private init() {}
////
////    static let shared = Trecker()
////
////    func trackEvent(_ event: String)
////}
////
////private class Test {
////    func event() {
////        Trecker.shared.trackEvent("test")
////    }
////}
//
//
func bestAnimals(from animalsInfo: [String: [String]]) -> [String] {
    var animals = [String]()

    for (key, _) in animalsInfo {
        guard let info = animalsInfo[key] else {
                continue
        }

        animals.append(contentsOf: info.sorted(by: {(lhs: String, rhs: String) -> Bool in
            return lhs > rhs
        }))
    }

    animals = animals.compactMap { animal in
        return animal.count > 3 ? animal : nil
    }.sorted(by: <)


    return animals
}
//
//let a = MyOptional.none
//let b = MyOptional.none
//
//
//if a == b {
//    print("000")
//} else {
//    print("111")
//}
