package universidad;

/**
 * Solicitado
 */
public class PaseSolicitado extends EstadoPase {

	@Override
	public String getNombre() {
		return "Solicitado";
	}

	// @Override
	// public EstadoPase next() {
	// return new PaseEnConsejo();
	// }

}
