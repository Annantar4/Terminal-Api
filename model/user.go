package model

type User struct {
	Id       uint   `gorm:"primaryKey;column:id"`
	Name     string `gorm:"column:name"`
	Email    string `gorm:"unique;column:email"`
	Role     string `gorm:"column:role"`
	Password string `gorm:"column:password"`
}
