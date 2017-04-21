//
//  kNN.swift
//  
//
//  Created by Gokul Swamy on 3/27/17.
//
//

import UIKit

public class kNN{
    public static func visualizeKNN(redPoints: [(Double, Double)], bluePoints: [(Double, Double)], p: (Double, Double), k: Int) ->UIView{
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200.0, height: 200.0))
        view.backgroundColor = UIColor.white
        var maxX = 0.0
        var maxY = 0.0
        for pair in redPoints{
            if pair.0 > maxX{
                maxX = pair.0
            }
            if pair.1 > maxY{
                maxY = pair.1
            }
        }
        for pair in bluePoints{
            if pair.0 > maxX{
                maxX = pair.0
            }
            if pair.1 > maxY{
                maxY = pair.1
            }
        }
        for pair in redPoints{
            let circlePath = UIBezierPath(arcCenter: CGPoint(x: pair.0 * (200.0/maxX), y: pair.1 * (200.0/maxY)), radius: CGFloat(10), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circlePath.cgPath
            shapeLayer.fillColor = UIColor.red.cgColor
            view.layer.addSublayer(shapeLayer)
        }
        for pair in bluePoints{
            let circlePath = UIBezierPath(arcCenter: CGPoint(x: pair.0 * (200.0/maxX), y: pair.1 * (200.0/maxY)), radius: CGFloat(10), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circlePath.cgPath
            shapeLayer.fillColor = UIColor.blue.cgColor
            view.layer.addSublayer(shapeLayer)
        }
        var distances: [(Double, String)] = []
        for pair in redPoints{
            let dist = sqrt(((pair.0 - p.0) * (pair.0 - p.0)) + ((pair.1 - p.1) * (pair.1 - p.1)))
            distances.append((dist, "red"))
        }
        for pair in bluePoints{
            let dist = sqrt(((pair.0 - p.0) * (pair.0 - p.0)) + ((pair.1 - p.1) * (pair.1 - p.1)))
            distances.append((dist, "blue"))
        }
        distances = distances.sorted(by: {
            $0.0 < $1.0
        })
        var vote = 0
        for i in 0..<k{
            if distances[i].1 == "red"{
                vote = vote + 1
            } else {
                vote = vote - 1
            }
        }
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: p.0 * (200.0/maxX), y: p.1 * (200.0/maxY)), radius: CGFloat(10), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 3
        
        if vote > 0{
            shapeLayer.fillColor = UIColor.red.cgColor
        } else if vote < 0 {
            shapeLayer.fillColor = UIColor.blue.cgColor
        } else {
            shapeLayer.fillColor = UIColor.green.cgColor
        }
        view.layer.addSublayer(shapeLayer)
        return view
    }
    
    public static func categorizeSignal(x: [Float], y: [Float]) -> Int {
        var distances: [(Float, Int)] = []
        let signals = FileReader.readTestData()
        for signal in signals{
            distances.append((dynamicTimeWarp(x1: x, y1: y, x2: signal.x, y2: signal.y), signal.num))
        }
        distances = distances.sorted(by: {
            $0.0 < $1.0
        })
        var votes = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        let k = 10
        let maxIndex = min(distances.count, k)
        for i in 0..<maxIndex {
            votes[distances[i].1] = votes[distances[i].1] + 1
        }
        return votes.index(of: votes.max()!)!
    }
    
    public static func dynamicTimeWarp(x1: [Float], y1: [Float], x2: [Float], y2: [Float]) -> Float {
        var mat: [[Float]] = Array(repeating: Array(repeating: 0, count: x2.count + 1), count: x1.count + 1)
        for i in 1...x1.count{
            mat[i][0] = Float.infinity
        }
        for i in 1...x2.count{
            mat[0][i] = Float.infinity
        }
        mat[0][0] = 0
        for i in 1...x1.count{
            for j in 1...x2.count{
                let cost = abs(x1[i - 1] - x2[j - 1]) + abs(y1[i - 1] - y2[j - 1])
                mat[i][j] = cost + min(mat[i-1][j], mat[i][j-1], mat[i-1][j-1])
            }
        }
        return mat[x1.count][x2.count]
    }
    public static func visualizeDTW(s1: [Float], s2: [Float]) -> (s1: UIView, s2: UIView, warped: UIView) {
        var mat: [[Float]] = Array(repeating: Array(repeating: 0, count: s2.count + 1), count: s1.count + 1)
        for i in 1...s1.count{
            mat[i][0] = Float.infinity
        }
        for i in 1...s2.count{
            mat[0][i] = Float.infinity
        }
        var s: [Float] = []
        mat[0][0] = 0
        for i in 1...s1.count{
            for j in 1...s2.count{
                let cost = abs(s1[i - 1] - s2[j - 1])
                let dp = min(mat[i-1][j], mat[i][j-1], mat[i-1][j-1])
                if dp == mat[i-1][j]{ //insertion
                    s.append(s1[i-2])
                } else { //match or deletion
                    s.append(s1[i-1])
                }
                mat[i][j] = cost + dp
            }
        }
        let view1 = Grapher.graph(arr: s1)
        let view2 = Grapher.graph(arr: s2)
        let viewWarped = Grapher.graph(arr: s)
        return (view1, view2, viewWarped)
    }
    
}
