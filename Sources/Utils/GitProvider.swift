//
//  GitProvider.swift
//
//
//  Created by Vladislav Lisianskii on 04.11.2023.
//

import Foundation

struct GitProvider {
    private let shell: Shell

    init(shell: Shell) {
        self.shell = shell
    }

    var username: String {
        let username = try? shell
            .run("git config user.name")
            .trimmingCharacters(in: .whitespacesAndNewlines)
         return username ?? String()
    }
}
