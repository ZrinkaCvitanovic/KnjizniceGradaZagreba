package hr.fer.spring_backend.controller

import hr.fer.spring_backend.model.Library
import hr.fer.spring_backend.service.LibraryService
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.*

@Controller
@RequestMapping("/api/library")
class LibraryController(
    private val service: LibraryService
) {
    @GetMapping("/all")
    fun getAll(): ResponseEntity<List<Library>> = ResponseEntity(service.getAll(), HttpStatus.OK)

    @GetMapping("/{id}")
    fun getById(@PathVariable("id") id: String): ResponseEntity<Library> {
        try {
            return ResponseEntity(service.getById(id), HttpStatus.OK)
        } catch (e: RuntimeException) {
            if (e.message == "No library found with the given id.") return ResponseEntity(HttpStatus.NOT_FOUND)
            return ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR)
        }
    }

    @GetMapping("/name/{name}")
    fun getByName(@PathVariable("name") name: String): ResponseEntity<List<Library>> {
        try {
            return ResponseEntity(service.getByName(name), HttpStatus.OK)
        } catch (e: RuntimeException) {
            if (e.message == "No libraries found.") return ResponseEntity(HttpStatus.NOT_FOUND)
            return ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR)
        }
    }

    @GetMapping("/address/{address}")
    fun getByAddress(@PathVariable("address") address: String): ResponseEntity<List<Library>> {
        try {
            return ResponseEntity(service.getByAddress(address), HttpStatus.OK)
        } catch (e: RuntimeException) {
            if (e.message == "No libraries found.") return ResponseEntity(HttpStatus.NOT_FOUND)
            return ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR)
        }
    }

    @GetMapping("/manager/{manager}")
    fun getByManager(@PathVariable("manager") manager: String): ResponseEntity<List<Library>> {
        try {
            return ResponseEntity(service.getByManager(manager), HttpStatus.OK)
        } catch (e: RuntimeException) {
            if (e.message == "No libraries found.") return ResponseEntity(HttpStatus.NOT_FOUND)
            return ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR)
        }
    }

    @PostMapping("/create")
    fun create(@RequestBody library: Library): ResponseEntity<Library> {
        try {
            return ResponseEntity(service.create(library), HttpStatus.OK)
        } catch (e: RuntimeException) {
            if (e.message == "The library already exists.") return ResponseEntity(HttpStatus.NOT_FOUND)
            return ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR)
        }
    }

    @PutMapping("/update")
    fun update(@RequestBody library: Library): ResponseEntity<Library> {
        try {
            return ResponseEntity(service.update(library), HttpStatus.OK)
        } catch (e: RuntimeException) {
            if (e.message == "The library does not exist.") return ResponseEntity(HttpStatus.NOT_FOUND)
            return ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR)
        }
    }

    @DeleteMapping("/{id}")
    fun delete(@PathVariable("id") id: String): ResponseEntity<Unit> {
        try {
            return ResponseEntity(service.delete(id), HttpStatus.OK)
        } catch (e: RuntimeException) {
            if (e.message == "The library does not exist.") return ResponseEntity(HttpStatus.NOT_FOUND)
            return ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR)
        }
    }
}