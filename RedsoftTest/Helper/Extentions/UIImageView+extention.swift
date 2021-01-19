//
//  UIImageView+extention.swift
//  RedsoftTest
//
//  Created by Анна Сычева on 13.01.2021.
//

import UIKit

//MARK: - UIImageView

extension UIImageView {
    
    // MARK: - Public methods
    
    func load(url: URL) {
        DispatchQueue.global().async { [ weak self ] in
            guard
                let self = self,
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }

}
