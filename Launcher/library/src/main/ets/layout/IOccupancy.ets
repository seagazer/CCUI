/**
 *
 * Author: Seagazer
 * Date: 2025/6/19
 */
export interface IOccupancy {
    findVacantCell(vacantOut: number[], spanX: number, spanY: number): boolean

    isVacant(x: number, y: number, spanX: number, spanY: number): boolean

    mark(cellX: number, cellY: number, spanX: number, spanY: number, value: boolean): void

    clear(): void
}