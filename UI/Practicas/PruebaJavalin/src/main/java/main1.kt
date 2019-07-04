import io.javalin.Javalin
import com.fasterxml.jackson.databind.exc.MismatchedInputException
import org.eclipse.jetty.http.HttpStatus.BAD_REQUEST_400
import java.time.LocalDate

fun main() {
    val app = Javalin.create()
            .enableRouteOverview("/routes")
            .exception(MismatchedInputException::class.java) { e, ctx ->
                ctx.status(BAD_REQUEST_400)
                ctx.json(mapOf(
                        "status" to BAD_REQUEST_400,
                        "message" to e.message
                ))
            }
            .start(7000)

// ctx = Context
// ctx.req -> Request
// ctx.res -> Response
    app.get("/") { ctx ->
        ctx.json("Hello World")
    }

// Instancio el controller
// Le agrego data para poder probar inicialmente
    val tareaController: TareaController = TareaController()
    tareaController.addTarea("tarea1", "pepe", LocalDate.now(), "Terminado")
    tareaController.addTarea("tarea2", "pepe", LocalDate.now(), "Terminado")
    tareaController.addTarea("tarea3", "pepe", LocalDate.now(), "Terminado")

// CRUD de Lugares
    app.get("tareas") { ctx ->
        ctx.json(tareaController.getAll())
    }
}