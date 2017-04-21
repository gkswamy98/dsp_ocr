//
//  FileReader.swift
//  
//
//  Created by Gokul Swamy on 3/27/17.
//
//
import UIKit
import Foundation

public class FileReader{
    public static func readUserData() -> (x: [Float], y: [Float]){
        var x_vals: [Float] = []
        var y_vals: [Float] = []
        let fileURL = Bundle.main.url(forResource: "user", withExtension: "txt")
        if let path = fileURL{
            do {
                let content = try String(contentsOf: path, encoding: String.Encoding.utf8)
                if content.characters.count > 0 {
                    let points = content.components(separatedBy: "\n")
                    for point in points {
                        let coordinates = point.components(separatedBy: " ")
                        if coordinates.count == 2{
                            x_vals.append(Float(coordinates[0])!)
                            y_vals.append(Float(coordinates[1])!)
                        }
                    }
                }
            } catch {
                print("ERROR: Could not read file")
            }
            
        }
        return (x_vals, y_vals)
    }
    public static func readTestData() -> ([(x: [Float], y: [Float], num: Int)]){
        var signals: [(x: [Float], y: [Float], num: Int)] = []
        let fileURL = Bundle.main.url(forResource: "data", withExtension: "txt")
        if let path = fileURL{
            do {
                let content = try String(contentsOf: path, encoding: String.Encoding.utf8)
                if content.characters.count > 0 {
                    var data = content.components(separatedBy: "---")
                    data.removeLast()
                    for datum in data {
                        var x_vals: [Float] = []
                        var y_vals: [Float] = []
                        var points = datum.components(separatedBy: "\n")
                        points.removeLast()
                        var num = -1
                        if points[0].characters.count > 0{
                            num = Int(points[0])!
                        } else {
                            num = Int(points[1])!
                        }
                        for point in points {
                            let coordinates = point.components(separatedBy: " ")
                            if coordinates.count == 2{
                                x_vals.append(Float(coordinates[0])!)
                                y_vals.append(Float(coordinates[1])!)
                            }
                        }
                        signals.append((x: x_vals, y: y_vals, num: num))
                    }
                }
            } catch {
                print("ERROR: Could not read file")
            }
            
        }
        return signals
    }
}


