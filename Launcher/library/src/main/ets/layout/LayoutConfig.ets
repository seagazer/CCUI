import { display, Size, window } from '@kit.ArkUI'
import { Logger } from '../extensions/Logger'
import { LayoutTemplate } from '../bean/LayoutTemplate'

const TAG = "[LayoutConfig]"


/**
 *
 * Author: Seagazer
 * Date: 2025/6/11
 */
export class LayoutConfig {
    static Debug = false
    // todo 根据X,Y动态计算
    private uiContext: UIContext | null = null
    private defaultTemplate: LayoutTemplate = { x: 0, y: 0 }
    private layoutTemplates: LayoutTemplate[] = []
    // workspace
    private workspaceWidth: number = 0
    private workspaceHeight: number = 0
    workspacePaddingLeft: number = 8
    workspacePaddingRight: number = 8
    workspacePaddingTop: number = 8
    workspacePaddingBottom: number = 8
    cellViewPageHeight: number = 0
    // dock
    // private dockWidth: number = 0
    dockHeight: number = 0
    dockPaddingTop: number = 0
    dockPaddingBottom: number = 0
    // indicate
    private indicatorWidth: number = 1
    private indicatorHeight: number = 32
    // cell
    private cellWidth: number = 0
    private cellHeight: number = 0
    cellTitleHeight: number = 24
    cellPaddingTop: number = 16

    private constructor() {
    }

    private static sInstance = new LayoutConfig()

    static getInstance(): LayoutConfig {
        return LayoutConfig.sInstance
    }

    getTemplate(): LayoutTemplate {
        return this.defaultTemplate
    }

    setUIContext(uiContext: UIContext) {
        this.uiContext = uiContext
    }

    onCreate() {
        this.resize()
        display.on("change", () => {
            this.resize()
        })
    }

    private resize() {
        const dis = display.getDefaultDisplaySync()
        Logger.d(TAG, "display= " + JSON.stringify(dis))
        this.workspaceWidth = dis.width / dis.densityPixels // vp
        // todo 减去状态栏高度
        // todo 读取系统配置文件
        this.workspaceHeight = dis.height / dis.densityPixels - 39
        // todo 需要分开处理pad和phone
        const templateX = [4, 5]
        const maxHeight = this.workspaceHeight - this.workspacePaddingTop - this.workspacePaddingBottom - this.indicatorHeight
            - this.dockPaddingTop - this.dockPaddingBottom
        for (let i = 0; i < templateX.length; i++) {
            const x = templateX[i]
            const cellWidth = (this.workspaceWidth - this.workspacePaddingLeft - this.workspacePaddingRight) / x
            const y = Math.floor(maxHeight / cellWidth) - 1
            this.layoutTemplates.push({ x: x, y: y })
        }
        Logger.i(TAG, "layout templates= " + JSON.stringify(this.layoutTemplates))
        this.defaultTemplate = this.layoutTemplates[0]
        this.cellWidth =
            this.cellHeight = (this.workspaceWidth - this.workspacePaddingLeft - this.workspacePaddingRight) / this.defaultTemplate.x
        this.cellViewPageHeight = this.cellHeight * this.defaultTemplate.y

        this.dockHeight = this.cellHeight + this.dockPaddingTop + this.dockPaddingBottom
        const blankHeight = this.workspaceHeight - this.indicatorHeight - this.dockHeight - this.cellViewPageHeight -
        this.workspacePaddingTop - this.workspacePaddingBottom
        Logger.i(TAG, "blankHeight= " + blankHeight)
    }

    getContentSize(spanX: number, spanY: number): Size {
        const height = this.cellHeight * spanY - this.cellTitleHeight - this.cellPaddingTop
        const horizontalPadding = (this.cellTitleHeight + this.cellPaddingTop) / 2
        const width = this.cellWidth * spanX - horizontalPadding * 2
        const result: Size = { width: width, height: height }
        return result
    }

    loadConfig() {

    }
}
