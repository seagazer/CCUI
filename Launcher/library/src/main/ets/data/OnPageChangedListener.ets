import { PageData } from "./PageData"

/**
 *
 * Author: Seagazer
 * Date: 2025/6/2
 */
export interface OnPageChangedListener {
    onPageAdd: (page: PageData) => void
    onPageDelete: (page: PageData) => void
}