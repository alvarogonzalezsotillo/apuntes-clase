/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

//package unidad6;

/**
 *
 * @author david
 */
//import unidad4.Aleat_interv;
public class Matriz {
private int matriz[][];
final int DIM=3;



/* Rellenamos la matriz */

public Matriz(int m[][]){
    matriz=new int[3][3];
    for(int i=0;i<DIM;i++){
	for(int j=0;j<DIM;j++){
		matriz[i][j]=m[i][j];
	}
}
}
public int[][]Dev_mat(){
    return matriz;
}
public void Rota_izqda(){
int aux,aux2=matriz[0][0]; /* guardamos en aux2 el valor del primer elemento de la matriz,
esquina superior izquierda */
for(int i=0;i<DIM;i++){
	for(int j=0;j<DIM;j++){

			if(j!=(DIM-1)){ /* si se trata de cualquier elemento que no sea el
		Ãºltimo de la fila en cuyo caso habrÃ¡ que desplazarlo a la primera columna
		de la anterior fila */
				aux=matriz[i][j];
            	matriz[i][j]=matriz[i][j+1];
            	matriz[i][j+1]=aux;
			}
			else if((i==(DIM-1))&&(j==(DIM-1))) matriz[i][j]=aux2; /* si es el
				Ãºltimo elemento habrÃ¡ que rotarlo con aux2 que es donde guardamos
			el valor del primer elemento de la matriz */
			else{ /* en el caso de las Ãºltimas columnas de cada fila se rota
			hacia el primer elemento de la fila anterior */
				aux=matriz[i][j];
				matriz[i][j]=matriz[i+1][0];
				matriz[i+1][0]=aux;
			}
	}
}
}
public void Rota_dcha(){
int aux,aux2=matriz[DIM-1][DIM-1]; /* guardamos en aux2 el valor del Ãºltimo elemento de la matriz,
esquina inferior derecha */
for(int i=(DIM-1);i>=0;i--){
	for(int j=(DIM-1);j>=0;j--){

			if(j!=0){ /* si se trata de cualquier elemento que no sea el
		primero de la fila en cuyo caso habrÃ¡ que desplazarlo a la Ãºltima columna
		de la anterior fila */
				aux=matriz[i][j];
            	matriz[i][j]=matriz[i][j-1];
            	matriz[i][j-1]=aux;
			}
			else if((i==0)&&(j==0)) matriz[i][j]=aux2; /* si es el
				primer elemento habrÃ¡ que rotarlo con aux2 que es donde guardamos
			el valor del primer Ãºltimo elemento de la matriz de la matriz */
			else{ /* en el caso de las primeras columnas de cada fila se rota
			hacia el Ãºltimo elemento de la fila anterior */
				aux=matriz[i][j];
				matriz[i][j]=matriz[i-1][DIM-1];
				matriz[i-1][DIM-1]=aux;
			}
	}
}
}
public void Esc_matriz(){
System.out.printf("\nLa matriz es:\n");
for(int i=0;i<DIM;i++){
	System.out.printf("\n");
	for(int j=0;j<DIM;j++){
			System.out.printf("%d ",matriz[i][j]);
		}
}
}
}
