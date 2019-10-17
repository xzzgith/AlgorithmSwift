//
//  ViewController.swift
//  Algorithm
//
//  Created by Felix on 2019/10/17.
//  Copyright © 2019 aihuishou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var a = [1,6,3,9,4]
        
        print("\(quick(&a))")
    }
    
    func bubble(_ list: inout [Int]) -> [Int] {
        for i in 0..<list.count-1 {
            for j in 0..<list.count-1-i {
                if list[j] > list[j+1] {
                    let tmp = list[j]
                    list[j] = list[j+1]
                    list[j+1] = tmp
                }
            }
        }
        return list
    }
    
    func quick(_ list: inout [Int]) -> [Int] {
        if list.count <= 1 {
            return list
        } else {
            let pivot = list.popLast()!
            var greater: [Int] = []
            var lesser: [Int] = []
            
            for element in list {
                if element > pivot {
                    greater.append(element)
                } else {
                    lesser.append(element)
                }
            }
            return quick(&lesser) + [pivot] + quick(&greater)
        }
    }
}

