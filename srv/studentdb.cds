using {com.satinfotech.studentdb as db} from '../db/schema';

service StudentDB {
    entity Student as projection on db.Student;
    entity Student.Languages as projection on db.StudentLanguages;
    entity Gender as projection on db.Gender;
    entity Languages as projection on db.Languages{
        @UI.Hidden
        ID,
        *
    };
    entity Courses as projection on db.Courses
    {
        @UI.Hidden: true
        ID,
        *
    };
    entity Books as projection on db.Books
    {
        @UI.Hidden: true
        ID,
        *
    };
    

}

annotate StudentDB.Student with @odata.draft.enabled;
//enables to create records from interface once this draft is enabled we will not be able to push using yarc if 
//done they will get placed in draft table not the original table here it only takes the student id to add data one 
//more annnotation is added at line no.55
annotate StudentDB.Courses with @odata.draft.enabled;
annotate StudentDB.Languages with @odata.draft.enabled;
annotate StudentDB.Books with @odata.draft.enabled;

annotate StudentDB.Student.Languages with @(
    UI.LineItem:[
        {
            Label: 'Languages',
            Value: langid_ID
        },
      
    ],
    UI.FieldGroup #StudentLanguages : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                Value : langid_ID,
            }
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'LanguagesFacet',
            Label : 'Languages',
            Target : '@UI.FieldGroup#StudentLanguages',
        },
    ],
);

annotate StudentDB.Courses.Books with @(
    UI.LineItem:[
        {
            Label: 'books',
            Value: bookid_ID
        },
      
    ],
    UI.FieldGroup #CourseBooks : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                Value : bookid_ID,
            }
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'CourseBooksFacet',
            Label : 'CourseBooks',
            Target : '@UI.FieldGroup#CourseBooks',
        },
    ],
);

annotate StudentDB.Books with @(
    UI.LineItem:[
        {
            Value: code
        },
        {
            Value: description
        }
    ],
     UI.FieldGroup #Books : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                Value : code,
            },
            {
                Value : description,
            }
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'BooksFacet',
            Label : 'Books',
            Target : '@UI.FieldGroup#Books',
        },
    ],

);


annotate StudentDB.Languages with @(
    UI.LineItem:[
        {
            Value: code
        },
        {
            Value: description
        }
    ],
     UI.FieldGroup #Languages : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                Value : code,
            },
            {
                Value : description,
            }
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'LanguagesFacet',
            Label : 'Languages',
            Target : '@UI.FieldGroup#Languages',
        },
    ],

);


annotate StudentDB.Courses with @(
    UI.LineItem:[
        {
            Value: code
        },
        {
            Value: description
        },
        {
            Label : 'Course Books',
            Value: Books.bookid.description
        }
    ],
     UI.FieldGroup #CourseInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                Value : code,
            },

            {
                Value : description,
            }
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'CourseInfoFacet',
            Label : 'Course Information',
            Target : '@UI.FieldGroup#CourseInformation',
        },
         {
            $Type : 'UI.ReferenceFacet',
            ID : 'CourseBookFacet',
            Label : 'Course Books',
            Target : 'Books/@UI.LineItem',
    },

    ],
   

);

annotate StudentDB.Student with {
    first_name      @assert.format: '^[a-zA-Z]{2,}$';
    last_name      @assert.format: '^[a-zA-Z]{2,}$';    
    email_id     @assert.format: '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    pan_no      @assert.format: '^[A-Z]{5}[0-9]{4}[A-Z]{1}$';
    //telephone @assert.format: '^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$';
}

annotate StudentDB.Gender with @(
    UI.LineItem: [
        {
            $Type : 'UI.DataField',
            Value : code
        },
        {
            $Type : 'UI.DataField',
            Value : description
        },
    ],
   
);


annotate StudentDB.Student with @(
    UI.LineItem: [
        {
            $Type : 'UI.DataField',
            Value : st_id
        },
        {
            $Type : 'UI.DataField',
            Label:'Gender',
            Value : gender,
    
        },
        {
            $Type : 'UI.DataField',
            Label:'Gender Desc',
            Value : gender_description,
        },
        {
            $Type : 'UI.DataField',
            Value : first_name
        },
        {
            $Type : 'UI.DataField',
            Value : last_name
        },
        {
            $Type : 'UI.DataField',
            Value : email_id
        },
        {
            $Type : 'UI.DataField',
            Value : pan_no
        },
        {
            $Type : 'UI.DataField',
            Value : dob
        },
        {
            $Type : 'UI.DataField',
            Value : course.code
        },
        {
            $Type : 'UI.DataField',
            Value : age
        },
        
    ],
    UI.SelectionFields: [ first_name , last_name, email_id,pan_no,age,gender],
   
);

annotate StudentDB.Student with @(
    UI.FieldGroup #StudentInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : st_id,
            },
            {
                $Type : 'UI.DataField',
                Label:'Gender',
                Value : gender,
            
            },
            {
                $Type : 'UI.DataField',
                Value : first_name,
            },
            {
                $Type : 'UI.DataField',
                Value : last_name,
            },
            {
                $Type : 'UI.DataField',
                Value : email_id,
            },
            {
                $Type : 'UI.DataField',
                Value : pan_no,
            },
            {
                $Type : 'UI.DataField',
                Value : dob,
            },
            {
                $Type : 'UI.DataField',
                Value : course_ID,
            },
          
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'StudentInfoFacet',
            Label : 'Student Information',
            Target : '@UI.FieldGroup#StudentInformation',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'StudentLanguagesFacet',
            Label : 'Student Languages Information',
            Target : 'Languages/@UI.LineItem',
        },
    ],
    
);

annotate StudentDB.Student.Languages with {
    langid @(
        Common.Text: langid.description,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Languages',
            CollectionPath : 'Languages',
            Parameters: [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : langid_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'code'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description'
                },
            ]
        }
    );
}

annotate StudentDB.Courses.Books with {
    bookid @(
        Common.Text: bookid.description,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Books',
            CollectionPath : 'Books',
            Parameters: [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : bookid_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'code'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description'
                },
            ]
        }
    );
}



annotate StudentDB.Student with {
    gender @(
        Common.ValueListWithFixedValues:true,
        Common.ValueList: {
            Label :'Genders',
            CollectionPath:'Gender',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty:gender,
                    ValueListProperty:'code'
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty:'description'
                }

            ]
        }
    );
    course @(
        Common.Text: course.description,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Courses',
            CollectionPath : 'Courses',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : course_ID,
                    ValueListProperty : 'ID'
                },
               
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'code'
                },
                   {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description'
                }
            ]
        }
    )
};


