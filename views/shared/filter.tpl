
<style>
    .mrg{
        margin-bottom: 15px;
        margin-top: 15px;
    }
    .dte{
    	margin-left:-3px;
    }
    .to{
    	margin-left:-19px;
    }
</style>

<script type="text/javascript">

    model.Master = ko.observable({
        MasterVessel: ko.observableArray([]),
        MasterPort: ko.observableArray([]),
        MasterCommodity: ko.observableArray([]),
        MasterBranch: ko.observableArray([]),
        MasterCustomer: ko.observableArray([]),
        MasterSelFrom: ko.observable(""),
        MasterSelTo: ko.observable(""),
    });aria-multiselectable
// cara mengambil data dan menaruh didalam variable
	model.filter = ko.observable({
		GetAllData: function (e) {
			var dataUrl = '/Filter/GetData';
	        var x = model.Master();

	        var Filter = "";

	        ajaxPost(dataUrl, Filter, function (res) {
	            if (res.success) {

	                x.MasterCommodity(res.data.Commodity);

	                x.MasterCustomer(res.data.Customer)

	                 x.MasterBranch(res.data.Branch)	

	                x.MasterPort(res.data.Port);

	                x.MasterVessel(res.data.Vessel);
	            }
	        });
        },
        FVessel: ko.observableArray([]),
        MVessel: ko.observableArray([]),
        POL: ko.observableArray([]),
        POD: ko.observableArray([]),
        Commodity: ko.observableArray([]),
        Branch: ko.observableArray([]),
        Consigne: ko.observableArray([]),
        Shipper: ko.observableArray([]),
        SelFrom: ko.observable(""),
        SelTo: ko.observable(""),
        GParam: ko.observable(""),
        SaveToSession: function (e) {
            var x = model.filter();
            localStorage["FVessel"] = x.FVessel();
            localStorage["MVessel"] = x.MVessel();
            localStorage["POL"] = x.POL();
            localStorage["POD"] = x.POD();
            localStorage["Commodity"] = x.Commodity();
            localStorage["Branch"] = x.Branch();
            localStorage["Consigne"] = x.Consigne();
            localStorage["Shipper"] = x.Shipper();
            localStorage["SelFrom"] = x.SelFrom();
            localStorage["SelTo"] = x.SelTo();
        },
        GetFromSession:function (e){
			var x = model.filter();

			if(localStorage["FVessel"] != "" || localStorage["FVessel"] != undefined)
				if(localStorage["FVessel"].split(",")[0] != "")
					x.FVessel(localStorage["FVessel"].split(","));

			if(localStorage["MVessel"] != "" || localStorage["MVessel"] != undefined)
				if(localStorage["MVessel"].split(",")[0] != "")
					x.MVessel(localStorage["MVessel"].split(","));

			if(localStorage["POL"] != "" || localStorage["POL"] != undefined)
				if(localStorage["POL"].split(",")[0] != "")
					x.POL(localStorage["POL"].split(","));

			if(localStorage["POD"] != "" || localStorage["POD"] != undefined)
				if(localStorage["POD"].split(",")[0] != "")
					x.POD(localStorage["POD"].split(","));

			if(localStorage["Commodity"] != "" || localStorage["Commodity"] != undefined)
				if(localStorage["Commodity"].split(",")[0] != "")
					x.Commodity(localStorage["Commodity"].split(","));
            
            if(localStorage["Branch"] != "" || localStorage["Branch"] != undefined)
				if(localStorage["Branch"].split(",")[0] != "")
					x.Branch(localStorage["Branch"].split(","));

			if(localStorage["Consigne"] != "" || localStorage["Consigne"] != undefined)
				if(localStorage["Consigne"].split(",")[0] != "")
					x.Consigne(localStorage["Consigne"].split(","));

			if(localStorage["Shipper"] != "" || localStorage["Shipper"] != undefined)
				if(localStorage["Shipper"].split(",")[0] != "")
					x.Shipper(localStorage["Shipper"].split(","));

			if(localStorage["SelFrom"] != "" || localStorage["SelFrom"] != undefined){
			    x.SelFrom(moment(localStorage["SelFrom"]).toDate());
			}

			 if(localStorage["SelTo"] != "" || localStorage["SelTo"] != undefined){
			    x.SelTo(moment(localStorage["SelTo"]).toDate());
			}

			 model.filter().GetAllData();
        },
		Refresh: function (e) {
            //model.DB().GenerateDBGrid();
        },
        Reset: function (e) {
		var x = model.filter();
        x.FVessel([]);
        x.MVessel([]);
        x.POL([])
        x.POD([]);
        x.Commodity([]);
        x.Branch([]);
        x.Consigne([]);
        x.Shipper([]);
        x.SelFrom("");
        x.SelTo("");
		model.filter().SaveToSession();
		model.filter().Refresh();
        },
        GetFilter: function(e){
				var param = {
                GParam: model.filter().GParam(),
				FVessel: model.filter().FVessel(),
				MVessel: model.filter().MVessel(),
				POL : model.filter().POL(),
				POD : model.filter().POD(),
				Commodity : model.filter().Commodity(),
                Branch : model.filter().Branch(),
				Consigne : model.filter().Consigne(),
				Shipper : model.filter().Shipper(),
				SelFrom : moment(model.filter().SelFrom()).toISOString() === "Invalid date" ? "" : moment(model.filter().SelFrom()).toISOString(),
				SelTo :  moment(model.filter().SelTo()).toISOString() === "Invalid date" ? "" : moment(model.filter().SelTo()).toISOString(),
			};
			return param;
        }
	});

