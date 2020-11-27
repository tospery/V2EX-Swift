//
//  StorageExt.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

extension Storage where T == String {

    static let shared: Storage! = try? Storage(
        diskConfig: DiskConfig.init(name: "shared"),
        memoryConfig: MemoryConfig.init(),
        transformer: TransformerFactory.forCodable(ofType: T.self)
    )

}

