sap.ui.define([
    "sap/m/MessageToast"
], function(MessageToast) {
    'use strict';

    return {
        SetAlumni: function(oBindingContext,aSelectedContexts) {       
             aSelectedContexts.forEach(element => {
                MessageToast.show(element.sPath);
                var aData = jQuery.ajax({
                    type: "PATCH",
                    contentType: "application/json",
                    url: "/odata/v4/student-db"+element.sPath,
                    data: JSON.stringify({is_alumni:true})
                }).then(element.requestRefresh());
            });
        },
        GetAlumni:async function(oBindingContext,aSelectedContexts){
            if(aSelectedContexts.length>1){
                return false;
            }
            var aData = await jQuery.ajax({
                type:"GET",
                contentType:"application/json",
                url:"/odata/v4/student-db"+aSelectedContexts[0].sPath,

            })
            return !aData.is_alumni;
        },
        SetStudent: function(oBindingContext,aSelectedContexts) {       
            aSelectedContexts.forEach(element => {
               MessageToast.show(element.sPath);
               var aData = jQuery.ajax({
                   type: "PATCH",
                   contentType: "application/json",
                   url: "/odata/v4/student-db"+element.sPath,
                   data: JSON.stringify({is_alumni:false})
               }).then(element.requestRefresh());
           });
       }
    }
}
)