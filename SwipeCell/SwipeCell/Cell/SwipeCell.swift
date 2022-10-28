//
//  SwipeCell.swift
//  SwipeCell
//
//  Created by Константин Ирошников on 04.08.2022.
//

import Foundation
import UIKit
import SnapKit

protocol SwipeCellProtocol {
    var openCell: (SwipeCellProtocol) -> Void { get set }
    var onPan: () -> Void { get set }

    func closeCell()
}

final class SwipeCell: UITableViewCell, SwipeCellProtocol {
    private enum Constants {
        static let maxRightSwipePoint: CGFloat = -240
        static let pointToAnimateRight: CGFloat = maxRightSwipePoint / 2

        static let maxLeftSwipePoint: CGFloat = 240
        static let pointToAnimateLeft: CGFloat = maxLeftSwipePoint / 2

        static let animateTimeInterval: TimeInterval = 0.25
        static let radius: CGFloat = 16
    }

    private let label = UILabel()
    private let swipeViewContent: UIView = {
        let view = UIView()
        view.backgroundColor = .white
//        view.backgroundColor = ColorTokens.dsBackgroundMain

        return view
    }()
    private var rightConstarint: Constraint?
    private var leftConstarint: Constraint?
    private var isOpen = false

    var openCell: (SwipeCellProtocol) -> Void = { _ in }
    var onPan: () -> Void = {  }

    var textCell: String = "" {
        didSet {
            label.text = textCell
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        desingUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func desingUI() {
        createUnderView()

        contentView.addSubview(swipeViewContent)
        swipeViewContent.snp.makeConstraints { make in
            make.top.bottom.equalTo(0)
            self.rightConstarint = make.right.equalTo(0).constraint
            self.leftConstarint = make.left.equalTo(0).constraint
        }

        swipeViewContent.addSubview(label)
        label.textColor = .black
        label.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(20)
            make.height.equalTo(30)
            make.width.greaterThanOrEqualTo(100)
        }

        addGester()
    }

    func closeCell() {
        animateCell(isOpen: false)
    }

    // MARK: - Buttons

    private func createUnderView() {
        let underView = ViewUnderSwipeCell { [weak self] action in
            print("------")
        }

        contentView.addSubview(underView)

        underView.snp.makeConstraints { make in
            make.right.left.top.bottom.equalTo(0)
        }
    }

    private func addGester() {
        let panGester = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        contentView.addGestureRecognizer(panGester)
        panGester.delegate = self
    }

    @objc
    private func onPan(_ sender: UIPanGestureRecognizer) {
        let pointX = sender.translation(in: contentView).x
        print(pointX)

        switch sender.state {
        case .began:
            if isOpen == false {
                onPan()
            }

        case .changed:

            if isOpen {
                if pointX < 0 {
                    break //
                } else if pointX >= Constants.maxLeftSwipePoint {
                    constreitsUpdate(0)
                } else {
                    let value = Constants.maxLeftSwipePoint - pointX
                    constreitsUpdate(value)
                    cornerRadiusView(value)
                }

            } else {

                if pointX < Constants.maxRightSwipePoint {
                    constreitsUpdate(-Constants.maxRightSwipePoint) //
                } else if pointX >= 0 {
                    break
                } else {
                    constreitsUpdate(-pointX)
                }

                cornerRadiusView(pointX)
            }

        case .ended:
            if isOpen {
                animateCell(isOpen: pointX < Constants.pointToAnimateLeft)
            } else {
                animateCell(isOpen: pointX < Constants.pointToAnimateRight)
            }

        default:
            break
        }
    }

    private func constreitsUpdate(_ value: CGFloat) {
        guard
            let rightConstarint = rightConstarint,
            let leftConstarint = leftConstarint
        else {
            return
        }

        rightConstarint.update(inset: value)
        leftConstarint.update(inset: -value)
    }

    private func cornerRadiusView(_ value: CGFloat) {
        var radius = abs(value / Constants.maxRightSwipePoint) * Constants.radius
        if radius > Constants.radius {
            radius = Constants.radius
        }
        print(radius)
        self.swipeViewContent.layer.cornerRadius = radius
    }

    private func animateCell(isOpen: Bool) {
        constreitsUpdate(isOpen ? -Constants.maxRightSwipePoint : 0)
        UIView.animate(
            withDuration: Constants.animateTimeInterval
        ) {
            self.layoutIfNeeded()
            self.swipeViewContent.layer.cornerRadius = isOpen ? Constants.radius : 0
        } completion: { _ in
            if isOpen {
                self.openCell(self)
            }
            self.isOpen = isOpen
        }
    }

    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let panregognizer = gestureRecognizer as? UIPanGestureRecognizer
        let velocity =  panregognizer?.velocity(in: nil) ?? .zero


        if velocity.x > 0 && isOpen == false {
            return false
        }

        return abs(velocity.y) < abs(velocity.x)
    }
}
