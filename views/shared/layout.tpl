<!DOCTYPE html>
<html>
<head>
    <title>GIS SmartView</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" href="/static/favicons.ico" type="image/x-icon" />
    <link rel="icon" href="/static/favicons.ico" type="image/x-icon" />

    <script src="/static/js/jquery-2.1.0.min.js"></script>
    <script src="/static/js/jquery-ui.min.js"></script>
    <script src="/static/js/knockout-3.1.0.js"></script>
    <script src="/static/js/knockout.mapping-latest.js"></script>
    <script src="/static/js/knockout.validation.js"></script>
    <script src="/static/js/jszip.min.js"></script>
    <script src="/static/kendoui/js/kendo.all.min.js"></script>
    <script src="/static/js/knockout-kendo.min.js"></script>
    <script src="/static/js/bootstrap.min.js"></script>
    <script src="/static/js/underscore.min.js"></script>
    <script src="/static/js/moment.min.js"></script>
    <script src="/static/js/color.js"></script>
    <script src="/static/js/tools.js"></script>
    <script src="/static/js/linq.js"></script>
    <script src="/static/js/custom.js"></script>

    <script src="/static/js/jquery-printme.js"></script>
 
    <link href="/static/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <link href="/static/css/example.css" type="text/css" rel="stylesheet" />
    <link href="/static/css/main.css" type="text/css" rel="stylesheet" />

    <script src="/static/js/faker.min.js"></script>
    <script src="/static/js/jspdf.min.js"></script>
    <script src="/static/js/jspdf.plugin.autotable.js"></script>
    <script src="/static/js/tableExport.js"></script>
    <script src="/static/js/jquery.base64.js"></script>
    <script src="/static/js/sprintf.js"></script>
    <script src="/static/js/base64.js"></script>

    <link href="/static/css/bootstrap.css" type="text/css" rel="stylesheet" />
    <link href="/static/css/bootstrap-theme.css" type="text/css" rel="stylesheet" />

    <link rel="stylesheet" href="/static/kendoui/styles/kendo.material.min.css" />
    <link rel="stylesheet" href="/static/kendoui/styles/kendo.common-bootstrap.min.css" />
    <link rel="stylesheet" href="/static/kendoui/styles/kendo.dataviz.min.css" />
    <link rel="stylesheet" href="/static/kendoui/styles/kendo.dataviz.bootstrap.min.css" />

    <script src="/static/js/underscore.min.js"></script>
    <script src="/static/js/linq.js"></script>
    <script src="/static/js/ecis_config.js"></script>
    <script src="/static/js/main.js"></script>
    <script src="/static/js/ecis_start.js"></script>
    <script src="/static/js/jquery.fullscreen.min.js"></script>

    <link rel="stylesheet" href="/static/css/font-awesome.css" />
    <link rel="stylesheet" href="/static/css/Site.css" />
    <link rel="stylesheet" href="/static/css/custom.css" />
    <script>
        var Now = new Date();
        function getQuarter(d) {
          d = d || new Date(); // If no date supplied, use today
          var q = [1,2,3,4];
          return q[Math.floor(d.getMonth() / 3)];
        }
        function getFinanceQuarter(d) {
          d = d || new Date(); // If no date supplied, use today
          var q = [4,1,2,3];
          return q[Math.floor(d.getMonth() / 3)];
        }
        var model = {
            Processing: ko.observable(true)
        }
    </script>

    <style>
        .k-multiselect{
            background:none;
        }
        html, body {
            max-width: 100%;
            overflow-x: hidden;
        }
        .menu-header {
        height: 30px;
        background-color: #333;
        }

        .nav-bar-header li {
        float: left;
        }

        .nav-bar-header li a {
        font-size: 12px;
        margin: 0px;
        padding: 5px;
        background-color: #000;
        }

        .nav-bar-header li.selected a {
        background-color: #D33;
        }

        .nav-bar-header li a:hover {
        font-size: 12px;
        margin: 0px;
        padding: 5px;
        background-color: #D33;
        }

        .form-group label {
        text-align: right;
        padding-right: 10px;
        }

        .form-group input {
        border: solid 1px #ccc;
        padding: 2px;
        }

        .form-group input[type='number'] {
        text-align: right;
        }
    </style>


    <script id="navbarTemplate" type="text/html">
        <!-- ko if: Submenus().length==0 -->
        <li data-bind="css:{selected:$root.PageId()==_id()}">
            <a data-bind="text: Title, attr:{href:Url}"></a>
        </li>
        <!-- /ko -->
        <!-- ko if: Submenus().length>0 -->
        <li data-bind="css:{selected:$root.PageId()==_id()}" class="dropdown">
            <a data-bind="text: Title" style="cursor:pointer" class="dropdown-toggle" data-toggle="dropdown"></a>
            <ul class="dropdown-menu" role="menu" data-bind="template:{name:'navbarSubTemplate', foreach:Submenus}"></ul>
        </li>
        <!-- /ko -->
    </script>

    <script id="navbarSubTemplate" type="text/html">
        <!-- ko if: Submenus().length==0 -->
        <li data-bind="css:{selected:$root.PageId()==_id()}">
            <a data-bind="text: Title, attr:{href:Url}"></a>
        </li>
        <!-- /ko -->
        <!-- ko if: Submenus().length>0 -->
        <li data-bind="css:{selected:$root.PageId()==_id()}" class="dropdown-submenu">
            <a data-bind="text: Title" style="cursor:pointer" class="dropdown-toggle" data-toggle="dropdown"></a>
            <ul class="dropdown-menu" role="menu" data-bind="template:{name:'navbarSubTemplate', foreach:Submenus}"></ul>
        </li>
        <!-- /ko -->
    </script>

    <script id="userTemplate" type="text/html">
        <!-- ko if: Submenus().length==0 -->
        <li data-bind="css:{selected:$root.PageId()==_id()}">
            <a data-bind="text: Title, attr:{href:Url}"></a>
        </li>
        <!-- /ko -->
        <!-- ko if: Submenus().length>0 -->
        <li data-bind="css:{selected:$root.PageId()==_id()}" class="dropdown-submenu-left">
            <a data-bind="text: Title" style="cursor:pointer" class="dropdown-toggle" data-toggle="dropdown"></a>
            <ul class="dropdown-menu" role="menu" data-bind="template:{name:'userSubTemplate', foreach:Submenus}"></ul>
        </li>
        <!-- /ko -->
    </script>

    <script id="userSubTemplate" type="text/html">
        <!-- ko if: Submenus().length==0 -->
        <li data-bind="css:{selected:$root.PageId()==_id()}">
            <a data-bind="text: Title, attr:{href:Url}"></a>
        </li>
        <!-- /ko -->
        <!-- ko if: Submenus().length>0 -->
        <li data-bind="css:{selected:$root.PageId()==_id()}" class="dropdown-submenu-left">
            <a data-bind="text: Title" style="cursor:pointer" class="dropdown-toggle" data-toggle="dropdown"></a>
            <ul class="dropdown-menu" role="menu" data-bind="template:{name:'userSubTemplate', foreach:Submenus}"></ul>
        </li>
        <!-- /ko -->
    </script>

    <script id="breadcrumbTemplate" type="text/html">
        <li data-bind="attr:{class:CssClass}"><a data-bind="text: Title, attr:{href:Url, class:CssClass, onclick: (Action!=undefined?Action:'')}"></a></li>
    </script>

