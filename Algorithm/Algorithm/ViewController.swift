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
//        var a = [1,6,3,9,4]
//        print("\(bubble(&a))")
//        print("\(quick(&a))")
        
//        dfs(1)//从第一个盒子开始
//        dfs2(1)
//        print("总共有\(total/2)种")
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
    
    private lazy var a: [Int] = {
        var a = Array(repeating: 0, count: 10)
        return a
    }()
    private lazy var book: [Int] = {
        var book = Array(repeating: 0, count: 10)
        return book
    }()
    let n = 3//1-9
    
    /*
       dfs基本模型
       判断边界
       尝试每一种可能 for {
       继续下一步 dfs(step+1)
       }
       返回
    */
    func dfs(_ step: Int) -> Void {
        if step == n+1 {
            for i in 1...n {
                print("\(a[i])")
            }
            print("---------")
            return
        }
        for i in 1...n {
            if book[i] == 0 {
                a[step] = i//第i张牌放到第step个盒子里
                book[i] = 1
                dfs(step+1)
                book[i] = 0
            }
        }
    }
    // [][][] + [][][] = [][][]
    // 空格里为1-9 有多少种可能
    var m: Int = 9
    var total: Int = 0
    func dfs2(_ step: Int) -> Void {
        if step == 10 {
            if a[1]*100 + a[2]*10 + a[3] + a[4]*100 + a[5]*10 + a[6] == a[7]*100 + a[8]*10 + a[9] {
                total += 1
                print("\(a[1]*100 + a[2]*10 + a[3])+\(a[4]*100 + a[5]*10 + a[6])=\(a[7]*100 + a[8]*10 + a[9])")
            }
        }
        for i in 1...m {
            if book[i] == 0 {
                a[step] = i//第i张牌放到第step个盒子里
                book[i] = 1
                dfs2(step+1)
                book[i] = 0
            }
        }
    }
}

