//
//  ModuleSubcommand.swift
//  
//
//  Created by Vladislav Lisianskii on 10.09.2023.
//

import ArgumentParser
import Foundation

struct ModuleSubcommand: ParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "module",
        abstract: "Generates module",
        subcommands: [
            ViperModuleSubcommand.self,
            YarchModuleSubcommand.self
        ]
    )
}
