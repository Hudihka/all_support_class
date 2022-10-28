//
//  type_erasure.swift
//  type_erasure
//
//  Created by Константин Ирошников on 14.06.2022.
//

import Foundation

protocol ObjectMapper {

    associatedtype SourceType

    associatedtype ResultType

    func map(_ object: SourceType) -> ResultType

}


struct AnyObjectMapper<SourceType, ResultType>: ObjectMapper {

    private let _box: _AnyMapperBox<SourceType, ResultType>

    init<MapperType: ObjectMapper>(_ mapper: MapperType) where MapperType.SourceType == SourceType, MapperType.ResultType == ResultType {
        _box = _MapperBox(mapper)
    }

    func map(_ object: SourceType) -> ResultType {
        return _box.map(object)
    }

}


class _AnyMapperBox<SourceType, ResultType>: ObjectMapper {

    func map(_ object: SourceType) -> ResultType {
        fatalError("This method is abstract")
    }

}


class _MapperBox<Base: ObjectMapper>: _AnyMapperBox<Base.SourceType, Base.ResultType> {

    private let _base: Base

    init(_ base: Base) {
        _base = base
    }

    override func map(_ object: Base.SourceType) -> Base.ResultType {
        return _base.map(object)
    }

}


class Article { }

typealias ArticleDict = [AnyHashable: Any]

class ArticleMapper: ObjectMapper {
    func map(_ object: ArticleDict) -> Article {
        // Mapping...
        return Article()
    }
}

class ArticleService {
    var mapper: AnyObjectMapper<ArticleDict, Article>!
}
