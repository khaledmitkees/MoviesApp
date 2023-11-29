//
//  CGSize+Extension.swift
//  MoviesApp
//
//  Created by Khaled Mitkees on 30/11/2023.
//

import Foundation
import UIKit

extension CGSize {
    var scaledSize: CGSize {
        .init(width: width * UIScreen.main.scale, height: height * UIScreen.main.scale)
    }
}
