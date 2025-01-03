package hr.fer.spring_backend.service

import hr.fer.spring_backend.model.Library
import hr.fer.spring_backend.repository.LibraryRepository
import org.springframework.stereotype.Service

@Service
class LibraryService(
    private val repository: LibraryRepository
) {
    fun getAll(): List<Library> = repository.findAll()

    @Throws(RuntimeException::class)
    fun getById(id: String): Library =
        repository.findById(id).orElseThrow { RuntimeException("No library found with the given id.") }

    @Throws(RuntimeException::class)
    fun getByName(name: String): List<Library> {
        val libraries = repository.findByName(name)
        validateListResult(libraries)
        return libraries
    }

    @Throws(RuntimeException::class)
    fun getByAddress(address: String): List<Library> {
        val libraries = repository.findByAddress(address)
        validateListResult(libraries)
        return libraries
    }

    @Throws(RuntimeException::class)
    fun getByManager(manager: String): List<Library> {
        val libraries = repository.findByManager(manager)
        validateListResult(libraries)
        return libraries
    }

    @Throws(RuntimeException::class)
    private fun validateListResult(list: List<Library>) {
        if (list.isEmpty()) throw RuntimeException("No libraries found.")
    }

    @Throws(RuntimeException::class)
    fun create(library: Library): Library {
        val existingLibrary = repository.findByAddress(library.address)
        if (existingLibrary.isNotEmpty()) throw RuntimeException("The library already exists.")
        return repository.save(library)
    }

    @Throws(RuntimeException::class)
    fun update(library: Library): Library {
        if (library.id == null) throw RuntimeException("The library does not exist.")
        val existingLibrary = repository.findById(library.id)
        if (existingLibrary.isEmpty) throw RuntimeException("The library does not exist.")
        return repository.save(library)
    }

    @Throws(RuntimeException::class)
    fun delete(id: String) {
        val existingLibrary = repository.findById(id)
        if (existingLibrary.isEmpty) throw RuntimeException("The library does not exist.")
        repository.deleteById(id)
    }
}