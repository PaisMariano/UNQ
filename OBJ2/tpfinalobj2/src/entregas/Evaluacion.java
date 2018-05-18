package entregas;

import java.util.Date;

import personal.Alumno;

/**
 * TODO: description
 */
public abstract class Evaluacion {

	private String titulo;

	private Date fecha;

	private Alumno alumno;

	private Integer nota;

	public Evaluacion(final String titulo, final Date fecha) {
		super();
		this.titulo = titulo;
		this.fecha = fecha;
	}

	public Evaluacion(final String titulo, final Date fecha, final Alumno alumno, final Integer nota) {
		this(titulo, fecha);
		this.alumno = alumno;
		this.nota = nota;
	}

	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(final String titulo) {
		this.titulo = titulo;
	}

	public Date getFecha() {
		return fecha;
	}

	public void setFecha(final Date fecha) {
		this.fecha = fecha;
	}

	public Alumno getAlumno() {
		return alumno;
	}

	public void setAlumno(final Alumno alumno) {
		this.alumno = alumno;
	}

	public Integer getNota() {
		return nota;
	}

	public void setNota(final Integer nota) {
		this.nota = nota;
	}

}
