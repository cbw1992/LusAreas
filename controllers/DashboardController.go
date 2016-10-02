package controllers

import (
	// . "GIS/webapp/Areas/helper"
	// . "GIS/webapp/Areas/models"
	// . "github.com/ahmetalpbalkan/go-linq"
	_ "github.com/astaxie/beego"
	// "gopkg.in/mgo.v2/bson"
	// "net/http"
	// "strconv"
	// "time"
)

type DashboardController struct {
	PrivateController
}

func (this *DashboardController) Get() {
	this.Data["PageId"] = "Dashboard"
	this.Data["PageTitle"] = "Home Page"
	this.Layout = "shared/layout.tpl"
	this.TplNames = "dashboard/index.tpl"
}
