package universidad;

/**
 * En Consejo
 */
public class PaseEnConsejo extends EstadoPase {

	@Override
	public String getNombre() {
		return "En Consejo";
	}

	// @Override
	// public EstadoPase next() {
	// return new PaseRechazado();
	// return new PaseAprobado();
	// }

}
