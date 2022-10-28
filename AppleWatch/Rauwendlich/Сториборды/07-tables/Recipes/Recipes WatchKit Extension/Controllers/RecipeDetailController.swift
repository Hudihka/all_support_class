//
//  RecipeDetailController.swift
//  Recipes WatchKit Extension
//
//  Created by Константин Ирошников on 21.08.2022.
//  Copyright © 2022 Ray Wenderlich. All rights reserved.
//

import Foundation
import WatchKit

class RecipeDetailController: WKInterfaceController {

    @IBOutlet var table: WKInterfaceTable!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // 1
        if let recipe = context as? Recipe {

              let rowTypes: [String] = ["RecipeDetailHederCell"] + recipe.steps.map({ _ in "RecipeStep" })
              table.setRowTypes(rowTypes)

              for i in 0..<table.numberOfRows {
                let row = table.rowController(at: i)

                if let header = row as? RecipeDetailHederCell {
                  header.titleLabel.setText(recipe.name)
                } else if let step = row as? RecipeDetailRowCell {
                  step.label.setText("\(i). " + recipe.steps[i - 1])
                }
            }
        }
    }
}
