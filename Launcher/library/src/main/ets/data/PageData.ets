import { CellItem } from '../bean/CellItem';
import { GridOccupancy } from '../layout/GridOccupancy';
import { IOccupancy } from '../layout/IOccupancy';
import { LayoutConfig } from '../layout/LayoutConfig';

/**
 *
 * Author: Seagazer
 * Date: 2025/6/2
 */
@ObservedV2
export class PageData implements IOccupancy {
    screenId: number = -1
    @Trace itemList: CellItem[] = []
    private gridOccupancy: GridOccupancy

    bindObserver(itemList: CellItem[]) {
        this.itemList = itemList
    }

    constructor(screenId: number) {
        this.screenId = screenId
        this.gridOccupancy = new GridOccupancy(LayoutConfig.getInstance().getTemplate().x, LayoutConfig.getInstance().getTemplate().y)
    }

    add(item: CellItem): boolean {
        let index = this.itemList.indexOf(item)
        if (index < 0) {
            this.itemList.push(item)
            return true
        }
        return false
    }

    delete(item: CellItem): boolean {
        let index = this.itemList.indexOf(item)
        if (index >= 0) {
            this.itemList.splice(index, 1)
            return true
        }
        return false
    }

    update(x: number, y: number, newValue: CellItem): boolean {
        let target = this.getData(x, y)
        if (target) {
            target = newValue
            return true
        }
        return false
    }

    getData(x: number, y: number): CellItem | null {
        for (let i = 0; i < this.itemList.length; i++) {
            let item = this.itemList[i]
            if (x >= item.cellX && x <= item.cellX + item.spanX - 1 && y >= item.cellY && y <= item.cellY + item.spanY - 1) {
                return item
            }
        }
        return null
    }

    isVacant(x: number, y: number, spanX: number, spanY: number): boolean {
        return this.gridOccupancy.isVacant(x, y, spanX, spanY)
    }

    mark(cellX: number, cellY: number, spanX: number, spanY: number, value: boolean): void {
        this.gridOccupancy.mark(cellX, cellY, spanX, spanY, value)
    }

    findVacantCell(vacantOut: number[], spanX: number, spanY: number): boolean {
        return this.gridOccupancy.findVacantCell(vacantOut, spanX, spanY)
    }

    clear(): void {
        this.gridOccupancy.clear()
    }
}