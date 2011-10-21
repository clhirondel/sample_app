clientSideValidations.validators.local["email_format"] = function (element, options) {  
  var return_message="email is not valid";
  
  if(!/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i.test(element.val()) && element.val() != "") {  
    if (!/^translation missing/.test(options.message)) {
            alert(options.message);
            return_message = options.message ;  
    }
    return return_message ;  
  } 
}  
clientSideValidations.validators.local["datetime_format"] = function (element, options) {  
  var return_message="date time is not valid";
  
  if(!Time.parse((element.val())) && element.val() != "") {  
    if (!/^translation missing/.test(options.message)) {
            alert(options.message);
            return_message = options.message ;  
    }
    return return_message ;  
  }  
}