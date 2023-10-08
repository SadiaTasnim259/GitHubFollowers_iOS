//
//  UIHelper.swift
//  GitHubFollowers
//
//  Created by Sadia on 2/9/23.
//

import UIKit

struct UIHelper {
    //static এর জন্য project এর সব যায়গা থেকে access করা যাবে।
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout{ //detarmine how my collection view will looks.
        let width = view.bounds.width
        let padding:CGFloat = 12
        let minimumItemSpacing:CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2) //(padding * 2) dicchi karon screen er 2 side ei padding dicchi.
        let itemWidth = availableWidth/3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
}
