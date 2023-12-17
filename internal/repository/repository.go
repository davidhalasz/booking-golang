package repository

import "github.com/davidhalasz/go-bookings/internal/models"

type DatabaseRepo interface {
	InsertReservation(res models.Reservation) error
}
