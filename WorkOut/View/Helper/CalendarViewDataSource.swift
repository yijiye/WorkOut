//
//  CalendarViewDataSource.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/26.
//

import UIKit

protocol CalendarViewDataSource: AnyObject {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, cellDate: CalendarViewModel.CalendarDay?) -> UICollectionViewCell
}
