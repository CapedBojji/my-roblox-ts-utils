class Guid {
	private static readonly generatedGuids: Map<string, boolean> = new Map<string, boolean>();

	public static newGuid(size: number): string {
		let guid: string;
		do {
			guid = Guid.generateGuid(size);
		} while (Guid.generatedGuids.has(guid));
		Guid.generatedGuids.set(guid, true);
		return guid;
	}

	private static generateGuid(size: number): string {
		let guid = "";
		const characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
		for (let i = 0; i < size; i++) {
			guid += characters.sub(i, i + 1);
		}
		return guid;
	}
}
