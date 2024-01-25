//
//  NasaViewController.swift
//  GCDPractice
//
//  Created by 조유진 on 1/26/24.
//

import UIKit

class NasaViewController: UIViewController {
    @IBOutlet weak var oneImageView: UIImageView!
    @IBOutlet weak var twoImageView: UIImageView!
    @IBOutlet weak var threeImageView: UIImageView!
    @IBOutlet weak var fourImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    func syncDownloadImage(_ imageView: UIImageView, value: String) {
        print("==\(value)1==")
        let url = Nasa.photo
        print("==\(value)2==")
        do {
            print("==\(value)3==")
            let data = try Data(contentsOf: url)
            print("==\(value)4==")
            imageView.image = UIImage(data: data)
            print("==\(value)5==")
        } catch {
            print("==\(value)error-1==")
            imageView.image = UIImage(systemName: "star.fill")
            print("==\(value)error-2==")
        }
        print("==\(value)6==")
    }
    
    func asyncDownloadImage(_ imageView: UIImageView, value: String) {
        print("==\(value)1==", Thread.isMainThread)
        let url = Nasa.photo
        print("==\(value)2==", Thread.isMainThread)
        DispatchQueue.global().async {
            do {
                print("==\(value)3==", Thread.isMainThread)
                let data = try Data(contentsOf: url)
                print("==\(value)4==", Thread.isMainThread)
                DispatchQueue.main.async {
                    print("==\(value)main-1==", Thread.isMainThread)
                    imageView.image = UIImage(data: data)
                    print("==\(value)main-2==", Thread.isMainThread)
                }
                print("==\(value)5==", Thread.isMainThread)
            } catch {
                print("==\(value)error-1==", Thread.isMainThread)
                imageView.image = UIImage(systemName: "star.fill")
                print("==\(value)error-2==", Thread.isMainThread)
            }
        }
        print("==\(value)6==", Thread.isMainThread)
    }
    
    @IBAction func syncButtonClicked(_ sender: UIButton) {
        print("start")
        syncDownloadImage(oneImageView, value: "one")
        syncDownloadImage(twoImageView, value: "two")
        syncDownloadImage(threeImageView, value: "three")
        syncDownloadImage(fourImageView, value: "four")
        print("end")
    }
    
    @IBAction func asyncButtonClicked(_ sender: UIButton) {
        print("start")
        asyncDownloadImage(oneImageView, value: "one")
        asyncDownloadImage(twoImageView, value: "two")
        asyncDownloadImage(threeImageView, value: "three")
        asyncDownloadImage(fourImageView, value: "four")
        print("end")
    }
    
    
}
