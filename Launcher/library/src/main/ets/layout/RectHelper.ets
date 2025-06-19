import { Rect } from '@kit.ArkUI'

/**
 *
 * Author: Seagazer
 * Date: 2025/6/2
 */
export class RectHelper {
    static isCross(dragRect: Rect, targetRect: Rect): boolean {
        if (dragRect.right < targetRect.left || targetRect.right < dragRect.left) {
            return false
        }
        if (dragRect.bottom < targetRect.top || targetRect.bottom < dragRect.top) {
            return false
        }
        return true
    }

    static isInFolderArea(dragRect: Rect, targetRect: Rect): boolean {
        return false
    }
}