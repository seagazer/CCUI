import { CellItem } from './CellItem';
import { ItemType } from './ItemType';

/**
 *
 * Author: Seagazer
 * Date: 2025/5/31
 */
@ObservedV2
export class WidgetItem extends CellItem {
    @Trace image: ResourceStr = $r('app.media.widget')

    constructor(id: string, screenId: number, type: ItemType = ItemType.WIDGET_2x2) {
        super(id, screenId, type)
    }
}