</head>
<body>

    <div data-bind="visible:Processing()">
        {{template "shared/processing-overlay.tpl"}}
    </div>

    <!-- wrapper starts here -->
    <div class="container-fluid" style="display:none" data-bind="visible:!Processing()">
        <!-- header starts here -->
        <header id="page-header">
            <div class="page-header-overlay">
                <section id="logo">
                    <a href="res/" id="logo-link"><span>MCL</span></a>
                </section>
            </div>



            <section id="user-nav">
                <div class="user-nav-wrapper">
                    <a href="#" class="user-nav-info" data-toggle="dropdown">Welcome <span>ADMIN<!-- {{.UserID}} --></span></a>
                    <!-- ko if:UserMenus().length==0 -->
                    <ul class="dropdown-menu" role="menu">
                        <!--li><a href="res/webmenu/menu">Menu Configuration</a></li-->
                        <li><a onClick="Logout()" class="logout-link">Logout</a></li><!--href="" onClick="localStorage.clear();"-->
                    </ul>
                    <!-- /ko -->
                    <!-- ko if:UserMenus().length>0 -->
                    <ul class="dropdown-menu" role="menu" data-bind="template:{name:'userTemplate', foreach:UserMenus}"></ul>
                    <!-- /ko -->
                </div>
            </section>

        </header>

        <script>
            function Logout(){
                localStorage.clear();
                window.location.href = "/login/logout";
            }

            function MenuItem(id, url, title, submenus, baseURL) {
                var obj = {
                    _id: ko.observable(id),
                    Title: ko.observable(title == undefined ? id : title),
                    Url: ko.observable(url.replace("~/",baseURL)),
                    Submenus: ko.observableArray([])
                };

                var arr = submenus;
                for(var i in arr){
                    obj.Submenus.push(
                        new MenuItem(
                            arr[i]._id,
                            arr[i].Url,
                            arr[i].Title,
                            arr[i].Submenus,
                            baseURL
                        )
                    );
                }
                return obj;
            };

            function BreadCrumb(id, title, url, cssClass, action) {
                var obj = {
                    _id: ko.observable(id),
                    Title: ko.observable(title == undefined ? id : title),
                    Url: url,
                    Action: action,
                    CssClass: cssClass
                };

                return obj;
            }

            model.PageId = ko.observable("{{.PageId}}");
            model.MainMenus = ko.observableArray([]);
            // Add new menu
            model.MenuList  = [
                {_id:"Dashboard",Url:"/Dashboard",Title:"Dashboard",Submenus:[]},
                {_id:"MenuB",Url:"#",Title:"Menu B",Submenus:[
                    {_id:"SubMenuBI",Url:'/JobSheet/Create',Title:"Sub Menu BI",Submenus:[]},
                    {_id:"SubMenuBII",Url:'/JobSheet/List',Title:"Sub Menu BII",Submenus:[]},
                    {_id:"SubMenuBIII",Url:'/JobSheet/Approval',Title:"Sub Menu BIII",Submenus:[]}
                ]},
                {_id:"DataBrowser",Url:"/DataBrowser",Title:"Data Browser",Submenus:[]},
                // {_id:"Invoice",Url:"/Invoice",Title:"Invoice",Submenus:[]},
                // {_id:"MasterData",Url:"#",Title:"MasterData",Submenus:[
                //     {_id:"Customer",Url:"/Customer",Title:"Customer",Submenus:[]},
                //     {_id:"Vessel",Url:"/Vessel",Title:"Vessel",Submenus:[]},
                //     {_id:"Port",Url:"/Port",Title:"Port",Submenus:[]},
                //     //{_id:"ShipManifestContainer",Url:"/ShipManifestContainer",Title:"Ship Manifest Container",Submenus:[]},
                //     {_id:"CostItem",Url:"/CostItem",Title:"Cost Item",Submenus:[]},
                //     {_id:"Branch",Url:"/Branch",Title:"Branch",Submenus:[]},
                //     {_id:"Sales",Url:"/Sales",Title:"Sales",Submenus:[]}
                    
                // ]},
                // {_id:"Report",Url:"#",Title:"Report",Submenus:[
                //     {_id:"RJobSheetList",Url:"/RJobSheetList",Title:"Job Sheet List",Submenus:[]},
                //     {_id:"RRevenueCost",Url:"/RRevenueCost",Title:"Revenue & Cost",Submenus:[]},
                //     {_id:"ROutStandingInvoice",Url:"/ROutStandingInvoice",Title:"OutStanding Invoice",Submenus:[]},
                //     {_id:"ROutStandingJobSheet",Url:"/ROutStandingJobSheet",Title:"OutStanding JobSheet",Submenus:[]},
                //     {_id:"RTrending",Url:"/RTrending",Title:"Container Trending",Submenus:[]},
                //     {_id:"InvoiceTracking",Url:"/RInvoiceTracking",Title:"Invoice Tracking",Submenus:[]},
                // ]},
                // {_id:"CustomerPerformance",Url:"#",Title:"Customer Performance",Submenus:[
                //  {_id:"CustomerTrending",Url:"/CustomerTrending",Title:"Customer Trending",Submenus:[]},
                //  {_id:"RSpendTrending",Url:"/RSpendTrending",Title:"Customer Spending Trends",Submenus:[]},
                //  {_id:"RCustomerDestination",Url:"/RCustomerDestination",Title:"Customer Destination Details",Submenus:[]},
                //  {_id:"RCustomerProfitLoss",Url:"/RCustomerProfitLoss",Title:"Customer Profit & Loss",Submenus:[]},
                // ]},
                // {_id:"DataBrowser",Url:"/DataBrowser",Title:"Data Browser",Submenus:[]},
                // {_id:"UserManagement",Url:"/UserManagement",Title:"User Management",Submenus:[]},
            ]
            model.UserMenus = ko.observableArray([]);

            model.BreadCrumbs = ko.observableArray([]);

            model.getMainMenu = function(){
                var baseURL = "res";
                var arr = model.MenuList;
                for(var i in arr){
                    model.MainMenus.push(
                        new MenuItem(
                            arr[i]._id,
                            arr[i].Url,
                            arr[i].Title,
                            arr[i].Submenus,
                            baseURL
                        )
                    );
                }
            }

            model.getUserMenu = function(){
                var url = "res/webmenu/menu/getmenu";
                var baseURL = "res";
                model.UserMenus([]);
                ajaxPost(url,{collection_name:"User_Menu"},function(respondse){
                    var arr = respondse.Data;
                    for(var i in arr){
                        model.UserMenus.push(
                            new MenuItem(
                                arr[i]._id,
                                arr[i].Url,
                                arr[i].Title,
                                arr[i].Submenus,
                                baseURL
                            )
                        );
                    }
                });
            }
        </script>

        <nav class="navbar">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <i class="fa fa-bars fa-2x"></i>
                    </button>
                </div>
                <div id="navbar" class="collapse navbar-collapse">
                    <ul class="nav navbar-nav" data-bind="template:{name:'navbarTemplate', foreach:MainMenus}"></ul>
                </div>
            </div>
        </nav>


        <script>
            model.BreadCrumbs.push(new BreadCrumb("youare", "You are here : ", "#", "youare"));
        </script>
        <section class="breadcrumb-section">
            <ol class="breadcrumb" data-bind="template:{name:'breadcrumbTemplate', foreach:BreadCrumbs}"></ol>
        </section>
    </div>
    <!-- header ends here -->
    <!-- section starts here -->
    <div class="container-fluid content-main" data-bind="visible:!Processing()">

        <section class="content">
            <div class="content-header">
                <h2 class="content-title"><span>{{.PageTitle}}</span></h2>
            </div>
            <!-- Main panel starts here -->
            {{.LayoutContent}}
        </section>

    </div>
    <!-- section ends here -->
    <!-- wrapper ends here -->
    <script>
        $(function(){
            $('#logo-link').on('click', function() {
                $('body').fullscreen({ overflow: 'auto' });
                return false;
            });
        });

        function setPageTitle(s) {
            $("#pageTitle").text(s);
        }

        ko.applyBindings(model);

        $(document).ready(function () {
            model.Processing(false);
            model.getMainMenu();
            if (typeof PageUpdate == "function") {
                PageUpdate();
            }
        });
    </script>

</body>
</html>