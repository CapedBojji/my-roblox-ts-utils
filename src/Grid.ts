interface Cell<T> {
	getValue: () => T;
	getX: () => number;
	getY: () => number;
}

enum Direction {
	UP = "UP",
	DOWN = "DOWN",
	LEFT = "LEFT",
	RIGHT = "RIGHT",
}
class CellFactory<T> {
	static createCell<T>(x: number, y: number, value: T): Cell<T> {
		return {
			getValue: () => value,
			getX: () => x,
			getY: () => y,
		};
	}
}

class Grid<T> {
	private _grid: Cell<T>[][];

	constructor(width: number, height: number, initialValue: T) {
		this._grid = new Array(height);
		this._grid.forEach((_, y) => {
			this._grid[y] = new Array(width);
			this._grid[y].forEach((_, x) => {
				this._grid[y][x] = CellFactory.createCell(x, y, initialValue);
			});
		});
	}

	getCell(x: number, y: number): Cell<T> {
		return this._grid[y][x];
	}

	setCell(x: number, y: number, value: T): void {
		this._grid[y][x] = CellFactory.createCell(x, y, value);
	}

	getWidth(): number {
		return this._grid[0].size();
	}

	getHeight(): number {
		return this._grid.size();
	}

	getNextCell(x: number, y: number, direction: Direction): Cell<T> {
		switch (direction) {
			case "UP":
				return this.getCell(x, y - 1);
			case "DOWN":
				return this.getCell(x, y + 1);
			case "LEFT":
				return this.getCell(x - 1, y);
			default:
				return this.getCell(x + 1, y);
		}
	}
}

export default Grid;