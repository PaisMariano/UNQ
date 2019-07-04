import io.javalin.Context
import io.javalin.NotFoundResponse
import org.eclipse.jetty.http.HttpStatus.*

class TareaControllerContext {
    private var ultimoId = 0
    private val tareas = mutableListOf<Tarea>()

    fun getAll(ctx: Context){
        ctx.json(tareas)
    }

    fun getTarea(ctx: Context){
        val id = ctx.pathParam("id").toInt()
        ctx.json(this.getTareaById(id))
    }

    fun addTarea(ctx: Context){
        val tarea = ctx.body<Tarea>()
        ctx.status(CREATED_201)
        ctx.json(this.addTareaModel(tarea))
    }

    fun updateTarea(ctx: Context){
        val id = ctx.pathParam("id").toInt()
        val newTask = ctx.body<Tarea>()
        val oldTarea = getTareaById(id)
        val newTarea = Tarea(oldTarea.id, newTask.titulo, newTask.descripcion, newTask.fechaCreacion, newTask.estado)
        this.tareas.remove(oldTarea)
        this.tareas.add(newTarea)
        ctx.json(newTarea)
    }

    fun removeTarea(ctx: Context){
        val id = ctx.pathParam("id").toInt()
        this.tareas.remove(this.getTareaById(id))
        ctx.status(NO_CONTENT_204)
    }

    private fun addTareaModel(tarea: Tarea): Tarea {
        val newTarea = Tarea(++ultimoId, tarea.titulo, tarea.descripcion, tarea.fechaCreacion, tarea.estado)
        this.tareas.add(newTarea)
        return newTarea
    }

    private fun getTareaById(id: Int): Tarea{
        return this.tareas.firstOrNull { it.id == id }
                ?: throw NotFoundResponse("No se encontro el id $id")
    }
}