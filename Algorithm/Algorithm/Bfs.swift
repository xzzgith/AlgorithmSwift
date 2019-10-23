//
//  Bfs.swift
//  Algorithm
//
//  Created by Felix on 2019/10/23.
//  Copyright © 2019 aihuishou. All rights reserved.
//

import UIKit
class Note: NSObject {
    var x = 0
    var y = 0
    var s = 0
    override var description: String  {
        return "(\(x),\(y) s=\(s))"
    }
}

class Bfs: NSObject {
    
    private lazy var que: [Note] = {
        var que = [Note]()
        for i in 0...21 { que.append(Note()) }
        return que
    }()
    
    private lazy var maze: [[Int]] = {
        var maze = [
            [0,0,1,0],
            [0,0,0,0],
            [0,0,1,0],
            [0,1,0,0],
            [0,0,0,1]
        ]
        return maze
    }()
    
    private lazy var book: [[Int]] = {
        var book = [
            [0,0,0,0],
            [0,0,0,0],
            [0,0,0,0],
            [0,0,0,0],
            [0,0,0,0]
        ]
        return book
    }()
    
    func find() {
        let startX = 0
        let startY = 0
        let p = 3
        let q = 2
        var head = 0
        var tail = 0
        var flag = false
        //走的方向右下左上
        let next: [[Int]] = [
            [0,1],
            [1,0],
            [0,-1],
            [-1,0]
        ]
        que[tail].x = startX
        que[tail].y = startY
        que[tail].s = 0
        tail += 1
        book[startX][startY] = 1
        while head < tail {
            for item in next {
                let tx = que[head].x + item[0]
                let ty = que[head].y + item[1]
                if tx < 0 || ty < 0 || ty > 3 || tx > 4 { continue }
                if book[tx][ty] == 0 && maze[tx][ty] == 0 {
                    book[tx][ty] = 1
                    //入队
                    que[tail].x = tx
                    que[tail].y = ty
                    que[tail].s = que[head].s + 1
                    tail += 1
                }
                if tx == p && ty == q {
                    flag = true
                    break
                }
            }
            if flag { break }
            
            head += 1
        }
        print("步数为\(que[tail-1].s )")
    }
    
}

