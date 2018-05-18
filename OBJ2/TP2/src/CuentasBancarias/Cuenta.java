package CuentasBancarias;

import Personas.Cliente;

public abstract class Cuenta {

	public int numeroCuenta;
	public int saldo = 0;
	public Cliente titular;	
	
	public void setTitular(Cliente titular){
		this.titular = titular;
	}
	public Cliente getTitular(Cliente titular){
		return this.titular;
	}
	
	public int getNumCuenta(){
		return this.numeroCuenta; 
	}
	public void setNumCuenta(int numCuenta){
		this.numeroCuenta = numCuenta;
	}
	public int getSaldo(){
		return this.saldo; 
	}
	public void setSaldo(int unMonto){
		this.saldo = unMonto;
	}	

	public void depositar(int importe){
		
		this.saldo = this.saldo + importe;
		System.out.println("El saldo restante es $: " + this.saldo);
		
	}
	public abstract void extraer(int importe);
	
	
	
				
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
	