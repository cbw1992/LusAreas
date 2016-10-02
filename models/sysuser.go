package models

import (
	"GIS/webapp/helper"

	"github.com/astaxie/beego"
	"GIS/library/database/base"
	"GIS/library/database/mongodb"
	. "GIS/library/oldorm"
	tool "GIS/library/toolkit"
)

type UserModel struct {
	ModelBase `bson:"-"`
	UserName  string `bson:"UserName"`
	FullName  string `bson:"FullName"`
	Email     string `bson:"Email"`
	Enable    int    `bson:"Enable"`
}

func prepareContext() (*DataContext, error) {
	dbLocation := beego.AppConfig.String("db_server")
	dbName := beego.AppConfig.String("db_name")

	conn := mongodb.NewConnection(dbLocation, "", "", dbName)
	if eConnect := conn.Connect(); eConnect != nil {
		return nil, eConnect
	}
	ctx := New(conn)
	return ctx, nil
}

func (u *UserModel) TableName() string {
	return "SysUsers"
}

func LoginDo(username string, password string) (*UserModel, bool) {
	ctx, _ := prepareContext()
	defer ctx.Close()

	u := new(UserModel)
	hashPassword := helper.GetMD5Hash(password)
	c := ctx.Find(u, tool.M{"where": base.And(base.Eq("UserName", username), base.Eq("PasswordHash", hashPassword))})

	found, _ := c.FetchClose(u)
	return u, found
}
