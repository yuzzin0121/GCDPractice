//
//  GCDViewController.swift
//  GCDPractice
//
//  Created by 조유진 on 1/26/24.
//

import UIKit

// Serial / Concurrent : 메인 스레드에 몰빵 / 여러개의 스레드에 분배
// Sync / Async
class GCDViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        serialSync()
//        serialAsync()
//        concurrentSync()
        concurrentAsync()
    }
    
    // 1. Serial - Sync
    func serialSync() {
        print("START SerialSync", terminator: " ")
        // 메인 스레드는 DispatchQueue로 보낸 일이 끝날 때까지 무한정 기다리는 상태 -> 데드락 발생
        for num in 1...10 {
            print(num, terminator: " ")
        }
        
        DispatchQueue.main.sync {
            for num in 11...20 {
                print(num, terminator: " ")
            }
        }
        
        for num in 21...30 {
            print(num, terminator: " ")
        }
        
        DispatchQueue.main.sync {
            for num in 31...40 {
                print(num, terminator: " ")
            }
        }
        for num in 41...50 {
            print(num, terminator: " ")
        }
    }
    
    // 2. Serial - Async
    func serialAsync() {
        for num in 1...10 {
            print(num, terminator: " ")
        }
        
        // 큐로 작업을 보내놓고
        DispatchQueue.main.async {
            for num in 11...20 {
                print(num, terminator: " ")
            }
        }
        
        // 다음 코드 실행
        for num in 21...30 {
            print(num, terminator: " ")
        }
        
        // 다음 코드 실행
        for num in 31...40 {
            print(num, terminator: " ")
        }
        
        // 작업 받아서 실행 print 11~20
        
        // 큐에 보냄
        DispatchQueue.main.async {
            for num in 41...50 {
                print(num, terminator: " ")
            }
        }
        
        // 작업 받아서 실행 print 41~50
    }
    
    // 3. Concurrent - Sync : 다른 스레드에 작업을 맡긴 후 다른 스레드들이 맡은 작업이 끝날 때까지 기다린다.
    func concurrentSync() {
        for num in 1...10 {
            print(num, terminator: " ")
        }
        
        // 큐로 작업을 보내놓고
        DispatchQueue.global().sync {
            for num in 11...20 {
                print(num, terminator: " ")
            }
        }
        
        // 다음 코드 실행
        DispatchQueue.global().sync {
            for num in 21...30 {
                print(num, terminator: " ")
            }
        }
        
        // 다음 코드 실행
        for num in 31...40 {
            print(num, terminator: " ")
        }
        
        // 작업 받아서 실행 print 11~20
        
        // 큐에 보냄
        DispatchQueue.global().sync {
            for num in 41...50 {
                print(num, terminator: " ")
            }
        }
    }
    
    // 4. Concurrent - Async : 다른 스레드들에게 작업을 분배하여 동시에 작업을 실행한다.
    func concurrentAsync() {
        for num in 1...10 {
            print(num, terminator: " ")
        }
        
        // 큐로 작업을 보내놓고
        DispatchQueue.global().async {
            for num in 11...20 {
                print(num, terminator: " ")
            }
        }
        
        // 다음 코드 실행
        DispatchQueue.global().async {
            for num in 21...30 {
                print(num, terminator: " ")
            }
        }
        
        // 다음 코드 실행
        for num in 31...40 {
            print(num, terminator: " ")
        }
        
        // 작업 받아서 실행 print 11~20
        
        // 큐에 보냄
        DispatchQueue.global().async {
            for num in 41...50 {
                print(num, terminator: " ")
            }
        }
    }
}
