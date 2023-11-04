//
//  Configuration.swift
//
//
//  Created by Vladislav Lisianskii on 04.11.2023.
//

import Foundation

struct Configuration: Decodable {
    let executables: ExecutablesConfiguration
    let viper: ViperConfiguration?
    let yarch: YarchConfiguration?
    let bundle: BundleConfiguration?
}