var sessF = setInterval(function(){ model.filter().GetFromSession(); }, 1000);
</script>

<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
	<div class="panel panel-default">
		<div class="panel-heading">
			<div class="panel-title align-right">
				<div class="btn-group" id="HideShowFilter">
					<a aria-controls="collapseOne" aria-expanded="false" href="#collapseOne" role="link" data-toggle="collapse"> Hide/Show Filter </a>
				</div>
			</div>
		</div>

		<div id="collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
			<div class="panel-body" data-bind="with:filter">
			    <div >
			        <div class="row mrg">

			            <div class="col-md-3">
			                <label class="col-md-4">Shipper:</label>
			                <div class="col-md-8">
			                    <input style="width:100%" type="text" data-bind="kendoMultiSelect: {value: Shipper, data: model.Master().MasterCustomer, dataValueField: 'Data', dataTextField: 'Data', filter: 'contains'}" />
			                </div>
			            </div>

			            <div class="col-md-3">
			                <label class="col-md-4">POL:</label>
			                <div class="col-md-8">
			                    <input style="width:100%" type="text" data-bind="kendoMultiSelect: {value: POL, data: model.Master().MasterPort, dataValueField: 'Data', dataTextField: 'Data', filter: 'contains'}" />
			                </div>
			            </div>
			            <div class="col-md-3">
			                <label class="col-md-4">POD:</label>
			                <div class="col-md-8">
			                    <input style="width:100%" type="text" data-bind="kendoMultiSelect: {value: POD, data: model.Master().MasterPort, dataValueField: 'Data', dataTextField: 'Data', filter: 'contains'}" />
			                </div>
			            </div>
                        
                        <div class="col-md-3">
			                <label class="col-md-4">Branch:</label>
			                <div class="col-md-8">
			                    <input style="width:100%" type="text" data-bind="kendoMultiSelect: {value: Branch, data: model.Master().MasterBranch, dataValueField: 'Data', dataTextField: 'Data', filter: 'contains'}" />
			                </div>
			            </div>

			        </div>

					<div class="row mrg">
						<div class="col-md-4">
			                <div>
                                <label class="col-md-3">Date:</label>
                                <div class="col-md-4 dte">
                                    <input style="width:100%" type="text" data-bind="kendoDatePicker: {value: SelFrom, format: 'dd MMM yyyy'}" />
                                </div>
                                <label class="col-md-1 to" > To:</label>
                                <div class="col-md-4">
                                   <input style="width:100%" type="text" data-bind="kendoDatePicker: {value: SelTo, format: 'dd MMM yyyy'}" />
                                </div>
                            </div>
			            </div>
						<div class="col-md-3">
			                <label class="col-md-4">Feeder Vessel:</label>
			                <div class="col-md-8">
			                    <input style="width:100%" type="text" data-bind="kendoMultiSelect: {value: FVessel, data: model.Master().MasterVessel, dataValueField: 'Data', dataTextField: 'Data', filter: 'contains'}" />
			                </div>
			            </div>

						<div class="col-md-3">
			                <label class="col-md-4">Consigne:</label>
			                <div class="col-md-8">
			                    <input style="width:100%" type="text" data-bind="kendoMultiSelect: {value: Consigne, data: model.Master().MasterCustomer, dataValueField: 'Data', dataTextField: 'Data', filter: 'contains'}" />
			                </div>
			            </div>

						<div class="col-md-2">
			                <label class="col-md-4">Mother Vessel:</label>
			                <div class="col-md-8">
			                    <input style="width:100%" type="text" data-bind="kendoMultiSelect: {value: MVessel, data: model.Master().MasterVessel, dataValueField: 'Data', dataTextField: 'Data', filter: 'contains'}" />
			                </div>
			            </div>

			          <!--   <div class="col-md-4">
			                <div>
                                <label class="col-md-3">Date:</label>
                                <div class="col-md-4">
                                    <input style="width:100%" type="text" data-bind="kendoDatePicker: {value: SelFrom, format: 'dd MMM yyyy'}" />
                                </div>
                                <label class="col-md-1"> To:</label>
                                <div class="col-md-4">
                                   <input style="width:100%" type="text" data-bind="kendoDatePicker: {value: SelTo, format: 'dd MMM yyyy'}" />
                                </div>
                            </div>
			            </div> -->
			        </div>
			    </div>

			    <div class="row mrg">
			        <div class="col-md-12 btn-group-sm">
			            <button type="button" class="btn btn-primary" data-bind="click:Refresh">Refresh</button>
			            <button type="button" class="btn btn-info" data-bind="click:Reset">Reset</button>
			        </div>
			    </div>

			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
