import { OnPageChangedListener } from '../data/OnPageChangedListener'
import { PageData } from '../data/PageData'
import { PageDataManager } from '../data/PageDataManager'
import { DragController } from '../drag/DragController'
import { Logger } from '../extensions/Logger'
import { LayoutConfig } from '../layout/LayoutConfig'
import { mock } from '../test/Mock'
import { CellPage } from './CellPage'

const TAG = "[CellViewPage]"

/**
 *
 * Author: Seagazer
 * Date: 2025/5/31
 */
@ComponentV2
export struct CellViewPage {
    @Local pageList: PageData[] = []
    private swiperController = new SwiperController()
    private dragController: DragController = DragController.getInstance()
    private pageDataManger: PageDataManager = PageDataManager.getInstance()
    private onPageChangedListener: OnPageChangedListener = {
        onPageAdd: (page: PageData) => {
            Logger.d(TAG, "page added id= " + page.screenId)
            this.pageList.push(page)
        },
        onPageDelete: (page: PageData) => {
            Logger.d(TAG, "page deleted id= " + page.screenId)
            let index = this.pageList.indexOf(page)
            if (index >= 0) {
                this.pageList.splice(index, 1)
            }
        }
    }

    aboutToAppear(): void {
        this.pageDataManger.addOnPageChangedListener(this.onPageChangedListener)
        // todo 加载初始数据
        this.pageDataManger.addPage()
        let items = mock()
        for (let i = 0; i < items.length; i++) {
            let item = items[i]
            this.pageDataManger.addItem(0, item)
        }
        this.dragController.setPageData(this.pageDataManger.getPage(0))
    }

    aboutToDisappear(): void {
        this.pageDataManger.removeOnPageChangedListener(this.onPageChangedListener)
    }

    build() {
        Swiper(this.swiperController) {
            Repeat(this.pageList)
                .each((data) => {
                    CellPage({ pageData: data.item })
                })
                .key((item) => item.screenId.toString())
        }
        .indicator(false)
        .loop(false)
        .clip(false)
        .padding({ left: LayoutConfig.getInstance().workspacePaddingLeft, right: LayoutConfig.getInstance().workspacePaddingRight })
        .onDragMove((event) => {
            this.dragController.onDragOver(event)
        })
        .onDrop((event) => {
            this.dragController.onDrop(event)
        })
    }
}