package controllers

import (
	"encoding/json"
	"github.com/astaxie/beego"
	"GIS/library/database/base"
	"GIS/library/database/mongodb"
	"GIS/library/ecbg"
	"GIS/library/oldorm"
)

type PrivateController struct {
	ecbg.Controller
	Db  base.IConnection
	Orm *orm.DataContext
}

func (this *PrivateController) Prepare() {
	if this.GetSession("username", nil) == nil {
		// this.Redirect("/login/login", 302)
	}

	host := beego.AppConfig.String("db_server")
	username := beego.AppConfig.String("db_username")
	password := beego.AppConfig.String("db_password")
	database := beego.AppConfig.String("db_name")
	this.Db = mongodb.NewConnection(host, username, password, database)
	if e := this.Db.Connect(); e != nil {
		beego.Error("Unable to connect to database")
	}
	this.Orm = orm.New(this.Db)
}

func (this *PrivateController) Finish() {
	this.Orm.Close()
	this.Db.Close()
}

func (p *PrivateController) GetPayload(result interface{}) error {
	body := p.Ctx.Request.Body
	decoder := json.NewDecoder(body)
	return decoder.Decode(result)
}
