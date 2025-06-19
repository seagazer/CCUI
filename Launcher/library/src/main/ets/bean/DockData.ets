import { CellItem } from "./CellItem";

/**
 *
 * Author: Seagazer
 * Date: 2025/5/31
 */
@ObservedV2
export class DockData {
    @Trace itemList: CellItem[] = []
}