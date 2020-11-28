//
//  ProviderType+Networking.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

let networking = Networking(
    provider: MoyaProvider<MultiTarget>(
        endpointClosure: Networking.endpointClosure,
        requestClosure: Networking.requestClosure,
        stubClosure: Networking.stubClosure,
        callbackQueue: Networking.callbackQueue,
        session: Networking.session,
        plugins: Networking.plugins,
        trackInflights: Networking.trackInflights
    )
)

extension SWFrame.ProviderType {
    
    // MARK: - V2EXAPI
    /// V2EX网站信息：https://www.v2ex.com/api/site/info.json
    func siteInfo() -> Single<SiteInfo> {
        networking.requestObject(
            MultiTarget.init(V2EXAPI.siteInfo),
            type: SiteInfo.self
        )
    }
    
}
