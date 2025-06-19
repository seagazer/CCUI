import { ItemState } from './ItemState'
import { ItemType } from './ItemType'

/**
 *
 * Author: Seagazer
 * Date: 2025/5/31
 */
@ObservedV2
export class CellItem {
    @Trace id: string = ""
    @Trace screenId: number = -1
    // type
    private type: ItemType = ItemType.APP
    // location
    @Trace cellX: number = -1
    @Trace cellY: number = -1
    @Trace spanX: number = 1
    @Trace spanY: number = 1
    // base info
    @Trace title: ResourceStr = ""
    // state
    @Trace state: ItemState = ItemState.NORMAL

    constructor(id: string, screenId: number, type: ItemType) {
        this.id = id
        this.screenId = screenId
        this.type = type
        setupItemSpan(this)
    }

    setType(type: ItemType) {
        if (this.type != type) {
            this.type = type
            setupItemSpan(this)
        }
    }

    getType(): ItemType {
        return this.type
    }

    toString(): string {
        return "[id=" + this.id + ", screenId=" + this.screenId + ", type=" + this.type + ", title=" + this.title
            + ", cell=[" + this.cellX + "," + this.cellY + "],[" + this.spanX + "x" + this.spanY + "]]"
    }
}

function setupItemSpan(item: CellItem) {
    switch (item.getType()) {
        case ItemType.APP:
        case ItemType.FOLDER_1x1:
            item.spanX = 1;
            item.spanY = 1;
            break;
        case ItemType.FOLDER_2x2:
            item.spanX = 2;
            item.spanY = 2;
            break;
        case ItemType.WIDGET_2x2:
            item.spanX = 2;
            item.spanY = 2;
            break;
        case ItemType.WIDGET_3x2:
            item.spanX = 3;
            item.spanY = 2;
            break;
        case ItemType.WIDGET_4x2:
            item.spanX = 4;
            item.spanY = 2;
            break;
    }
}