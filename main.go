package main

import (
	"annanta/terminal-api/config"
	"annanta/terminal-api/controllers"
	"annanta/terminal-api/middleware"

	"github.com/gin-gonic/gin"
)

func main() {

	route := gin.Default()

	config.ConnectDatabase()
	// godotenv.Load()

	route.GET("/", func(ctx *gin.Context) {
		ctx.JSON(200, gin.H{
			"message": "hello",
		})
	})

	route.GET("/users", middleware.ValidationToken, controllers.GetAllUsers)
	route.POST("/api/register", middleware.ValidationToken, controllers.RegisterUser)

	route.POST("/api/login", controllers.LoginUser)

	route.GET("/api/terminal", middleware.ValidationToken, controllers.GetAllTerminal)
	route.POST("/api/terminal", middleware.ValidationToken, controllers.CreateTerminal)

	route.Run(":3000")
}
