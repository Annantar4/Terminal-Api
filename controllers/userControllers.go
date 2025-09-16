package controllers

import (
	"annanta/terminal-api/config"
	"annanta/terminal-api/model"
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/golang-jwt/jwt/v5"
	"github.com/joho/godotenv"
	"golang.org/x/crypto/bcrypt"
)

func GetAllUsers(c *gin.Context) {
	admin, exist := c.Get("is_admin")
	if !exist {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "admin not found"})
		return
	}
	if admin == false {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Only admin"})
		c.Abort()
		return
	}
	var user []model.User

	config.DB.Find(&user)
	c.JSON(200, gin.H{
		"message": "success",
		"data":    user,
	})
}

type UserRegister struct {
	Name     string `json:"name" binding:"required"`
	Email    string `json:"email" binding:"required"`
	Password string `json:"password" binding:"required"`
	Role     string `json:"role" binding:"required"`
}

func RegisterUser(c *gin.Context) {
	var user model.User
	var input UserRegister
	admin, exist := c.Get("is_admin")
	if !exist {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "admin not found"})
		return
	}
	if admin == false {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Only admin"})
		c.Abort()
		return
	}
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})
		return
	}
	hash, err := bcrypt.GenerateFromPassword([]byte(input.Password), bcrypt.DefaultCost)

	if err != nil {
		panic(err)
	}

	user.Name = input.Name
	user.Email = input.Email
	user.Password = string(hash)
	user.Role = input.Role

	config.DB.Create(&user)

	c.JSON(201, gin.H{
		"message": "success",
		"data":    user,
	})

}

type LoginRequest struct {
	Email    string `json:"email" binding:"required"`
	Password string `json:"password" binding:"required"`
}

func LoginUser(c *gin.Context) {
	var input LoginRequest

	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})
		return
	}

	var user model.User
	result := config.DB.Where("email= ?", input.Email).First(&user)

	if result.Error != nil {
		c.JSON(http.StatusUnauthorized, gin.H{
			"message": "wrong email or password",
		})
		return
	}

	if err := bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(input.Password)); err != nil {
		c.JSON(http.StatusUnauthorized, gin.H{
			"message": "wrong email or passw",
		})
		return
	}
	godotenv.Load()
	secret := []byte("SECRET")
	var admin bool
	if user.Role == "admin" {
		admin = true
	} else {
		admin = false
	}
	claims := jwt.MapClaims{
		"user_id": user.Id,
		"admin":   admin,
		"exp":     time.Now().Add(time.Hour * 24).Unix(),
	}
	sign := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)

	token, err := sign.SignedString(secret)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"message": err.Error(),
		})
		return
	}
	c.JSON(200, gin.H{
		"token": token,
	})

}
