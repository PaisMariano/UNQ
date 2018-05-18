package universidad;

import java.util.Set;

import Utils.Nombrable;

public class Universidad implements Nombrable {

	private String nombre;

	private Set<Carrera> carreras;

	private Set<Area> areas;

	public Set<Carrera> getCarreras() {
		return carreras;
	}

	public void setCarreras(final Set<Carrera> carreras) {
		this.carreras = carreras;
	}

	public Set<Area> getAreas() {
		return areas;
	}

	public void setAreas(final Set<Area> areas) {
		this.areas = areas;
	}

	@Override
	public String getNombre() {
		return nombre;
	}

	public void setNombre(final String nombre) {
		this.nombre = nombre;
	}

}
