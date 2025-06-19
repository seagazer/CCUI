import { CellItem } from '../bean/CellItem';
import { PageDataManager } from '../data/PageDataManager';
import { LayoutConfig } from './LayoutConfig';

const TAG = "[LayoutManager]"

/**
 *
 * Author: Seagazer
 * Date: 2025/6/2
 */
export class LayoutManager {
    private static sInstance = new LayoutManager()

    private constructor() {
    }

    public static getInstance(): LayoutManager {
        return LayoutManager.sInstance
    }


    // todo 根据图标尺寸，计算出图标创建文件夹状态坐标锚点
    // todo 根据数据，自动填充空位进行布局

    layoutItemAtPosition(item: CellItem, x: number, y: number): boolean {
        let pageData = PageDataManager.getInstance().getPage(item.screenId)
        const occupied = pageData.isVacant(x, y, item.spanX, item.spanY)
        if (occupied) {
            item.cellX = x
            item.cellY = y
            pageData.mark(item.cellX, item.cellY, item.spanX, item.spanY, true)
            return true
        }
        return false
    }

    layoutItem(item: CellItem): boolean {
        let pageData = PageDataManager.getInstance().getPage(item.screenId)
        for (let y = 0; y < LayoutConfig.getInstance().getTemplate().y; y++) {
            for (let x = 0; x < LayoutConfig.getInstance().getTemplate().x; x++) {
                const occupied = pageData.isVacant(x, y, item.spanX, item.spanY)
                if (occupied) {
                    item.cellX = x
                    item.cellY = y
                    pageData.mark(item.cellX, item.cellY, item.spanX, item.spanY, true)
                    return true
                }
            }
        }
        return false
    }

    // todo 布局, screenId
    // 1.drag==app，只有app能逐个移动，避开folder和widget
    // 2.drag==folder || drag==widget，app整块移动

}