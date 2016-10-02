
<style type="text/css">
	.pad{
		padding-bottom: 5px;
	}
</style>


<script type="text/javascript">
	model.invInfo = ko.observable({
		Shipper : ko.observable(""),
		Pol : ko.observable(""),
		Pod : ko.observable(""),
		Etd : ko.observable(""),
		Eta : ko.observable("")
    });

</script>

<!-- HTML -->

<div data-bind="with:invInfo">
	<div class="col-md-12">
		<div class="col-md-12">
				<h5 data-bind="text:Shipper"></h5>
		</div>
	</div>

	<div class="col-md-12 pad">
		<div class="row">
			<div class="col-md-6">
				<label class="col-md-3">POL</label>
				<label class="col-md-9" data-bind="text:Pol"></label>
			</div>
			<div class="col-md-6">
				<label class="col-md-3">POD</label>
				<label class="col-md-9" data-bind="text:Pod"></label>
			</div>
			<div class="col-md-6">
				<label class="col-md-3">ETD</label>
				<label class="col-md-9" data-bind="text:Etd"></label>
			</div>
			<div class="col-md-6">
				<label class="col-md-3">ETA</label>
				<label class="col-md-9" data-bind="text:Eta"></label>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	function GetInvInfo(ID){
		var dataUrl = '/Share/GetJSData';

		$.ajax({
	        url: dataUrl,
	        type: 'post',
	        dataType: 'json',
	        data : {ID:ID},
	        success : function(res) {
	        	var data = res.data.Data[0];
	        	console.log(data);

				model.invInfo().Shipper(data.Shipper.CustomerName);
				model.invInfo().Pol(" : " + data.POL.PortName);
				model.invInfo().Pod(" : " + data.POD.PortName);
				model.invInfo().Etd(" : " + kendo.toString(kendo.parseDate(data.ETD, 'yyyy-MM-dd'), 'dd-MMM-yyyy'));
				model.invInfo().Eta(" : " + kendo.toString(kendo.parseDate(data.ETA, 'yyyy-MM-dd'), 'dd-MMM-yyyy'));

	        }
	    })
	}
</script>




