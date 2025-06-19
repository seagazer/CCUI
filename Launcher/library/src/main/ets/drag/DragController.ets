import { CellItem } from '../bean/CellItem';
import { ItemState } from '../bean/ItemState';
import { PageData } from '../data/PageData';
import { Logger } from '../extensions/Logger';
import { DragMode } from './DragMode';

const TAG = "[DragController]"

/**
 *
 * Author: Seagazer
 * Date: 2025/6/2
 */
export class DragController {
    private static sInstance = new DragController()
    private currentPageData: PageData | null = null
    private dragMode: DragMode = DragMode.NONE
    private dragItem: CellItem | null = null
    private statusBarHeight = 0

    private constructor() {
    }

    static getInstance(): DragController {
        return DragController.sInstance
    }

    setPageData(data: PageData) {
        this.currentPageData = data
    }

    onPreDrag(data: CellItem, status: PreDragStatus) {
        Logger.d(TAG, "pre drag status= " + status)
        if (status == PreDragStatus.PREVIEW_LIFT_STARTED) {
            Logger.d(TAG, "pre drag status1= " + data.id)
            data.state = ItemState.DRAG
        } else if (status == PreDragStatus.PREVIEW_LANDING_FINISHED) {
            Logger.d(TAG, "pre drag status2= " + data.id)
            data.state = ItemState.NORMAL
        }
    }

    onDragStart(data: CellItem, event: DragEvent) {
        Logger.d(TAG, "dragBegin= " + data.id)
    }

    onDragEnd(data: CellItem, event: DragEvent) {
        Logger.d(TAG, "dragEnd= " + data.id)
        data.state = ItemState.NORMAL
    }

    onDragOver(event: DragEvent) {
        // Logger.d(TAG, "dragOver= " + event.getWindowX() + "," + event.getWindowY())
    }

    onDrop(event: DragEvent) {
        Logger.d(TAG, "onDrop= " + event.getWindowX() + "," + event.getWindowY())
    }
}
