package entregas;

import java.util.Date;

import personal.Alumno;

/**
 * TODO: description
 */
public class EvaluacionParcial extends Evaluacion {

	public EvaluacionParcial(final String titulo, final Date fecha) {
		super(titulo, fecha);
	}

	public EvaluacionParcial(final String titulo, final Date fecha, final Alumno alumno,
			final Integer nota) {
		super(titulo, fecha, alumno, nota);
	}

}
