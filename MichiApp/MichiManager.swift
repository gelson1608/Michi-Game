//
//  MichiManager.swift
//  MichiApp
//
//  Created by E4401 on 4/10/18.
//  Copyright © 2018 Universidad de Lima. All rights reserved.
//

import Foundation

class MichiManager{
    var random: Int   //variable creada para modificar temas del programa
    var tablero: [Int] //arreglo de una dimension donde se colocan las jugadas
    var jugadorTurno: Int //variable que representa al jugador que debe realizar la siguiente jugada
    let n = 3
    
    init(){
        random = 0
        jugadorTurno = -1
        tablero = [Int]()
        inicializarTablero() //Se inicializan los valores del arreglo en 0 llamando a la funcion
    }
    
    func inicializarTablero(){
        for _ in 0..<(n*n){
            tablero.append(0)
        }
    }
    
    func realizarJugada(posicion: Int){
        if tablero[posicion] == 0{
            tablero[posicion] = jugadorTurno
            if jugadorTurno == -1{
                jugadorTurno = 1;  //Cuando un jugador realice una jugada, se pondra el valor en el arreglo y se cambia de turno
            }else{
                jugadorTurno = -1;
            }
        }
    }
    
    func calcularColumnas() -> Int{
        
        var suma: Int = 0;
        var ganador: Bool = false;
        for i in 0..<9{
            print("\(tablero[i])");
        }
        for i in 0..<n{
            for j in stride(from: 0, through: (n*n)-1, by: n) {
                suma = suma + tablero[j+i];
            }
            if ganador == false{
                if suma == (-n) {      //Calculamos la columna ganadora
                    ganador = true;
                    return -1;
                }else if suma == n{
                    ganador = true;
                    return 1;
                }
            }
        }
        return 0;
        
    }
    
    func calcularFilas() -> Int{
        var suma: Int = 0;
        var cont: Int = 0;
        var ganador: Bool = false;
        for i in 0..<n*n{
            suma = suma + tablero[i];
            cont = cont + 1;
            if cont == n, ganador == false{
                if suma == (-n) {
                    ganador = true;     //Calculamos la fila ganadora
                    return -1;
                }else if suma == n{
                    ganador = true;
                    return 1;
                }
                cont = 0;
                suma = 0;
            }
        }
        return 0;
    }
    
    func calcularDiagonal1() -> Int{
        var suma: Int = 0;
        var ganador: Bool = false;
        for i in stride(from: 0, through: (n*n)-1, by: n+1){
                suma = suma + tablero[i];
        }
        if ganador == false{
            if suma == (-n) {
                ganador = true;         //Calculamos si hay algun ganador por las diagonales
                return -1;
            }
            else if suma == n{
                ganador = true;
                return 1
            }
        }
        return 0;
    }
    
    func calcularDiagonal2() -> Int{
        var suma: Int = 0;
        var ganador: Bool = false;
        for i in stride(from: n-1, to: (n*n)-1, by: n-1){
            suma = suma + tablero[i];
        }
        if ganador == false{
            if suma == (-n) {
                ganador = true;
                return -1;
            }
            else if suma == n{
                ganador = true;
                return 1
            }
        }
        return 0;
    }
    
    
    func verificarGanador() -> Int{
        if calcularFilas() == -1 || calcularColumnas() == -1 || calcularDiagonal1() == -1 || calcularDiagonal2() == -1{
            return -1;
        }else if calcularFilas() == 1 || calcularColumnas() == 1 || calcularDiagonal1() == 1 || calcularDiagonal2() == 1{
            return 1;
        }
        return 0;
    }
    //Luego de realizar cada jugada, se verifica si hay un ganador y se devuelve el numero que representa al jugador ganador; caso contrario, devuelve 0
}
