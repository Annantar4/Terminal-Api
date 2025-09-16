package model

type Terminal struct {
	ID       uint   `gorm:"primaryKey;column:id"`
	Name     string `gorm:"column:name"`
	Location string `gorm:"unique;column:location"`
}
