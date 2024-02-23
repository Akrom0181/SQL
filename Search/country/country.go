package country

import "github.com/google/uuid"

type Country struct {
	Id        uuid.UUID
	Name      string
	Code      int
	CreatedAt string
	UpdatedAt string
}
