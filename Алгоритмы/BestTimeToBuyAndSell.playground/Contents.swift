import UIKit

// https://leetcode.com/problems/best-time-to-buy-and-sell-stock-ii/description/?envType=study-plan-v2&envId=top-interview-150


struct Profit {
    let buy: Int
    let sell: Int
    
    let buyIndex: Int
    let sellIndex: Int
    
    var profit: Int {
        sell - buy
    }
}

func maxProfit(_ prices: [Int]) -> Int {
    var profits = [Profit]()
    
    var count = prices.count - 1
    
    for i in 0...count-1 {
        for j in i+1...count {
            
            let buy = prices[i]
            let sell = prices[j]
            
            if sell > buy {
                profits.append(
                    Profit(
                        buy: buy,
                        sell: sell,
                        buyIndex: i,
                        sellIndex: j
                    )
                )
            }
            
        }
    }
    
    print(profits)
    
    var benefits: [Int] = []
    
    guard profits.isEmpty == false else {
        return 0
    }
    
    profits = profits.sorted(by: { $0.buyIndex < $1.buyIndex })
    profits.forEach({
        var orient: Profit? = $0
        var benefit = 0
        
        while orient != nil {
            benefit += (orient?.profit ?? 0)
            let sellIndex = orient?.sellIndex ?? Int.max
            
            orient = profits.first(where: { $0.buyIndex > sellIndex})
        }
        
        benefits.append(benefit)
    })
    
    print(benefits)
    
    return benefits.max() ?? 0
}


//[7,1,5,3,6,4]
//[1,2,3,4,5]
//[7,6,4,3,1]

maxProfit([7,1,5,3,6,4])
maxProfit([1,2,3,4,5])
maxProfit([7,6,4,3,1])
