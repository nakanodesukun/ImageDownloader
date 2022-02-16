//
//  ViewController.swift
//  ImageDownloader
//
//  Created by 中野翔太 on 2022/02/16.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var iconView: UIImageView!
    var avaterImage: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadImage { image in
            DispatchQueue.main.async { [weak self] in
                self?.iconView.image = image

            }


        }
    }



    func downloadImage(sucsess: @escaping(UIImage) -> Void) {
        var request = URLRequest(url: URL(string: "https://avatars.githubusercontent.com/u/72324850?v=4")!)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("エラー", error)
            }
            guard let data = data else {
                print("dataの取得に失敗しました")
                return
            }
            guard let imageData = UIImage(data: data) else {
                print("UIImage型への変換に失敗しました。", error)
                return
            }
            sucsess(imageData)
//            DispatchQueue.main.async {
//            }

        }
        task.resume()
    }
}

