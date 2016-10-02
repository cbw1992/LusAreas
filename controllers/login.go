package controllers

import (
	"GIS/webapp/helper"
	"GIS/webapp/Areas/models"
	_ "github.com/astaxie/beego"
	"GIS/library/ecbg"
)

type LoginController struct {
	ecbg.Controller
}

func (this *LoginController) Login() {
	this.Data["PageId"] = "Login"
	this.Data["PageTitle"] = "Login"
	this.TplNames = "login/login.tpl"
}

func (this *LoginController) Do() {
	r := this.Ctx.Request
	u, found := models.LoginDo(r.FormValue("UserName"), r.FormValue("Password"))

	if found {
		this.SetSession("username", u.UserName)
	}

	this.Json(helper.BuildResponse(found, u, ""))
}

func (this *LoginController) Logout() {
	this.SetSession("username", nil)
	this.Redirect("/login/login", 302)
}
