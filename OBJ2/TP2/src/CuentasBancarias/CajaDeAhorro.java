package CuentasBancarias;

import Personas.Cliente;

public class CajaDeAhorro extends Cuenta {

	public CajaDeAhorro(int numeroCuenta, Cliente cli ) {
		this.setNumCuenta(numeroCuenta);
		this.setTitular(cli);
	}

	/**
	 * @param args
	 */
	public void extraer(int importe){
		
		if(this.saldo - importe > 0){
			this.saldo = this.saldo - importe;
			System.out.println("Se Extrajo $: " + importe);
			System.out.println("El saldo restante es $: " + this.getSaldo());
			}
		else{
			System.out.println("No se puede extraer $: " + importe + " el saldo restante es $: " + this.getSaldo());
	
		}
			
		}
	
	
	public static void main(String[] args){
		// TODO Auto-generated method stub
		Cliente mariano = new Cliente("Mariano", 31601206);
		CajaDeAhorro cuenta1 = new CajaDeAhorro(1, mariano);
		cuenta1.depositar(1500);
		cuenta1.extraer(1000);
		cuenta1.extraer(1000);
		
	}

		
	
	
	
}
