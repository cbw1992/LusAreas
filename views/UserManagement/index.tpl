
<style>
#FormEntry{
    margin-top: 20px;
}
#FormEntry > div{
    margin: 10px 0px;
}
.column-name{
    line-height: 20px;
    text-align: right;
}
.column_input{
    padding:0px;
}

input[type='text'] {
    padding:0px 5px;
}
input[type='password'] {
    padding:0px 5px;
    border: solid 1px;
    border-color: #DDD;
    height: 23px;
}
</style>
<script>
model.BreadCrumbs.push(new BreadCrumb("Administration", "Administration", "#", "", ""));
model.BreadCrumbs.push(new BreadCrumb("UserManagement", "User Management", "#", "active", ""));
var UserManagement = {
    Processing:ko.observable(true),
    IsCreatingNewUser:ko.observable(false),
    IsEditingNewUser:ko.observable(false),
    SelectUser:ko.observable(""),
    User:{
        Username:ko.observable(""),
        Fullname:ko.observable(""),
        Email:ko.observable(""),
        ADUser:ko.observable(false),
        Enable:ko.observable(true),
        Password:ko.observable(""),
        ConfirmPassword:ko.observable(""),
        Roles:ko.observableArray([]),
    },
    RoleList:ko.observableArray([
        {Id:"Admin",Title:"Admin"},
        {Id:"Admin1",Title:"Admin2"}
    ]),
    DirectChangesList:ko.observableArray([]),
    isAnyDirectChanges:ko.observable(false),
    ListData:ko.observableArray([])
}
function UserChanges(Username,ADUserStatus,EnableStatus) {
    var self = this;
    self.UserName = Username;
    self.ADUser = ADUserStatus;
    self.Enable = EnableStatus;
    return self;
}
function checkingUser(InputType, Username, ADUserExistingValue, EnableExistingValue) {
    var EnableCurrentStatus = $(".check-enable" + Username).prop("checked");
    var ADUserCurrentStatus = $(".check-aduser" + Username).prop("checked");
    var arr = UserManagement.DirectChangesList();
    
    if (ADUserCurrentStatus == ADUserExistingValue && EnableCurrentStatus == EnableExistingValue) {
        for (var i in arr) {
            if (arr[i].UserName == Username) {
                UserManagement.DirectChangesList.remove(arr[i]);
                break;
            }
        }
    } else {
        for (var i in arr) {
            if (arr[i].UserName == Username) {
                UserManagement.DirectChangesList.remove(arr[i]);
                break;
            }
        }
        UserManagement.DirectChangesList.push(new UserChanges(Username, ADUserCurrentStatus, EnableCurrentStatus));
    }
    if (UserManagement.DirectChangesList().length == 0) {
        UserManagement.isAnyDirectChanges(false);
    } else {
        UserManagement.isAnyDirectChanges(true);
    }
}
</script>
<div class="panel panel-default" data-bind="with:UserManagement">
    <div class="panel-body">

        <div class="row">
            <div class="col-md-12 align-right"  data-bind="visible:(!IsCreatingNewUser()&&!IsEditingNewUser())&&!Processing()">
                <button class="btn btn-info btn-sm" data-bind="click:saveDirectChanges,visible:isAnyDirectChanges()">
                    <span class="glyphicon glyphicon-save"></span> Save Changes
                </button>
                <button type="button" class="btn btn-success btn-sm" data-bind="click:CreateNewUser">Create New User</button>
                <button type="button" class="btn btn-primary btn-sm" onclick="javascript:dataGrid();">Refresh</button>
            </div>
            <div class="col-md-12 align-left"  data-bind="visible:(IsCreatingNewUser()||IsEditingNewUser())&&!Processing()">
                <button type="button" class="btn btn-warning btn-sm" data-bind="click:Cancel">Back To List</button>
                <button type="button" class="btn btn-primary btn-sm" data-bind="click:Save">Save</button>
            </div>
        </div>
        <div class="row" data-bind="visible:(!IsCreatingNewUser()&&!IsEditingNewUser())&&!Processing()">
            <div class="col-md-12">
                &nbsp;
            </div>
            <div class="col-md-12">
                <div id="DataGrid"></div>
            </div>
        </div>
        <div class="row" data-bind="visible:(IsCreatingNewUser()||IsEditingNewUser())&&!Processing()">
            <div class="col-md-5">
                <div id="FormEntry" data-bind="with:User">
                    <div class="row">
                        <label class="col-md-3 column-name">User Name</label>
                        <div class="col-md-9 column_input">
                            <input type="text" style="width:100%;" required data-bind="value:Username,attr:{readonly:UserManagement.IsEditingNewUser()}">
                        </div>
                    </div>
                    <div class="row">
                        <label class="col-md-3 column-name">Full Name</label>
                        <div class="col-md-9 column_input">
                            <input type="text" style="width:100%;" name="Fullname" required data-bind="value:Fullname">
                            <span class="k-invalid-msg" data-for="Fullname"></span>
                        </div>
                    </div>
                    <div class="row">
                        <label class="col-md-3 column-name">Email</label>
                        <div class="col-md-9 column_input">
                            <input type="text" style="width:100%;" data-type="email"  name="Email" required data-bind="value:Email">
                            <span class="k-invalid-msg" data-for="Email"></span>
                        </div>
                    </div>
                    <div class="row">
                        <label class="col-md-3 column-name">AD User</label>
                        <div class="col-md-3 column_input">
                            <input type="checkbox" data-bind="checked:ADUser"/>
                        </div>
                        <label class="col-md-3 column-name">Enable</label>
                        <div class="col-md-3 column_input">
                            <input type="checkbox"  data-bind="checked:Enable"/>
                        </div>
                    </div>
                    <div class="row">
                        <label class="col-md-3 column-name">Password</label>
                        <div class="col-md-3 column_input">
                            <input type="password" style="width:100%;" required name="Password" data-bind="value:Password">
                            <span class="k-invalid-msg" data-for="Password"></span>
                        </div>
                        <label class="col-md-3 column-name">Confirm Password</label>
                        <div class="col-md-3 column_input">
                            <input type="password" style="width:100%;" required name="ConfirmPassword" data-bind="value:ConfirmPassword">
                            <span class="k-invalid-msg" data-for="ConfirmPassword"></span>
                        </div>
                    </div>
                    <div class="row">
                        <label class="col-md-3 column-name">Role</label>
                        <div class="col-md-9 column_input">
                            <select  required name="Roles" data-bind="kendoMultiSelect: { data:UserManagement.RoleList, value: Roles,dataTextField: 'Title',dataValueField: 'Id' }">
                            </select>
                            <span class="k-invalid-msg" data-for="Roles"></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    UserManagement.saveDirectChanges = function(){
        UserManagement.Processing(true);
        var url = "UserManagement/SaveDirectChanges";
        var parm = {
            ChangesList: UserManagement.DirectChangesList(),
            ChangesTotal:UserManagement.DirectChangesList().length
        };
        $.ajax({
            url: url,
            type: 'post',
            dataType: 'json',
            data : parm,
            success : function(respondse) {
                alert("Saved successfully");
                UserManagement.Initiate();
            },
            error:function(err){
                alert("Error while reaching data from the server. \nPlease contact administrator.");
            }
         });
    }
    UserManagement.Save = function(){
        var url = "UserManagement/AddNewUser"
        var data = UserManagement.User;
        if(data.Password()!== data.ConfirmPassword()){
            alert("ERROR Found - Please confirm your password, and then resubmit your application")
            return false;
        }
        var validator = $("#FormEntry").kendoValidator().data("kendoValidator");
        if(validator==undefined){
           validator = $("#FormEntry").kendoValidator().data("kendoValidator");
           alert("Error whle submitting your application\nplease check your form");
           return false;
        }
        if (validator.validate()) {
            UserManagement.Processing(true);
            var parm = {
                Username:data.Username(),
                Fullname:data.Fullname(),
                Email:data.Email(),
                ADUser:data.ADUser(),
                Enable:data.Enable(),
                Password:data.Password(),
                Roles:data.Roles(),
            };
            $.ajax({
                url: url,
                type: 'post',
                dataType: 'json',
                data : parm,
                success : function(respondse) {
                    alert("User has been saved");
                    UserManagement.IsCreatingNewUser(false);
                    UserManagement.IsEditingNewUser(false);
                    UserManagement.Initiate();
                },
                error:function(err){
                    alert("Error while reaching data from the server. \nPlease contact administrator.");
                }
             });
        }
    }
    UserManagement.Reset = function(){
        UserManagement.User.Username("");
        UserManagement.User.Fullname("");
        UserManagement.User.Email("");
        UserManagement.User.ADUser(false);
        UserManagement.User.Enable(true);
        UserManagement.User.Password("");
        UserManagement.User.ConfirmPassword("");
        UserManagement.User.Roles([]);
    }
    UserManagement.GetRoles = function(){
        var url = "UserManagement/GetRoles"
        $.ajax({
            url: url,
            type: 'post',
            dataType: 'json',
            data : null,
            success : function(respondse) {
                UserManagement.RoleList(respondse.data);
            },
            error:function(err){
                alert("Error while reaching data from the server. \nPlease contact administrator.");
            }
         });
    }
    UserManagement.Initiate = function(){
        UserManagement.GetRoles();
        UserManagement.GetData();
        UserManagement.DirectChangesList([]);
        UserManagement.isAnyDirectChanges(false);

    }
    UserManagement.CreateNewUser = function(){
        UserManagement.IsCreatingNewUser(true);
    }
    UserManagement.Cancel = function(){
        UserManagement.IsCreatingNewUser(false);   
        UserManagement.IsEditingNewUser(false);   
        UserManagement.Reset();
    }

    UserManagement.SelectUserFromGrid = function (user) {
        var arr = UserManagement.ListData();
        for(var i in arr){
            if(arr[i].UserName == user){
                UserManagement.SelectUser(arr[i]);
                break;
            }
        }
        var data = UserManagement.SelectUser();
        UserManagement.User.Username(data.UserName);
        UserManagement.User.Fullname(data.FullName);
        UserManagement.User.Email(data.Email);
        UserManagement.User.ADUser(data.ADUser);
        UserManagement.User.Enable(data.Enable);
        UserManagement.User.Password("");
        UserManagement.User.ConfirmPassword("");
        UserManagement.User.Roles(data.Roles);
        UserManagement.IsEditingNewUser(true);
    };
    UserManagement.GetData = function(){
        var Grid = $("#DataGrid");
        UserManagement.ListData([]);
        UserManagement.Processing(true);
        var url = "UserManagement/GetDataUserManagement";
        $.ajax({
            url: url,
            type: 'post',
            dataType: 'json',
            data : null,
            success : function(respondse) {
                UserManagement.ListData(respondse.data);
                for (var d in respondse.data) {
                    var Roles = respondse.data[d].Roles;
                    if (Roles.length > 0) {
                        var RolesString = "";
                        for (var r in Roles) {
                            if (r != Roles.length && r != 0) {
                                RolesString += ", " + Roles[r];
                            } else {
                                RolesString += Roles[r];
                            }
                            respondse.data[d].RolesCaption = RolesString;
                        }
                    } else {
                        respondse.data[d].RolesCaption = " - ";
                    }
                }
                var dataSource = new kendo.data.DataSource({
                    data: respondse.data,
                    pageSize: 10,
                    schema: { model: { id: "_id", fields: { ADUser: { type: "boolean" } } } }
                });
                Grid.data("kendoGrid").setDataSource(dataSource);




                UserManagement.Processing(false);
            },
            error:function(err){
                alert("Error while reaching data from the server. \nPlease contact administrator.");
            }
         });
    }
    function dataGrid(){
        $(document).ready(function(){
        UserManagement.Initiate();
        var Grid = $("#DataGrid");
        Grid.kendoGrid({
            pageable: true,
            filterable: {
                operators: {
                    string: {
                        contains: "Contains"
                    }
                }
            },
            columns: [
                {
                    field: "UserName", title: "User Name", width: 200,
                    filterable: {
                        cell: {
                            showOperators: false,
                            operator: "contains"
                        }
                    },
                    template: "<div style='width:100%;height:100%;cursor:pointer'><a onclick=\"UserManagement.SelectUserFromGrid('#:UserName#')\">#: UserName #</a></div>"
                },
                { field: "FullName", title: "Full Name",filterable: false},
                { field: "Email", title: "Email",filterable: false},
                { field: "RolesCaption", title: "Roles", filterable: false},
                { field: "ConfirmedAtUtc", title: "Created", width: 120, template: "#: kendo.format('{0:dd-MMM-yyyy hh:mm}',jsonDate(ConfirmedAtUtc)) #", filterable: false },
                { field: "ADUser", title: "AD User", width: 80, attributes: { style: "text-align:center" }, filterable: false, template: "<input type='checkbox' class='check-aduser#:UserName#' #: ADUser==true ? 'checked' : '' #  onclick=checkingUser('aduser','#:UserName#',#:ADUser#,#:Enable#)>" },
                { field: "Enable", title: "Enable", attributes: { style: "text-align:center" }, filterable: false, template: "<input type='checkbox' class='check-enable#:UserName#' #: Enable==true ? 'checked' : '' # onclick=checkingUser('enable','#:UserName#',#:ADUser#,#:Enable#)>", width: 80 }
            ],
            sortable:true
        });
    }); 
    }
   
</script>
<script>
dataGrid();
</script>