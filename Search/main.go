package main

import (
	"Search/country"
	"Search/storage"
	"database/sql"
	"fmt"

	_ "github.com/lib/pq"
)

func main() {
	db, err := connectDB()
	if err != nil {
		fmt.Println("Error connecting to the database:", err)
		return
	}
	defer db.Close()

	fmt.Println("Select:")
	fmt.Println("1-Create new country")
	fmt.Println("2-Update country")
	fmt.Println("3-Delete country")
	fmt.Println("4 getAll || getByName")

	var userType int
	_, err = fmt.Scan(&userType)
	if err != nil {
		fmt.Println("Error reading user input:", err)
		return
	}

	inv := storage.NewInventory(db)

	switch userType {
	case 1:
		var name string
		var code int
		fmt.Println("Enter the country name:")
		_, err := fmt.Scan(&name)
		if err != nil {
			fmt.Println("Error reading country name:", err)
			return
		}
		fmt.Println("Enter the country code:")
		_, err = fmt.Scan(&code)
		if err != nil {
			fmt.Println("Error reading country code:", err)
			return
		}
		newCountry := country.Country{
			Name: name,
			Code: code,
		}
		err = inv.Create(newCountry)
		if err != nil {
			fmt.Println("Error creating country:", err)
			return
		}
		fmt.Println("Country created successfully")

	case 2:
		countries, err := inv.GetAll()
		if err != nil {
			fmt.Println("Error fetching countries:", err)
			return
		}
		fmt.Println("Countries: ", countries)

		var id, name string
		var code int
		fmt.Println("Enter the ID of the country to update:")
		fmt.Scan(&id)

		fmt.Println("Enter the new name of the country:")
		fmt.Scan(&name)

		fmt.Println("Enter the new code of the country:")
		_, err = fmt.Scan(&code)
		if err != nil {
			fmt.Println("Error reading new country code:", err)
			return
		}
		err = inv.Update(country.Country{}, name, code, id)
		if err != nil {
			fmt.Println("Error updating country:", err)
			return
		}
		fmt.Println("Country updated successfully")

	case 3:
		countries, err := inv.GetAll()
		if err != nil {
			fmt.Println("Error fetching countries:", err)
			return
		}
		fmt.Println("Countries: ", countries)

		var id string
		fmt.Println("Enter the ID of the country to delete:")
		_, err = fmt.Scan(&id)
		if err != nil {
			fmt.Println("Error reading country ID:", err)
			return
		}
		err = inv.Delete(country.Country{}, id)
		if err != nil {
			fmt.Println("Error deleting country:", err)
			return
		}
		fmt.Println("Country deleted successfully")

	case 4:
		fmt.Println("1-GetAll, 2-Search")
		var input int
		if _, err := fmt.Scan(&input); err != nil {
			fmt.Println("Error reading user input:", err)
			return
		}
		switch input {
		case 1:
			countries, err := inv.GetAll()
			if err != nil {
				fmt.Println("Error fetching countries:", err)
				return
			}
			fmt.Println("Countries: ", countries)
		case 2:
			fmt.Println("Enter filter string:")
			var filter string
			if _, err := fmt.Scan(&filter); err != nil {
				fmt.Println("Error reading filter string:", err)
				return
			}
			filteredCountries, err := inv.NameFilter(filter)
			if err != nil {
				fmt.Println("Error filtering countries:", err)
				return
			}
			fmt.Println("Filtered Countries: ", filteredCountries)
		}
	}
}

func connectDB() (*sql.DB, error) {
	db, err := sql.Open("postgres", "host=localhost port=5432 user=shahzod password=1 database=shahzod sslmode=disable")
	if err != nil {
		return nil, err
	}
	if err := db.Ping(); err != nil {
		db.Close()
		return nil, err
	}
	return db, nil
}
