//
//  ImagesListViewController.swift
//  ImageFeed2
//
//  Created by Глеб Хамин on 31.05.2024.
//

import UIKit

class ImagesListViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    private let photosName: [String] = Array(0..<20).map{ "\($0)"}
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        // Do any additional setup after loading the view.
    }


}

extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        guard let imageListCell = cell as? ImagesListCell else {
            return UITableViewCell()
        }
        configCell(for: imageListCell, with: indexPath)
        return imageListCell
    }
    
    func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        guard let image = UIImage(named: photosName[indexPath.row]) else {
            return
        }
        
        cell.cellImage.image = image
        cell.cellLable.text = dateFormatter.string(from: Date())
        
        
        let isLike = indexPath.row % 2 == 0
        let likeImage = isLike ? UIImage(named: "likeButtonOff") : UIImage(named: "likeButtonOn")
        cell.cellButtonLike.setImage(likeImage, for: .normal)
        cell.cellButtonLike.setTitle("", for: .normal)
        
        addGradient(to: cell.cellImage, with: indexPath)
    }
    
    func addGradient(to cellImage: UIImageView, with indexPath: IndexPath) {
        if let sublayers = cellImage.layer.sublayers {
            for layer in sublayers {
                if layer is CAGradientLayer {
                    layer.removeFromSuperlayer()
                    break
                }
            }
        }
        
        let cellHeight = tableView(tableView, heightForRowAt: indexPath)
        let gradientLayer = CAGradientLayer()
        let colorTop = UIColor { _ in UIColor(named: "YP Black") ?? UIColor.black }.withAlphaComponent(0).cgColor
        let colotBottom = UIColor { _ in UIColor(named: "YP Black") ?? UIColor.black }.withAlphaComponent(0.2).cgColor
        
        gradientLayer.frame = CGRect(x: 0, y: cellHeight - 38, width: cellImage.bounds.width, height: 30)
        gradientLayer.colors = [colorTop, colotBottom]
        gradientLayer.locations = [0.0, 1.0]
        cellImage.layer.addSublayer(gradientLayer)
    }
    
}

extension ImagesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let image = UIImage(named: photosName[indexPath.row]) else {
            return 0
        }
        
        let imageInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let imageViewWidth = tableView.bounds.width - imageInsets.left - imageInsets.right
        let imageWidth = image.size.width
        let scale = imageViewWidth / imageWidth
        let cellHeight = image.size.height * scale + imageInsets.top + imageInsets.bottom
        return cellHeight
    }
}
