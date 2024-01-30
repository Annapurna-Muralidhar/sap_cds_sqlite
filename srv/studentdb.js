// same name as cds file

// validating the inputs given by user
// cqn query notation allows to parse through the data to 
// update in yarn by palcing ('key') and patch 

const cds = require('@sap/cds');

function calcAge(dob){
    var today = new Date();
    var birthDate = new Date(Date.parse(dob));
    var age = today.getFullYear()-birthDate.getFullYear();
    var m = today.getMonth()-birthDate.getMonth();
    if(m<0 || (m===0 && today.getDate()<birthDate.getDate())){
        age--;
    }
    return age;


}

function getGenderDescription(genderCode) {
    if (genderCode === 'M') {
        return 'Male';
    } else if(genderCode === 'F'){
        return 'Female';
    }else{
        return "unknown";
    }
}


module.exports = cds.service.impl(function () {

    const { Student , Gender} = this.entities()//here Student  is same as mentioned entity in schema.cds

    this.on(['READ'], Student, async(req) => {
        results = await cds.run(req.query);
        if(Array.isArray(results)){
            results.forEach(element => {
             element.age=calcAge(element.dob); 
             element.gender_description = getGenderDescription(element.gender);
             
            });
        }else{
            results.age=calcAge(results.dob);
            results.gender_description = getGenderDescription(results.gender);
        }
        
        return results;
    });
    //in this below code if the updation is required,it shiws the bud that exail id already exist so the below seperation of logic is done 
    // this.before(['CREATE','UPDATE'], Student, async(req) => {
    //     age = calcAge(req.data.dob);
    //     if (age<18 || age>45){
    //         req.error({'code': 'WRONGDOB',message:'Student not the right age for school:'+age, target:'dob'});
    //     }

    //     let query1 = SELECT.from(Student).where({ref:["email_id"]}, "=", {val: req.data.email_id});
    //     result = await cds.run(query1);
    //     if (result.length >0) {
    //         req.error({'code': 'STEMAILEXISTS',message:'Student with such email already exists', target: 'email_id'});
    //     }

    // });



    this.before(['CREATE'], Student, async(req) => {
        age = calcAge(req.data.dob);
        if (age<18 || age>45){
            req.error({'code': 'WRONGDOB',message:'Student not the right age for school:'+age, target:'dob'});
        }

        let query1 = SELECT.from(Student).where({ref:["email_id"]}, "=", {val: req.data.email_id});
        result = await cds.run(query1);
        if (result.length >0) {
            req.error({'code': 'STEMAILEXISTS',message:'Student with such email already exists', target: 'email_id'});
        }

    });

    this.before(['UPDATE'], Student, async(req) => {
        const { email_id, st_id } = req.data;
        if(email_id){
        let query = SELECT.from(Student).where({ref:["email_id"]}, "=", {val:email_id}).and({ref:["st_id"]},"!=",{val:st_id});
        result = await cds.run(query);
        if (result.length >0) {
            req.error({'code': 'STEMAILEXISTS',message:'Student with such email already exists', target: 'email_id'});
        }
    }
    });
    this.on('READ',Gender,async(req)=>{
                genders=[
                    {
                        "code":"M",
                        "description":"Male"
                    },
                    {
                        "code":"F",
                        "description":"Female"
                    }
                ]
                genders.$count=genders.length;
                return genders;
            })

});