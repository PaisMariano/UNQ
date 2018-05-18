package universidad;

import materias.Materia;
import personal.Docente;
import Utils.Historial;

/**
 * Area: Agrupo bajo un mismo concepto las materias y los docentes de temas
 * relacionados.
 */
public class Area {

	private String nombre;

	private Docente director;

	/** Guardar el historial de Docentes */
	private Historial<Docente> staffDocente;

	/** Guardar el historial de Materias */
	private Historial<Materia> materiasDictadas;

	// *****************
	// * Constructores *
	// *****************

	// ********************
	// * Getter & Setters *
	// ********************

	// ********************
	// * Funciones Utiles *
	// ********************
}
