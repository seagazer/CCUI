import { CellItem } from '../bean/CellItem';
import { Logger } from '../extensions/Logger';
import { IPageDataManager } from './IPageDataManager';
import { OnItemChangedListener } from './OnItemChangedListener';
import { PageData } from './PageData';
import { HashMap } from '@kit.ArkTS';
import { OnPageChangedListener } from './OnPageChangedListener';

const TAG = "[PageDataManager]"

/**
 *
 * Author: Seagazer
 * Date: 2025/6/2
 */
export class PageDataManager implements IPageDataManager {
    private pageList: HashMap<number, PageData> = new HashMap()
    private pageDataChangedListeners: Set<OnItemChangedListener> = new Set()
    private pageChangedListeners: Set<OnPageChangedListener> = new Set()
    private static sInstance: PageDataManager = new PageDataManager()

    private constructor() {
    }

    static getInstance(): PageDataManager {
        return PageDataManager.sInstance
    }

    loadDataFromStorage() {
        // todo 从local storage加载数据，填充到pageList缓存中
    }

    addPage(): void {
        let newScreenId = this.getPageSize()
        let page = new PageData(newScreenId)
        this.pageList.set(newScreenId, page)
        Logger.d(TAG, "add page= " + newScreenId)
        this.pageChangedListeners.forEach((listener) => {
            listener.onPageAdd(page)
        })
    }

    deletePage(screenId: number): void {
        let removed = this.pageList.remove(screenId)
        this.pageChangedListeners.forEach((listener) => {
            listener.onPageDelete(removed)
        })
    }

    getPage(screenId: number): PageData {
        let pageData = this.pageList.get(screenId)
        return pageData
    }

    getPageList(): PageData[] {
        let result: PageData[] = []
        this.pageList.forEach((data) => {
            result.push(data!)
        })
        result.sort((a, b) => {
            return a.screenId - b.screenId
        })
        return result
    }

    getPageSize(): number {
        return this.pageList.length
    }

    getItem(screenId: number, x: number, y: number): CellItem | null {
        let pageData = this.pageList.get(screenId)
        return pageData.getData(x, y)
    }

    addItem(screenId: number, item: CellItem): void {
        let pageData = this.pageList.get(screenId)
        let result = pageData.add(item)
        if (result) {
            this.pageDataChangedListeners.forEach((listener) => {
                listener.onItemAdd(screenId, item)
            })
        }
    }

    deleteItem(screenId: number, item: CellItem): void {
        let pageData = this.pageList.get(screenId)
        let result = pageData.delete(item)
        if (result) {
            this.pageDataChangedListeners.forEach((listener) => {
                listener.onItemDelete(screenId, item)
            })
        }
    }

    updateItem(screenId: number, item: CellItem, newValue: CellItem): void {
        let pageData = this.pageList.get(screenId)
        let result = pageData.update(item.cellX, item.cellY, newValue)
        if (result) {
            this.pageDataChangedListeners.forEach((listener) => {
                listener.onItemUpdate(screenId, item, newValue)
            })
        }
    }

    moveItem(item: CellItem, fromScreenId: number, toScreenId: number): void {
        this.deleteItem(fromScreenId, item)
        this.addItem(toScreenId, item)
    }

    addOnPageDataChangedListener(listener: OnItemChangedListener): void {
        if (this.pageDataChangedListeners.has(listener)) {
            Logger.w(TAG, "The listener is already added, will be overwrite!")
        }
        this.pageDataChangedListeners.add(listener)
    }

    removeOnPageDataChangedListener(listener: OnItemChangedListener): void {
        if (this.pageDataChangedListeners.has(listener)) {
            this.pageDataChangedListeners.delete(listener)
        } else {
            Logger.w(TAG, "The listener is not added, can not remove!")
        }
    }

    addOnPageChangedListener(listener: OnPageChangedListener): void {
        if (this.pageChangedListeners.has(listener)) {
            Logger.w(TAG, "The listener is already added, will be overwrite!")
        }
        this.pageChangedListeners.add(listener)
    }

    removeOnPageChangedListener(listener: OnPageChangedListener): void {
        if (this.pageChangedListeners.has(listener)) {
            this.pageChangedListeners.delete(listener)
        } else {
            Logger.w(TAG, "The listener is not added, can not remove!")
        }
    }
}