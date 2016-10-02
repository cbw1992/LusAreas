package models

import (
	"time"
)

type Roles struct {
	Id    string `bson:"_id"`
	Title string `bson:"Title"`
}
type Users struct {
	UserName          string    `bson:"UserName"`
	FullName          string    `bson:"FullName"`
	Enable            bool      `bson:"Enable"`
	ADUser            bool      `bson:"ADUser"`
	SecurityStamp     time.Time `bson:"SecurityStamp"`
	ConfirmedAtUtc    time.Time `bson:"ConfirmedAtUtc"`
	Email             string    `bson:"Email"`
	Roles             []string  `bson:"Roles"`
	PasswordHash      string    `bson:"PasswordHash"`
	Logins            []string  `bson:"Logins"`
	Claims            []string  `bson:"Claims"`
	HasChangePassword bool      `bson:"HasChangePassword"`
	SecretToken       string    `bson:"SecretToken"`
}
