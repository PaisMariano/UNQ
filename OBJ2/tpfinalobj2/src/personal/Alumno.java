package personal;

import java.util.ArrayList;
import java.util.List;

import materias.InscripcionMateria;
import materias.MateriaAprobada;
import universidad.InscripcionCarrera;
import entregas.EntregaTP;

public class Alumno {

	private Persona datosPersonales;

	private Integer legajo;

	private List<EntregaTP> entregas;

	private List<InscripcionCarrera> carrerasInscriptas;

	private List<InscripcionMateria> materiasInscriptas;

	private List<MateriaAprobada> materiasAprobadas;

	// *****************
	// * Constructores *
	// *****************
	public Alumno(final Persona datosPersonales, final Integer legajo) {
		super();
		this.datosPersonales = datosPersonales;
		this.legajo = legajo;
		entregas = new ArrayList<EntregaTP>();
		carrerasInscriptas = new ArrayList<InscripcionCarrera>();
		materiasInscriptas = new ArrayList<InscripcionMateria>();
		materiasAprobadas = new ArrayList<MateriaAprobada>();
	}

	// ********************
	// * Getter & Setters *
	// ********************
	public List<EntregaTP> getEntregas() {
		return entregas;
	}

	public void setEntregas(final List<EntregaTP> entregas) {
		this.entregas = entregas;
	}

	public List<InscripcionCarrera> getCarrerasInscriptas() {
		return carrerasInscriptas;
	}

	public void setCarrerasInscriptas(final List<InscripcionCarrera> carrerasInscriptas) {
		this.carrerasInscriptas = carrerasInscriptas;
	}

	public List<?> getMateriasInscriptas() {
		return materiasInscriptas;
	}

	public void setMateriasInscriptas(final List<InscripcionMateria> materiasInscriptas) {
		this.materiasInscriptas = materiasInscriptas;
	}

	public List<MateriaAprobada> getMateriasAprobadas() {
		return materiasAprobadas;
	}

	public void setMateriasAprobadas(final List<MateriaAprobada> materiasAprobadas) {
		this.materiasAprobadas = materiasAprobadas;
	}

	public Persona getDatosPersonales() {
		return datosPersonales;
	}

	public void setDatosPersonales(final Persona datosPersonales) {
		this.datosPersonales = datosPersonales;
	}

	public Integer getLegajo() {
		return legajo;
	}

	public void setLegajo(final Integer legajo) {
		this.legajo = legajo;
	}

	@Override
	public int hashCode() {
		return legajo.hashCode() + datosPersonales.hashCode();
	}

	// @Override
	// public boolean equals(final Object obj) {
	// return this.hashCode() == obj.hashCode();
	// }

}
