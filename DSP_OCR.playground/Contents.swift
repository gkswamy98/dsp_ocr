//Please view in rendered mode. Will probably take a bit to start running.
/*:
 # Digit Recognition Through Signal Processing
 Hey there! Traditionally, recognizing digits is done through Convolutional Neural Networks trained on a large dataset like MNIST. However, in a scenario like writing on a tablet, we have more than just the end result - we have how we got there. I had the idea of treating digit recognition as a signal processing problem. Try out drawing a digit 0-9 with a single stroke in the assistant editor and read on to learn about my algorithm.
 */
import UIKit
import PlaygroundSupport
import SceneKit
import SpriteKit

PlaygroundPage.current.needsIndefiniteExecution = true
var guessPad = GuessPad.makeGuessPad()
PlaygroundPage.current.liveView = guessPad
/*:
 The data you just produced was printed to the console. If you want to visualize it, copy the console output into the file **user.txt** in the resources folder on the left and return to this Playground. Sample data for the number 2 is provided otherwise. Every vertical line corresponds to 5 samples.
 */
let userData = FileReader.readUserData()
let xGraph = Grapher.graph(arr: userData.x)

let yGraph = Grapher.graph(arr: userData.y)

/*:
 I then use the **k-nearest neighbors** algorithm to categorize the input signal (an approach supported by current research in the field). The algorithm has each of the *k* labelled points that are closest to the input in the sample space vote for their label. The label with the most votes wins and is displayed in the assistant editor. Below is a demo of the algorithm. Feel free to edit the numbers provided or add more points to see how the classification changes.
 */
let redPoints = [(10.1, 15.5), (15.1, 20.4), (30.0, 10.0), (20.0, 20.0)]
let bluePoints = [(95.9, 89.7), (88.8, 77.7), (74.5, 86.2), (65.3, 90.4), (50.0, 50.0), (75.5, 56.7), (56.5, 88.5)]
let testPoint = (30.0, 30.0)
let k = 2
let kNNVisualization = kNN.visualizeKNN(redPoints: redPoints, bluePoints: bluePoints, p: testPoint, k: k)
/*:
 To find the distance between 2 signals (including those of different lengths), I use a technique called **Dynamic Time Warping**. Below is a demo with 2 sine waves of different frequencies. The first signal is warped to produce a signal more accurately comparable to the later.
 */
let signal1: [Float] = [0, 1, 0, -1, 0]
let signal2: [Float] = [0, 0.7, 1, 0.7, 0, -0.7, -1, -0.7, 0]
let dtwVisualization = kNN.visualizeDTW(s1: signal1, s2: signal2)

let singal1Plot = dtwVisualization.s1

let signal2Plot = dtwVisualization.s2
/*:
 Here is the warped version of the first signal.
 */
let signal1Warped = dtwVisualization.warped

/*:
 This approach seems to work well enough in my testing to warrant future study. Thank-you for your time, I hope you learned something new 😊.
 */
