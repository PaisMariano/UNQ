package entregas;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import materias.Duracion;
import personal.Alumno;

/**
 * TODO: description
 */
public class EvaluacionFinal extends Evaluacion {

	private Map<Duracion, Integer> limiteRendiciones;

	public EvaluacionFinal(final String titulo, final Date fecha) {
		super(titulo, fecha);
		limiteRendiciones = new HashMap<Duracion, Integer>();
	}

	public EvaluacionFinal(final String titulo, final Date fecha, final Alumno alumno,
			final Integer nota) {
		super(titulo, fecha, alumno, nota);
	}

	public void addLimiteRendiciones(final Duracion duracion, final Integer limite) {
		limiteRendiciones.put(duracion, limite);
	}

	public Integer getLimiteRendiciones(final Duracion duracion) {
		return limiteRendiciones.get(duracion);
	}

}
