package CuentasBancarias;

import Personas.Cliente;

public class CuentaCorriente extends Cuenta {

	private int cantExtrac = 30;
	
	public CuentaCorriente(int numeroCuenta, Cliente cli) {
		this.setNumCuenta(numeroCuenta);
		this.setTitular(cli);
	
	}

	/**
	 * @param args
	 */
	
	
	
	public int getCantExt(){
		
		return this.cantExtrac;
	}
	public void setCantExt(int cantExt){
		
		this.cantExtrac = cantExt;
	}
	
	public void extraer(int importe){
		
		if(this.cantExtrac <= 30){
		this.setSaldo(this.getSaldo() - importe);
		this.setCantExt(this.getCantExt()- 1);
		System.out.println("Se Extrajo $: " + importe);
		System.out.println("El saldo restante es $: " + this.getSaldo());
		System.out.println("Se pueden realizar: " + this.getCantExt() + " extracciones aun.");
		}
	}
		
	public static void main(String[] args){
			// TODO Auto-generated method stub
		
		Cliente mariano = new Cliente("Mariano", 31601206);
		CuentaCorriente cuenta1 = new CuentaCorriente(1, mariano);
		cuenta1.depositar(1500);
		cuenta1.extraer(1000);
		cuenta1.extraer(1000);
		cuenta1.extraer(1000);
		cuenta1.extraer(1000);
		cuenta1.extraer(1000);
		
		}
}
	
	
		
	
	
	
	
	
	
	
	
	

