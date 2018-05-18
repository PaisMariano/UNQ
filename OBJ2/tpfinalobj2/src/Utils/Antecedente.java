package Utils;

import java.util.Date;

/**
 * TODO: description
 */
public class Antecedente<T> {

	private T elemento;

	private Date fechaInicio;

	private Date fechaFin;

	// *****************
	// * Constructores *
	// *****************
	public Antecedente() {
		super();
	}

	public Antecedente(final T elemento) {
		this();
		this.elemento = elemento;
	}

	public Antecedente(final T elemento, final Date fechaInicio) {
		this(elemento);
		this.fechaInicio = fechaInicio;
	}

	public Antecedente(final T elemento, final Date fechaInicio, final Date fechaFin) {
		this(elemento, fechaInicio);
		this.fechaFin = fechaFin;
	}

	// ********************
	// * Getter & Setters *
	// ********************
	public Date getFechaInicio() {
		return fechaInicio;
	}

	public void setFechaInicio(final Date fechaInicio) {
		this.fechaInicio = fechaInicio;
	}

	public Date getFechaFin() {
		return fechaFin;
	}

	public void setFechaFin(final Date fechaFin) {
		this.fechaFin = fechaFin;
	}

	public T getElemento() {
		return elemento;
	}

	public void setElemento(final T elemento) {
		this.elemento = elemento;
	}

	public boolean sameElement(final T elemento) {
		return this.elemento.equals(elemento);
	}

	// ********************
	// * Funciones Utiles *
	// ********************
	/** Verifico si un elemento esta en una fecha */
	public boolean transcurrioEn(final Date fecha) {
		boolean rta = false;

		if (fechaInicio != null) {
			rta = fecha.after(fechaInicio);
			if (fechaFin != null) {
				rta = rta && fecha.before(fechaFin);
			}
		}

		return rta;
	}

	@Override
	public boolean equals(final Object obj) {
		boolean rta = false;

		if (!(obj == null || this.getClass() != obj.getClass())) {
			if (this == obj) {
				rta = true;
			} else {
				rta = this.isSame((Antecedente<T>) obj);
			}
		}
		return rta;
	}

	public boolean isSame(final Antecedente<T> antecedente) {
		boolean rta;

		if (this.sameElement(antecedente) && this.sameFechaInicio(antecedente)
				&& this.sameFechaFin(antecedente)) {
			rta = true;
		} else {
			rta = false;
		}

		return rta;
	}

	/** Comparo que el Antecedente este hablando del mismo elemento */
	public boolean sameElement(final Antecedente<T> antecedente) {
		return this.getElemento() == null ? antecedente.getElemento() == null : this.getElemento()
				.equals(antecedente.getElemento());
	}

	private boolean sameFechaInicio(final Antecedente<T> antecedente) {
		return this.getFechaInicio() == null ? antecedente.getFechaInicio() == null : this
				.getFechaInicio().equals(antecedente.getFechaInicio());
	}

	private boolean sameFechaFin(final Antecedente<T> antecedente) {
		return this.getFechaFin() == null ? antecedente.getFechaFin() == null : this.getFechaFin()
				.equals(antecedente.getFechaFin());
	}
}
