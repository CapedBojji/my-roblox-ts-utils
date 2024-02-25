

class RandomSynced {
    private readonly _seed: number;
    private readonly _random: Random;
    private readonly _min: number;
    private readonly _max: number;
    private readonly _memo: Map<number, number>;

    constructor(seed: number, min: number = 0, max: number = 1) {
        this._seed = seed;
        this._random = new Random(seed);
        this._min = min;
        this._max = max;
        this._memo = new Map<number, number>();
    }

    public numberAt(index: number) {
        if (this._memo.has(index)) {
            return this._memo.get(index);
        }
        while (this._memo.size() < index) {
            this._memo.set(this._memo.size(), this._random.NextNumber(this._min, this._max));
        }
        return this._memo.get(index);
    }
}