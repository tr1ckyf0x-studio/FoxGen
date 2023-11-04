//
//  ModuleOptions.swift
//
//
//  Created by Vladislav Lisianskii on 04.11.2023.
//

import Foundation
import ArgumentParser

struct ModuleOptions: ParsableArguments {
    @Option(name: [.short, .long], help: "Module name")
    var module: String

    @Option(help: "Submodule name")
    var submodule: String
}
