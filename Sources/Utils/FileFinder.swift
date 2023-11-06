//
//  FileFinder.swift
//
//
//  Created by Vladislav Lisianskii on 04.11.2023.
//

import Foundation

struct FileFinder {
    private let fileManager: FileManager

    init(fileManager: FileManager = FileManager.default) {
        self.fileManager = fileManager
    }

    func filePaths(withName name: String, at path: String) -> [String] {

        let enumerator = URL(string: path)
            .flatMap { (pathURL: URL) -> FileManager.DirectoryEnumerator? in
                fileManager.enumerator(
                    at: pathURL,
                    includingPropertiesForKeys: [
                        .localizedNameKey
                    ],
                    options: [
                        .skipsPackageDescendants,
                        .skipsHiddenFiles
                    ]
                )
            }

        guard let enumerator else { return [String]() }

        return enumerator
            .lazy
            .compactMap { (element: NSEnumerator.Element) -> URL? in
                element as? URL
            }
            .filter { (url: URL) -> Bool in
                return url.lastPathComponent == name
            }
            .map { (url: URL) -> String in
                url.relativePath
            }
    }

}
