import { CellItem } from '../bean/CellItem'

/**
 *
 * Author: Seagazer
 * Date: 2025/6/14
 */
export class ItemTypeHelper {
    static isApp(item: CellItem): boolean {
        return item.getType() < 10
    }

    static isFolder(item: CellItem): boolean {
        return item.getType() >= 10 && item.getType() < 20
    }

    static isWidget(item: CellItem): boolean {
        return item.getType() >= 20
    }
}