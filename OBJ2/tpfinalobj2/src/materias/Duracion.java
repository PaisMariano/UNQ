package materias;

import Utils.Nombrable;

/**
 * TODO: description
 */
public abstract class Duracion implements Nombrable {

	protected Integer magnitud;

	protected String unidad;

	public Integer getDuracion() {
		return magnitud;
	}

	public String getUnidad() {
		return unidad;
	}

	@Override
	public String getNombre() {
		return this.getDuracion() + " " + this.getUnidad();
	}

}
