package materias;

import java.util.Set;

/**
 * Adapter de Materias que varian por Plan de Estudio
 */
public class MateriasAsignadas {

	private Materia materia;

	private TipoDeMateria tipoDeMateria;

	private Duracion duracion;

	private Set<Materia> correlatividades;

}
