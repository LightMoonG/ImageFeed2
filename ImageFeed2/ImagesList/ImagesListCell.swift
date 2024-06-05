//
//  ImagesListCell.swift
//  ImageFeed2
//
//  Created by Глеб Хамин on 03.06.2024.
//

import Foundation
import UIKit

final class ImagesListCell: UITableViewCell {
    
    static let reuseIdentifier = "ImagesListCell"
    
    @IBOutlet weak var cellButtonLike: UIButton!
    @IBOutlet weak var cellLable: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
}
