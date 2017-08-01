//
//  FirebaseConstants.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 30/07/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import Foundation
import Firebase


//  MARK: Firebase

var database = Database.database().reference()
var storage = Storage.storage().reference()


//  MARK: Bus Times
public let KBUS_TIMES = "bus_times"
public let NBUS_FROM = "from"
public let NBUS_TO = "to"
public let NBUS_LOCATION = "location"

//  MARK: Academic Calendar
public let KLAST_PDF = "last_pdf"

//  MARK: Contacts
public let KCONTACTS = "contacts"
public let NCONTACTS_TITLE = "title"
public let NCONTACTS_LABEL = "label"
public let NCONTACTS_CONTENT = "content"

//  MARK: Departments
public let KDEPARTMENTS = "departments"

//  MARK: Exams
public let KEXAMS = "exams"
public let KEXAMS_ELECTIVES = "electives"
public let NEXAMS_EDITABLE = "editable"
public let NEXAMS_CODE = "code"
public let NEXAMS_DATE = "date"
public let NEXAMS_ELECTIVE = "elective"
public let NEXAMS_PLACE = "place"
public let NEXAMS_TIME = "time"

//  MARK: GPA
public let KGPA = "gpa"
public let KGPA_CREDIT = "credit"
public let KGPA_GRADE = "grade"
public let KGPA_NAME = "name"

//  MARK:
public let KLECTURES = "lectures"
public let KLECTURE_CODE = "code"
public let KLECTURE_NAME = "name"
public let KLECTURE_PLACE = "place"
public let KLECTURE_SECTION = "section"
public let KLECTURE_TIME = "time"

//  MARK: Studying Materials
public let KMATERIALS = "studying_materials"
public let KMATERIALS_DESC = "desc"
public let KMATERIALS_ID = "id"
public let KMATERIALS_LINK = "link"
public let KMATERIALS_NAME = "name"

//  MARK: Users
public let KUSERS = "users"
public let KUSERS_BIRTHDATE = "Birthday"
public let KUSERS_EMAIL = "Email"
public let KUSERS_NAME = "Name"
public let KUSERS_PHONE = "Phone"
public let KUSERS_PHOTO = "Photo"













