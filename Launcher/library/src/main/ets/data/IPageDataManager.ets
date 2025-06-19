import { CellItem } from '../bean/CellItem';
import { OnPageChangedListener } from './OnPageChangedListener';
import { OnItemChangedListener } from './OnItemChangedListener';
import { PageData } from './PageData';

/**
 *
 * Author: Seagazer
 * Date: 2025/6/2
 */
export interface IPageDataManager {

    loadDataFromStorage(): void

    getPage(screenId: number): PageData

    getPageList(): PageData[]

    getPageSize(): number

    getItem(screenId: number, x: number, y: number): CellItem | null

    addItem(screenId: number, data: CellItem): void

    deleteItem(screenId: number, data: CellItem): void

    updateItem(screenId: number, data: CellItem, newValue: CellItem): void

    moveItem(data: CellItem, fromScreenId: number, toScreenId: number): void

    addOnPageDataChangedListener(listener: OnItemChangedListener): void

    removeOnPageDataChangedListener(listener: OnItemChangedListener): void

    addOnPageChangedListener(listener: OnPageChangedListener): void

    removeOnPageChangedListener(listener: OnPageChangedListener): void

    addPage(): void

    deletePage(screenId: number): void

}