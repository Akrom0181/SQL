package storage

import (
	"Search/country"
	"database/sql"
	"fmt"
	"strings"

	"github.com/google/uuid"
)

type Inventory struct {
	db *sql.DB
}

func NewInventory(db *sql.DB) Inventory {
	return Inventory{
		db: db,
	}
}

func (i *Inventory) NameFilter(filter string) ([]country.Country, error) {
	filterUsers := []country.Country{}

	rows, err := i.db.Query("SELECT id, name, code FROM countries")
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	for rows.Next() {
		var country country.Country
		err := rows.Scan(&country.Id, &country.Name, &country.Code)
		if err != nil {
			return nil, err
		}
		if strings.Contains(strings.ToLower(country.Name), strings.ToLower(filter)) {
			filterUsers = append(filterUsers, country)
		}
	}

	if err := rows.Err(); err != nil {
		return nil, err
	}

	return filterUsers, nil
}

func (i *Inventory) Create(c country.Country) error {
	id := uuid.NewString()
	_, err := i.db.Exec(
		`INSERT INTO countries (id,name,code,created_at)
		VALUES($1,$2,$3,CURRENT_TIMESTAMP)`, id, c.Name, c.Code)
	if err != nil {
		fmt.Println("error while creating country err: ", err)
		return err
	}

	return nil
}

func (i *Inventory) Update(c country.Country, name string, code int, id string) error {
	_, err := i.db.Exec(
		`UPDATE countries 
		SET name=$1,
			code=$2,
			updated_at=NOW()
			WHERE id=$3`, name, code, id)
	if err != nil {
		fmt.Println("error while updating country err: ", err)
		return err
	}

	return nil
}

func (i *Inventory) Delete(c country.Country, id string) error {
	_, err := i.db.Exec(
		`DELETE FROM countries
			WHERE id=$1`, id)
	if err != nil {
		fmt.Println("error while deleting country err: ", err)
		return err
	}

	return nil
}

func (i *Inventory) GetAll() ([]country.Country, error) {
	countries := []country.Country{}
	rows, err := i.db.Query(`select 
	id,
	name,
	code,
	created_at from countries WHERE deleted_at is null`)
	if err != nil {
		fmt.Println("error while getting all countries err: ", err)
		return nil, err
	}

	for rows.Next() {
		c := country.Country{}
		if err = rows.Scan(&c.Id, &c.Name, &c.Code, &c.CreatedAt); err != nil {
			fmt.Println("error while scanning country err: ", err)
			return nil, err
		}
		countries = append(countries, c)
	}

	return countries, nil
}
