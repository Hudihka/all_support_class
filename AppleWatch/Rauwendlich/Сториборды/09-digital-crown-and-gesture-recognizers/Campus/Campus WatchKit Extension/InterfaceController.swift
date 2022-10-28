/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    enum InteractionMode: String {
        case move, zoom, inspect

        mutating func next() {
            switch self {
            case .move:
                self = .zoom
            case .zoom:
                self = .inspect
            case .inspect:
                self = .move
            }
        }
    }

    var interactionMode: InteractionMode! {
        didSet {
            switch interactionMode! {
            case .move, .zoom:
                self.setTitle("[\(interactionMode.rawValue.capitalized) mode]")
                highlightedPointIndex = nil

            case .inspect:
                highlightedPointIndex = preparedData().count / 2

            }
            generateImage()
        }
    }

    // для прокрутки колесика
    var accumulatedDigitalCrownDelta = 0.0
    var offset = 0.0

    // для зума
    var zoom = 1.0

    // для изменения
    var highlightedPointIndex: Int? {
        didSet {
            if highlightedPointIndex != nil {
                self.setTitle(stringFromHighlightedIndex())
            }
        }
    }

    // жесты
    var previousPanPoint: CGPoint?

    var isDrawing = false
    let graphGenerator = GraphGenerator(settings: WatchGraphGeneratorSettings())
    @IBOutlet var graphImage: WKInterfaceImage!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        interactionMode = .inspect
        // делаем делегатом прокрутки колесика
        crownSequencer.delegate = self
    }

    override func willActivate() {
        super.willActivate()

        crownSequencer.focus()
        generateImage()
    }

    // Preparing data

    func stringFromHighlightedIndex() -> String {
        let data = preparedData()
        let census = data[highlightedPointIndex!]
        // 2
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        let dateString = dateFormatter.string(from: census.timestamp)
        // 3
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let numberString = numberFormatter.string(from: NSNumber(value:
                                                                    census.attendance))!
        return "\(dateString): \(numberString)"
    }

    func preparedData() -> [Census] {
        // 1
        let dataCount = Int(
            round(Double(measurementsPerDay) * zoom)
        )
        let dataCountOffset = Int(
            round(Double(measurementsPerDay) * self.offset)
        )
        // 2
        let minRange = censuses.count - dataCount - dataCountOffset
        let maxRange = censuses.count - dataCountOffset
        var data = [Census]()
        for x in minRange..<maxRange {
            if x < censuses.count && x >= 0 {
                data.append(censuses[x])
            }
        }
        return data
    }

    func preparedDemarcations() -> [GraphDemarcation] {
        let censusesAroundMidnight = preparedData().enumerated().filter() {
            index, element in
            let date = element.timestamp
            let maxDate = date.roundedToMidnight().adding(minutes: measurementIntervalMinutes / 2)
            let minDate = date.roundedToMidnight().adding(minutes: -measurementIntervalMinutes / 2)
            return date >= minDate && date <= maxDate
        }
        let demarcations: [GraphDemarcation] = censusesAroundMidnight.map() {
            index, element in
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            return GraphDemarcation(title: formatter.string(from: element.timestamp), index: index)
        }
        return demarcations
    }

    func generateImage() {

        // Avoid drawing the graph when there's no data or when a draw is already in progress
        guard !preparedData().isEmpty && !isDrawing else {
            return
        }

        isDrawing = true

        DispatchQueue.global(qos: .background).async {

            let data = self.preparedData().map{Double($0.attendance)}

            let demarcations = self.preparedDemarcations()

            let image = self.graphGenerator.image(
                self.contentFrame.size,
                with: data,
                highlight: self.highlightedPointIndex,
                demarcations: demarcations
            )

            DispatchQueue.main.async {
                self.graphImage.setImage(image)
                self.isDrawing = false
            }
        }
    }

    // Handling interactions

    func handleInteraction(_ delta: Double) {
        /*
         Поскольку порог был нарушен, вам необходимо сбросить
         накопленныйDigitalCrownDeltaтак что готов снова начать собирать дельты.
         */
        accumulatedDigitalCrownDelta = 0
        // 2
        switch interactionMode! {
        case .move:
            var newOffset = offset + delta

            let maxOffset: Double = Double(daysOfRecord) - 1
            let minOffset: Double = 0

            if newOffset > maxOffset {
                newOffset = maxOffset
            } else if newOffset < minOffset {
                newOffset = minOffset
            }

            offset = newOffset

        case .zoom:
            var newZoom = zoom + delta
            // 2
            let maxZoom = 3.0
            let minZoom = 0.1
            // 3
            if newZoom > maxZoom {
                newZoom = maxZoom
            } else if newZoom < minZoom {
                newZoom = minZoom
            }
            zoom = newZoom

        case .inspect:
            let direction = delta > 0 ? 1 : -1
            // 2
            var newIndex = highlightedPointIndex! + direction
            // 3
            let count = preparedData().count
            if newIndex >= count {
                newIndex = count - 1
            } else if newIndex < 0 {
                newIndex = 0
            }
            highlightedPointIndex! = newIndex

        }
        // 3
        generateImage()
    }

    // MARK: - ACtion
    @IBAction func zoomMenuItemPressed() {
        interactionMode = .zoom
    }

    @IBAction func moveMenuItemPressed() {
        interactionMode = .move
    }

    @IBAction func inspectMenuItemPressed() {
        interactionMode = .inspect
    }

    @IBAction func resetMenuItemPressed() {
        reset()
    }

    // gestures
    @IBAction func tapGesture(_ sender: Any) {
        interactionMode.next()
    }

    @IBAction func panGesture(_ sender: Any) {
        guard let panGesture = sender as? WKPanGestureRecognizer else {
            return
        }
        // 2
        switch panGesture.state {
            // 3
        case .began:
            previousPanPoint = panGesture.locationInObject()
            // 4
        case .changed:
            guard let previousPanPoint = previousPanPoint else {
                return
            }
            let currentPanPoint = panGesture.locationInObject()
            let deltaX = currentPanPoint.x - previousPanPoint.x
            // 5
            let percentageChange = deltaX / self.contentFrame.size.width
            handleInteraction(Double(percentageChange))
            self.previousPanPoint = currentPanPoint
            // 6
        default:
            previousPanPoint = nil
            break
        }
    }

    private func reset() {
      offset = 0
      zoom = 1
      generateImage()
    }
}

