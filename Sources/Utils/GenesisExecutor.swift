//
//  GenesisExecutor.swift
//
//
//  Created by Vladislav Lisianskii on 04.11.2023.
//

import Foundation

struct GenesisExecutor {
    private let shell: Shell
    private let executable: String
    private let templatePath: String
    private let options: [String: String]

    init(
        shell: Shell,
        executable: String,
        templatePath: String,
        options: [String : String]
    ) {
        self.shell = shell
        self.executable = executable
        self.templatePath = templatePath
        self.options = options
    }

    func execute() throws {
        let optionsString = options.map { (key: String, value: String) in
            "\(key): \(value)"
        }.joined(separator: ", ")

        let command = [
            executable,
            Constants.genesisCommand,
            templatePath,
            "--options",
            "\"\(optionsString)\""
        ].joined(separator: " ")

        try shell.runInteractive(command)
    }
}

extension GenesisExecutor {
    private enum Constants {
        static let genesisCommand = "generate"
    }
}
