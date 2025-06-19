import { AppItem } from './AppItem';
import { CellItem } from './CellItem';
import { ItemType } from './ItemType';

/**
 *
 * Author: Seagazer
 * Date: 2025/5/31
 */
@ObservedV2
export class FolderItem extends CellItem {
    @Trace itemList: AppItem[] = []

    constructor(id: string, screenId: number, type: ItemType = ItemType.FOLDER_1x1) {
        super(id, screenId, type)
    }
}