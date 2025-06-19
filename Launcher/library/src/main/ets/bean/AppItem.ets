import { CellItem } from './CellItem';
import { ItemType } from './ItemType';

/**
 *
 * Author: Seagazer
 * Date: 2025/5/31
 */
@ObservedV2
export class AppItem extends CellItem {
    @Trace icon: ResourceStr = ""

    constructor(id: string, screenId: number) {
        super(id, screenId, ItemType.APP)
    }
}