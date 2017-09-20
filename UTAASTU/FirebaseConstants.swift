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

//  MARK: FOOD
public let KFOOD = "food"
public let NFOOD_MEAL = "meal"
public let NFOOD_CAL = "cal"

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
public let NGPA_CREDIT = "credit"
public let NGPA_GRADE = "grade"
public let NGPA_NAME = "name"

//  MARK: Lectures
public let KLECTURES = "lectures"
public let KLECTURE_CODE = "code"
public let KLECTURE_NAME = "name"
public let KLECTURE_PLACE = "place"
public let KLECTURE_SECTION = "section"
public let KLECTURE_TIME = "time"

//  MARK: Studying Materials
public let KMATERIALS = "studying_materials"
public let NMATERIALS_DESC = "desc"
public let NMATERIALS_ID = "id"
public let NMATERIALS_LINK = "link"
public let NMATERIALS_NAME = "name"

//  MARK: Users
public let KUSERS = "users"
public let KUSERS_BIRTHDATE = "Birthday"
public let KUSERS_EMAIL = "Email"
public let KUSERS_NAME = "Name"
public let KUSERS_PHONE = "Phone"
public let KUSERS_PHOTO = "Photo"
public let KUSERS_DEPARTMENT = "Department"

//  MARK: Social Groups
public let KSocialGroups = "social_groups"
public let NSocialGroups_NAME = "name"
public let NSocialGroups_DESC = "desc"
public let NSocialGroups_LANG = "language"
public let NSocialGroups_LINK = "link"
public let NSocialGroups_ID = "id"













