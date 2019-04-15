//
//  ViewController.swift
//  MichiApp
//
//  Created by E4401 on 4/3/18.
//  Copyright © 2018 Universidad de Lima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var butCasillas: [UIButton]!
    @IBOutlet weak var labMensaje: UILabel!
    @IBAction func butReiniciar(_ sender: UIButton) {
        contador = 0;
        asignarTema();
        for i in 0..<butCasillas.count{
            michiManager.tablero[i] = 0;
            voltearCasilla(casilla: butCasillas[i],jugador: michiManager.tablero[i]);
            butCasillas[i].isEnabled=true;
        }
        michiManager.jugadorTurno = -1;
        //Al hacer click en reiniciar, cambiaremos el fondo de nuestro programa y los emoticones haciendo uso del random definido en michimanager; ademas, volveremos a llenar el arreglo de ceros para volver a jugar y se habilitan los botones que fueron deshabilitados cuando se encontro un ganador
    }
    
    var michiManager: MichiManager = MichiManager()
    
    func asignarTema(){
        michiManager.random = Int(arc4random_uniform(4) + 1) //Random desde el 0 al 4
        if michiManager.random == 4{
            self.view.backgroundColor = UIColor.purple
        }
        else if michiManager.random == 3{
            self.view.backgroundColor = UIColor.red
        }
        else if michiManager.random == 2{
            self.view.backgroundColor = UIColor.green
        }
        else if michiManager.random == 1{
            self.view.backgroundColor = UIColor.blue
        }
        else{
            self.view.backgroundColor = UIColor.black
        }
        //Esta funcion pintara el background de un color determinado dependiendo del valor obtenido en el random
    }
    
    var contador: Int = 0{
        didSet{
            if contador < 9{
                            labMensaje.text = "Número de intentos: \(contador)";
            }
        }
    }
    
    @IBAction func seleccionarCasiilla(_ sender: UIButton) {
        var ganaste: Bool = false;
        contador += 1;

        if let indiceSeleccionado = butCasillas.index(of: sender), ganaste == false{
            michiManager.realizarJugada(posicion: indiceSeleccionado)
            refrescarTablero()
            if michiManager.verificarGanador() != 0{
                
                if michiManager.jugadorTurno == 1{
                    labMensaje.text = "Ganó el jugador 1, jugaron \(contador) intentos";
                    ganaste = true;
                    for i in 0..<butCasillas.count{
                        butCasillas[i].isEnabled=false
                    }
                }else{
                    labMensaje.text = "Ganó el jugador 2, jugaron \(contador) intentos";
                    ganaste = true;
                    for i in 0..<butCasillas.count{
                        butCasillas[i].isEnabled=false
                    }
                }
            }
            if ganaste == false, contador >= 9{
                labMensaje.text = "Empate!";
            }
        }
        //Dependiendo de la casilla seleccionada se obtendra el indice para localizar su posicion en el arreglo de una dimension. Luego se llenara la posicion con el turno que representa al jugador y se evaluara si hay un ganador; de ser asi, se deshabilitan los botones hasta reiniciar.
    }
    
    func voltearCasilla(casilla boton: UIButton, jugador: Int){
        boton.setTitle(String(jugador), for: UIControlState.normal)
        
        if jugador == -1{
            if michiManager.random == 4{
                boton.setTitle("🐶", for: UIControlState.normal)
            }
            else if michiManager.random == 3{
                boton.setTitle("🌝", for: UIControlState.normal)
            }
            else if michiManager.random == 2{
                boton.setTitle("☀️", for: UIControlState.normal)
            }
            else if michiManager.random == 1{
                boton.setTitle("⚽️", for: UIControlState.normal)
            }
            else{
                boton.setTitle("🚹", for: UIControlState.normal)
            }
        }
        else if jugador == 1{
            if michiManager.random == 4{
                boton.setTitle("🐭", for: UIControlState.normal)
            }
            else if michiManager.random == 3{
                boton.setTitle("🌚", for: UIControlState.normal)
            }
            else if michiManager.random == 2{
                boton.setTitle("🌧", for: UIControlState.normal)
            }
            else if michiManager.random == 1{
                boton.setTitle("🏀", for: UIControlState.normal)
            }
            else{
                boton.setTitle("🚺", for: UIControlState.normal)
            }
        }
        else if jugador == 0{
            if michiManager.random == 4{
                boton.setTitle("🐱", for: UIControlState.normal)
            }
            else if michiManager.random == 3{
                boton.setTitle("🌗", for: UIControlState.normal)
            }
            else if michiManager.random == 2{
                boton.setTitle("☁️", for: UIControlState.normal)
            }
            else if michiManager.random == 1{
                boton.setTitle("🏆", for: UIControlState.normal)
            }
            else{
                boton.setTitle("🚼", for: UIControlState.normal)
            }
        }
        //Dependiendo del valor que tenga el random, tendremos diferentes emoticones para el icono de juego del jugador 1, jugador 2 y el espacio sin jugar
    }
    
    func refrescarTablero(){
        for i in 0..<butCasillas.count{
            if michiManager.tablero[i] != 0{
                voltearCasilla(casilla: butCasillas[i],jugador: michiManager.tablero[i])
            }
        }
        //Cada vez que se realice una jugada se refrescara el tablero para que de manera visual los jugadores identifiquen sus casillas.
    }
    
    

}

