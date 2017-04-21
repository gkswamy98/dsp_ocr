//
//  Grapher.swift
//  
//
//  Created by Gokul Swamy on 3/27/17.
//
//
import UIKit

public class Grapher{
    public static func graph(arr: [Float]) -> UIView{
        let height = arr.max()! - arr.min()!
        let min = arr.min()!
        let width = arr.count
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 600, height: 300))
        view.backgroundColor = UIColor.white
        for i in 1..<arr.count{
            let line = CAShapeLayer()
            line.backgroundColor = UIColor.white.cgColor
            let linePath = UIBezierPath()
            linePath.move(to: CGPoint(x: (i - 1) * (600/width), y: Int((300/height) * (arr[i - 1] - min))))
            linePath.addLine(to: CGPoint(x: i * (600/width), y: Int((300/height) * (arr[i] - min))))
            line.path = linePath.cgPath
            line.strokeColor = UIColor.blue.cgColor
            line.lineWidth = 2
            line.lineJoin = kCALineJoinRound
            view.layer.addSublayer(line)
            if i % 5 == 0{
                let line2 = CAShapeLayer()
                line2.backgroundColor = UIColor.white.cgColor
                let linePath2 = UIBezierPath()
                linePath2.move(to: CGPoint(x: i * (600/width), y: 0))
                linePath2.addLine(to: CGPoint(x: i * (600/width), y: 300))
                line2.path = linePath2.cgPath
                line2.strokeColor = UIColor.gray.cgColor
                line2.lineWidth = 1
                view.layer.addSublayer(line2)
            }
        }
        return view
    }
}
