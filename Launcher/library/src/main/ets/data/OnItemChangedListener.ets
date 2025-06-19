import { CellItem } from '../bean/CellItem';

/**
 *
 * Author: Seagazer
 * Date: 2025/6/2
 */
export interface OnItemChangedListener {
    onItemAdd: (screenId: number, item: CellItem) => void
    onItemDelete: (screenId: number, item: CellItem) => void
    onItemUpdate: (screenId: number, item: CellItem, newValue: CellItem) => void
}