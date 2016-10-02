package routers

import (
	"GIS/webapp/Areas/controllers"

	"github.com/astaxie/beego"
)

func init() {
	beego.Router("/", &controllers.DashboardController{})
	beego.Router("/Dashboard", &controllers.DashboardController{})

	beego.Router("/Share", &controllers.ShareController{})
	beego.Router("/UserManagement", &controllers.UserManagementController{})

	beego.AutoRouter(&controllers.LoginController{})
	beego.AutoRouter(&controllers.DashboardController{})
	beego.AutoRouter(&controllers.ShareController{})
	beego.AutoRouter(&controllers.UserManagementController{})

}
