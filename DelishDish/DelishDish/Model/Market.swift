//
//  Market.swift
//  DelishDish
//
//  Created by Volkan Yücel on 20.08.24.
//

import Foundation

enum Market: String {
    case kaufland = "Kaufland"
    case lidl = "Lidl"
    case aldi = "Aldi"
    case rewe = "Rewe"
    case edeka = "Edeka"
    case netto = "Netto"
    case penny = "Penny"
    case norma = "Norma"
    
    var url: String {
        switch self {
        case .kaufland:
            return "https://filiale.kaufland.de/prospekte.html?cid=DE%3Asea%3Agoogle_1686923812956&utm_source=google&utm_medium=cpc&utm_id=12728028953&gad_source=1&gclid=CjwKCAjw2dG1BhB4EiwA998cqPO1NvD3W-wHuI-n9ipyw88WxCdmy1YeVTlP-fOi2rnMJYdfYeA3_hoCOfAQAvD_BwE#prospekt"
        case .lidl:
            return "https://www.lidl.de/c/online-prospekte/s10005610"
        case .aldi:
            return "https://www.aldi-nord.de/prospekte.html"
        case .rewe:
            return "https://www.rewe.de/angebote/nationale-angebote/?ecid=sea_google_vs_brands_rewe%7Cak%7Cenga%7Cn%7Cbr_rewe-prospekt_text-ad_823563045_125757747738_kw%3Arewe+prospekt_mt%3Ae_cr%3A534060651304_d%3Ac"
        case .edeka:
            return "https://www.edeka.de/eh/angebote.jsp?ns_campaign=SEA&gad_source=1&gclid=CjwKCAjw2dG1BhB4EiwA998cqE8d7029OvM6ulBjkCNzoP9U_mtNCYmoXCFmTE9LLkPGAlhuYJxdbxoCnfMQAvD_BwE#xtor=SEA-10000-GOO-[23119081569]-[575175473022]-S-[edeka%20prospekt]"
        case .netto:
            return "https://www.netto-online.de/ueber-netto/Online-Prospekte.chtm?RefID=GAds&utm_source=google&utm_medium=search&utm_campaign=Brand-Angebot-1&gad_source=1&gclid=CjwKCAjw2dG1BhB4EiwA998cqFuVS6LtJy8l12nuGW1uOnCCFv9b2K-JKOjmp1J_BgZvmHttYA6-pxoC3oMQAvD_BwE"
        case .penny:
            return "https://www.penny.de/angebote"
        case .norma:
            return "https://www.norma24.de/aktionen"
        }
    }
}