model.filter().GetAllData();
$(document).ready(function(){
  setTimeout(function(){
    clearInterval(sessF);
  }, 2000)
  $(window).bind('beforeunload', function(e){
      model.filter().SaveToSession();
  });
});
</script>
<script type="text/javascript">
// $(document).ready(function() {
//     function startChange() {
//         var startDate = start.value(),
//         endDate = end.value();

//         if (startDate) {
//             startDate = new Date(startDate);
//             startDate.setDate(startDate.getDate());
//             end.min(startDate);
//         } else if (endDate) {
//             start.max(new Date(endDate));
//         } else {
//             endDate = new Date();
//             start.max(endDate);
//             end.min(endDate);
//         }
//     }

//     function endChange() {
//         var endDate = end.value(),
//         startDate = start.value();

//         if (endDate) {
//             endDate = new Date(endDate);
//             endDate.setDate(endDate.getDate());
//             start.max(endDate);
//         } else if (startDate) {
//             end.min(new Date(startDate));
//         } else {
//             endDate = new Date();
//             start.max(endDate);
//             end.min(endDate);
//         }
//     }

//     var start = $("#startDate").kendoDatePicker({
//         change: startChange
//     }).data("kendoDatePicker");

//     var end = $("#endTo").kendoDatePicker({
//         change: endChange
//     }).data("kendoDatePicker");

//     start.max(end.value());
//     end.min(start.value());
// });
</script>