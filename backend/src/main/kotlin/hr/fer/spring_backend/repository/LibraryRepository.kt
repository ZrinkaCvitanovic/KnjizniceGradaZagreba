package hr.fer.spring_backend.repository

import hr.fer.spring_backend.model.Library
import org.springframework.data.mongodb.repository.MongoRepository

interface LibraryRepository : MongoRepository<Library, String> {
    fun findByName(name: String): List<Library>
    fun findByAddress(address: String): List<Library>
    fun findByManager(manager: String): List<Library>
}