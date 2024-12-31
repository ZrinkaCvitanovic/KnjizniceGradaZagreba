package hr.fer.spring_backend.model

import org.springframework.data.annotation.Id
import org.springframework.data.mongodb.core.mapping.Document
import org.springframework.data.mongodb.core.mapping.Field

@Document(collection = "knjiznice")
data class Library(
    @Id
    val id: String? = null,

    @Field("Naziv")
    val name: String,

    @Field("Adresa")
    val address: String,

    @Field("Kontakt_telefon")
    val phone: String,

    @Field("Kontakt_mail")
    val email: String,

    @Field("Voditelj")
    val manager: String,

    @Field("radno_vrijeme")
    val workingHours: List<WorkingTime>,

    @Field("Nudi_wifi")
    val hasWifi: String,

    @Field("Nudi_tople_napitke")
    val hasWarmDrinks: String,

    @Field("Nudi_racunalo")
    val hasComputers: String,
)

data class WorkingTime(
    @Field("dani")
    val days: String,

    @Field("sati")
    val hours: String
)