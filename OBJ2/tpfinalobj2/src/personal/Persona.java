package personal;

/**
 * Administracion de los Datos personales
 */
public class Persona {

	private Integer dni;

	private String nombre;

	private String apellido;

	private String mail;

	private Integer telFijo;

	private Integer celular;

	private String direccion;

	private String sexo;

	private String estadoCivil;

	// *****************
	// * Constructores *
	// *****************
	public Persona(final Integer dni, final String nombre, final String apellido, final String sexo) {
		super();
		this.dni = dni;
		this.nombre = nombre;
		this.apellido = apellido;
		this.sexo = sexo;
	}

	public Persona(final Integer dni, final String nombre, final String apellido,
			final String mail, final Integer telFijo, final Integer celular,
			final String direccion, final String sexo, final String estadoCivil) {

		this(dni, nombre, apellido, sexo);
		this.mail = mail;
		this.telFijo = telFijo;
		this.celular = celular;
		this.direccion = direccion;
		this.estadoCivil = estadoCivil;
	}

	// ********************
	// * Getter & Setters *
	// ********************
	public Integer getDni() {
		return dni;
	}

	public void setDni(final Integer dni) {
		this.dni = dni;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(final String nombre) {
		this.nombre = nombre;
	}

	public String getApellido() {
		return apellido;
	}

	public void setApellido(final String apellido) {
		this.apellido = apellido;
	}

	public String getMail() {
		return mail;
	}

	public void setMail(final String mail) {
		this.mail = mail;
	}

	public Integer getTelFijo() {
		return telFijo;
	}

	public void setTelFijo(final Integer telFijo) {
		this.telFijo = telFijo;
	}

	public Integer getCelular() {
		return celular;
	}

	public void setCelular(final Integer celular) {
		this.celular = celular;
	}

	public String getDireccion() {
		return direccion;
	}

	public void setDireccion(final String direccion) {
		this.direccion = direccion;
	}

	public String getSexo() {
		return sexo;
	}

	public void setSexo(final String sexo) {
		this.sexo = sexo;
	}

	public String getEstadoCivil() {
		return estadoCivil;
	}

	public void setEstadoCivil(final String estadoCivil) {
		this.estadoCivil = estadoCivil;
	}

	@Override
	public int hashCode() {
		return dni.hashCode();
	}

}
