variable "myVar" {
    type = string
    default = "myvalue"
}

/* 
    terraform console
    var.myvar
    "${var.myvar}"

    exit or control-d to exit terraform console
 */

 variable "myMap" {
     type = map(string)
     default = {
       mykey = "my value"
     }
 }

 /* 
    terraform console
    var.mymap
    "${var.mymap}"

    var.mymap.mykey
    var.mymap["mykey"]
    "${var.mymap.mykey}"
    "${var.mymap["mykey"]}"
 */

  variable "myList" {
      type = list(string)
      default = [
        "my value 1",
        "my value 2",
        "my value 3"
      ]
 }

  /* 
    var.mylist
    var.mylist.0
    var.mylist[0]

    element(var.mylist, 0)
    element(var.mylist, 1)
    slice(var.mylist, 0, 2)

    lists will always maintain the order they were created in
 */

 variable "mySet" {
     type = set(number)
     default = [
         5,
         1,
         2,
         2
    ]
 }

/* 
    set can only have unique values, terraform will order them and remove duplicates
 */
 
 variable "myTuple" {
     type = tuple([string, number, bool])
     default = [
         "my value 1",
         1,
         false
     ]
 }

variable "myObject" {
    type = object({
        key1 = string,
        key2 = number
    })
    default = {
        key1 = "my value 1",
        key2 = 1
    }
}

