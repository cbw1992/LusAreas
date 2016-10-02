package controllers

import (
	. "GIS/webapp/helper"
	. "GIS/webapp/Areas/models"
	_ "github.com/astaxie/beego"
	"strconv"
	//"strings"
	"fmt"
	"gopkg.in/mgo.v2/bson"
	"time"
	//"encoding/json"
)

type UserManagementController struct {
	PrivateController
}

func (this *UserManagementController) Get() {
	this.Data["PageId"] = "UserManagement"
	this.Data["PageTitle"] = "User Management"
	this.Layout = "shared/layout.tpl"
	this.TplNames = "UserManagement/index.tpl"
}

func (this *UserManagementController) GetDataUserManagement() {
	//r := this.Ctx.Request
	List := []Users{}
	PopulateAsObject(&List, "SysUsers", nil, nil, 0, 0)
	//PrintJSON(w, true, List, "")
	this.Json(BuildResponse(true, List, "success"))
}

func (this *UserManagementController) GetRoles() {
	//r := this.Ctx.Request
	List := []Roles{}
	PopulateAsObject(&List, "SysRoles", nil, nil, 0, 0)
	// PopulateAsObject(&List, "SysRoles", nil, nil, 0, 0)
	//PrintJSON(w, true, List, "")
	this.Json(BuildResponse(true, List, "success"))
}
func (this *UserManagementController) AddNewUser() {
	r := this.Ctx.Request
	data := new(Users)
	data.UserName = r.FormValue("Username")
	data.FullName = r.FormValue("Fullname")
	data.Email = r.FormValue("Email")
	data.ADUser, _ = strconv.ParseBool(r.FormValue("ADUser"))
	data.Enable, _ = strconv.ParseBool(r.FormValue("Enable"))
	data.SecurityStamp = time.Now()
	data.ConfirmedAtUtc = time.Now()
	if r.Form["Roles[]"] != nil {
		params := []string{}
		for _, value := range r.Form["Roles[]"] {
			params = append(params, value)
		}
		data.Roles = params
	}
	data.HasChangePassword = false
	data.SecretToken = ""
	data.PasswordHash = GetMD5Hash(r.FormValue("Password"))
	Delete("SysUsers", bson.M{"UserName": data.UserName})
	Save("SysUsers", data)
	//PrintJSON(w, true, data, "")
	this.Json(BuildResponse(true, data, "success"))
}

func (this *UserManagementController) SaveDirectChangesUser() {
	var query []bson.M
	r := this.Ctx.Request
	ChangesTotal, _ := strconv.Atoi(r.FormValue("ChangesTotal"))
	for i := 0; i < ChangesTotal; i++ {
		UserName := r.Form["ChangesList["+strconv.Itoa(i)+"][UserName]"][0]
		TempADUser := r.Form["ChangesList["+strconv.Itoa(i)+"][ADUser]"][0]
		TempEnable := r.Form["ChangesList["+strconv.Itoa(i)+"][Enable]"][0]
		ADUser, _ := strconv.ParseBool(TempADUser)
		Enable, _ := strconv.ParseBool(TempEnable)
		query = append(query, bson.M{"UserName": UserName})
		newUpdate := bson.M{"$set": bson.M{"ADUser": ADUser, "Enable": Enable}}
		//Update Data
		fmt.Println(newUpdate)
		fmt.Println(query)
		Update("SysUsers", bson.M{"$and": query}, newUpdate)
	}
	//PrintJSON(w, true, "", "")
	this.Json(BuildResponse(true, "", "success"))
}