// определяем что крутим колесико
extension InterfaceController: WKCrownDelegate {
    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        /*
         Один полный оборот макушки составит дельту1,0.
         Вы захотите отслеживать накопленные изменения с течением времени,
         чтобы ваш интерфейс оставался в соответствии с общим вращением короны.
         */

        accumulatedDigitalCrownDelta += rotationalDelta

        /*
         Вы устанавливаете порог того, как быстро вы хотите реагировать на вращение цифровой короны.
         Методом проб и ошибок я обнаружил, что значение0,05будет достаточно времени
         для успешного завершения обновлений интерфейса, при этом пользователю все еще
         будет казаться бесшовным.
         */
        let threshold = 0.05
        /*
         Вверх положительный, вниз отрицательный. Принимая абсолютное значение,
         вы отслеживаете нарушение порога в любом направлении.
         */

        guard abs(accumulatedDigitalCrownDelta) > threshold else {
            return
        }
        /*
         Когда порог превышен, вы выполняете обновление интерфейса с
         помощью метода, который вскоре реализуете.
         */
        handleInteraction(accumulatedDigitalCrownDelta)
    }

    func crownDidBecomeIdle(_ crownSequencer: WKCrownSequencer?) {
        /*
         вызывается после того, как пользователь перестает вращать цифровую корону.
         */
    }
}
