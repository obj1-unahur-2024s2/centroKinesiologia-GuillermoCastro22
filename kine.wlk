class Paciente {
    var edad
    var fortalezaMuscular
    var dolor
    const rutina = []

    method edad() = edad

    method fortalezaMuscular() = fortalezaMuscular

    method dolor() = dolor 

    method disminuirDolor(unValor) {
      dolor -= (dolor -unValor).max(0)
    }
    method aumentarFortaleza(unValor){
        fortalezaMuscular += unValor 
    }
    method puedeUsar(unAparato) =
        unAparato.puedeSerUsadoPor(self)
    
    method usar(unAparato) =
        unAparato.consecuenciaDelUso(self)
    method cumpliranios() {
      edad += 1
    }
    method puedeHacerRutina() =
        rutina.all{a => self.puedeUsar(a)}

    method realizarRutina(){
        rutina.forEach {a => self.usar(a)}
    }
    method cargarRutina(unaLista){
        rutina.clear()
        rutina.addAll(unaLista)
    }
    
}

class Aparato {
    method consecuenciaDelUso(unPaciente)
    method puedeSerUsadoPor(unPaciente) 
}

class Magneto inherits Aparato {
    override  method consecuenciaDelUso(unPaciente){
        unPaciente.disminuirDolor(
            unPaciente.dolor() * 0.1
        )
    }
    override method puedeSerUsadoPor(unPaciente){
        return true
    }

}

class Bici inherits Aparato {
    override  method consecuenciaDelUso(unPaciente){
        unPaciente.disminuirDolor(
            unPaciente.dolor() * 4
        )
        unPaciente.aumentarFortaleza(3)
    }
    override method puedeSerUsadoPor(unPaciente){
        unPaciente.edad() < 8
    }

    
}

class MiniTramp inherits Aparato {
    override  method consecuenciaDelUso(unPaciente){
        unPaciente.aumentarFortaleza(
            unPaciente.edad() * 0.1
        )
    }
    override method puedeSerUsadoPor(unPaciente){
        unPaciente.dolor() < 20
    }
}

class Resistente inherits Paciente {
    override method realizarRutina(){
        super()
        self.aumentarFortaleza(
            rutina.count{a => self.puedeUsar(a)}
        )
    }
}