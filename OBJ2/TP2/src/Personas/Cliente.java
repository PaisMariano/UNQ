package Personas;

public class Cliente {
	private String nombre;
	private int dni;
	
	
	
	
	
	
	public Cliente(String nombre, int dni) {
				this.setNombre(nombre);
				this.setDni(dni);
	}
	
		
	public String getNombre(){
		
		return this.nombre;
	}
	public void setNombre(String nom){
		
		this.nombre = nom;
	}
	public int getDni(){
		return this.dni;
	}
	public void setDni(int dni){
		this.dni = dni;
	}
	

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

	
	
	
	
	
}
