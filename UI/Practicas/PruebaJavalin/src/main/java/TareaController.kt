import io.javalin.NotFoundResponse
import java.time.LocalDate
import java.util.*

data class Tarea(var id: Int,
                 var titulo: String,
                 var descripcion: String,
                 var fechaCreacion: LocalDate,
                 var estado: String)

class TareaController{
    private var ultimoId = 0
    private val tareas = mutableListOf<Tarea>()

    fun getAll(): List<Tarea> = this.tareas

    fun getTarea(id: Int): Tarea {
        return this.tareas.firstOrNull{ it.id == id}
                ?: throw NotFoundResponse("No se encontro la tarea con id $id")
    }
    fun addTarea(titulo: String, descripcion: String, fechaCreacion: LocalDate, estado: String): Tarea{
        val newTarea = Tarea(++ultimoId, titulo, descripcion, fechaCreacion, estado)
        this.tareas.add(newTarea)
        return newTarea
    }

    fun deleteTarea(id: Int){
        this.tareas.remove(getTarea(id))
    }

    fun updateTarea(id: Int, newTarea: Tarea): Tarea{
        val tareaVieja = this.getTarea(id)
        val tareaNueva = Tarea(id, newTarea.titulo, newTarea.descripcion, newTarea.fechaCreacion, newTarea.estado)
        this.tareas.remove(tareaVieja)
        this.tareas.add(tareaNueva)
        return tareaNueva
    }
}