package materias;

import java.util.Set;

import Utils.Historial;
import entregas.Evaluacion;
import entregas.TrabajoPractico;

/**
 * Catedra
 */
// Almeceno el Historial del Staff Completo
public class Catedra {

	/** Guardar el historial de Docentes */
	private Historial<StaffCatedra> staff;
	// private StaffCatedra staff;

	private Set<TrabajoPractico> tp;
	private Set<Evaluacion> examenes;

}
