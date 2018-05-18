package universidad;

import java.util.LinkedList;
import java.util.List;

/**
 * Suguierre un recorrido de materias que se pueden cursar en un mismo Nivel
 * (lapso de tiempo)
 */
public class RecorridoSugerido {

	private List<Nivel> recorrido;

	public RecorridoSugerido() {
		super();
		recorrido = new LinkedList<Nivel>();
	}

	public void addNivel(final Nivel materia) {
		recorrido.add(materia);
	}

	public List<Nivel> getRecorrido() {
		return recorrido;
	}

}
