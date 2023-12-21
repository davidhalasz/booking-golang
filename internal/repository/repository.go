package repository

import (
	"time"

	"github.com/davidhalasz/go-bookings/internal/models"
)

type DatabaseRepo interface {
	InsertReservation(res models.Reservation) (int, error)

	InsertRoomRestriction(r models.RoomRestriction) error

	SearchAvailabilityByRoomID(start, end time.Time, roomID int) (bool, error)

	SearchAvailabilityForAllRooms(start, end time.Time) ([]models.Room, error)
}