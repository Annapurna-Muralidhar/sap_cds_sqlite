namespace com.satinfotech.studentdb;
using { managed, cuid } from '@sap/cds/common';

@assert.unique:{
    st_id:[st_id]
}

entity Student : cuid, managed {
    key ID: UUID;
    @title:'Student ID'
    st_id:String(10);
    @title:'Gender'
    gender:String(1);
    @title:'First Name'
    first_name:String(10) @mandatory;
    @title:'Last Name'
    last_name:String(10) @mandatory;
    @title:'Email ID'
    email_id:String(40) @mandatory;
    @title:'PAN No'
    pan_no:String(10);
    @title:'DOB'
    dob: Date @mandatory;
    @title:'Course'
    course : Association to Courses;
    @title: 'Languages Known'
    Languages: Composition of many {
        key ID : UUID;
        langid:Association to Languages;
    }
    @title:'Age'
    virtual age:Integer @Core.Computed;
    @title:'Gender Desc'
    virtual gender_description:String(10) @Core.Computed;
    @title:'Is Alumni'
    is_alumni:Boolean default false;

    

}

// @mandatory makes the input mandatory
//if the schema structure is changed redeploy using cds deploy --to sqlite command

// entity StudentLanguages: managed,cuid {
//     studentid: Association to Student;
//     langid: Association to Languages;
// }


@cds.persistence.skip
entity Gender {
    @title:'code'
    key code: String(1);
    @title:'description'
    description:String(10);
}

entity Courses : cuid, managed {
    @title: 'Code'
    code: String(3);
    @title: 'Description'
    description: String(50);

    
    // students: Association to Student on students.course_ID = $self.ID;

    Books: Composition of many {
        key ID: UUID;
        bookid:Association to Books;
    }
    
}

entity Languages: cuid, managed {
    @title: 'Code'
    code: String(2);
    @title: 'Description'
    description: String(20);
}

entity Books : cuid,managed{
    @title:'Code'
    code:String(5);
    @title:'Description'
    description:String(20);
}