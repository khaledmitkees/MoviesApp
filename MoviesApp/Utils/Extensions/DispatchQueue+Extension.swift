//
//  DispatchQueue+Extension.swift
//  MoviesApp
//
//  Created by Khaled Mitkees on 29/11/2023.
//

import Foundation

extension DispatchQueue: DataTransferDispatchQueue {
    func asyncExecute(work: @escaping () -> Void) {
        async(group: nil, execute: work)
    }
}
