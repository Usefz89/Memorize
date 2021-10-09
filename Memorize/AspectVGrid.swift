//
//  AspectVGrid.swift
//  Memorize
//
//  Created by yousef zuriqi on 30/09/2021.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable {
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                let width: CGFloat = widthThatFits(
                    itemsCount: items.count,
                    in: geometry.size,
                    aspectRatio: aspectRatio
                )
                LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0) {
                    ForEach(items) { item  in
                        content(item).aspectRatio(aspectRatio, contentMode: .fit)
                    }
                }
                Spacer(minLength: 0)
            }
            
        }
    }
    func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
    
    func widthThatFits(itemsCount: Int, in size: CGSize, aspectRatio: CGFloat) -> CGFloat {
        var columnsCount = 1
        var rowsCount = itemsCount
        
        repeat {
            let itemWidth = size.width / CGFloat( columnsCount)
            let itemHeight = itemWidth / aspectRatio
            if CGFloat(rowsCount) * itemHeight < size.height {
                break
            }
            columnsCount += 1
            rowsCount = (itemsCount + (columnsCount - 1)) / columnsCount // Back to Math Algorithms
        } while columnsCount < itemsCount
        if columnsCount > itemsCount {
            columnsCount = itemsCount
        }
        return floor(size.width / CGFloat(columnsCount))
    }
}


