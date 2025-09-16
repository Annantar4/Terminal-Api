package controllers

import (
	"annanta/terminal-api/config"
	"annanta/terminal-api/model"
	"net/http"

	"github.com/gin-gonic/gin"
)

func GetAllTerminal(c *gin.Context) {
	var terminal []model.Terminal

	config.DB.Find(&terminal)
	c.JSON(200, gin.H{
		"message": "success",
		"data":    terminal,
	})
}

type TerminalRequest struct {
	Name     string `json:"name" binding:"required"`
	Location string `json:"location" binding:"required"`
}

func CreateTerminal(c *gin.Context) {
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
	var terminal model.Terminal
	var input TerminalRequest

	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})
		return
	}

	terminal.Name = input.Name
	terminal.Location = input.Location
	config.DB.Create(&terminal)

	c.JSON(201, gin.H{
		"message": "success",
		"data":    terminal,
	})

}
