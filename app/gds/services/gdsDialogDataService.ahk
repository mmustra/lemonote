class GdsDialogDataService
{
    _ParseData(value, pattern := "", errorMessage := "Invalid")
    {
        if (pattern) {
            pattern := "O)" . pattern
            foundPos := RegExMatch(value, pattern, matchObj)
            foundValue := matchObj.Value()
            isValid := foundPos && foundPos > 0
        } else {
            matchObj :=
            foundValue := value
            isValid := true
        }
        StringUpper, foundValue, foundValue
        errorMessage := isValid ? "" : errorMessage
        parsedResult := {isValid: isValid, value: Trim(foundValue), match: matchObj, errorMessage: errorMessage}
        return parsedResult
    }
    
    ParsePassengerName(passengerName, isOptional := 0)
    {
        pattern := "^\s*[a-zA-Z]+(?: [a-zA-Z]+)*\s*$"
        pattern := isOptional ? pattern . "|^$" : pattern
        errorMessage := "A-Z space"
        return this._ParseData(passengerName, pattern, errorMessage)
    }
    
    ParsePhoneCountryCode(countryCode)
    {
        pattern := "^[a-zA-Z]{2}$|^[0-9]{1,3}$"
        errorMessage := "a-z[2] or 0-9"
        return this._ParseData(countryCode, pattern, errorMessage)
    }
    
    ParsePassengerPhone(passengerPhone)
    {
        pattern := "^\d+$"
        errorMessage := "0-9 only"
        return this._ParseData(passengerPhone, pattern, errorMessage)
    }
    
    ParseSsrCode(ssrArlines)
    {
        value := ssrArlines == 2 ? 4 : 3
        return this._ParseData(value)
    }
    
    ParsePassengerIndex(passengerIndex)
    {
        pattern := "^[1-9]\d*$"
        errorMessage := "0-9 only"
        return this._ParseData(passengerIndex, pattern, errorMessage)
    }
    
    ParsePassengerEmail(passengerEmail)
    {
        pattern := "^\s*[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+\s*$"
        errorMessage := "Use valid chars (test@example.com)"
        parsedData := this._ParseData(passengerEmail, pattern, errorMessage)
        emailValue := parsedData.value
        emailValue := StrReplace(emailValue, "@", "//")
        emailValue := StrReplace(emailValue, "_", "..")
        emailValue := StrReplace(emailValue, "-", "./")
        parsedData.value := emailValue
        return parsedData
    }
    
    ParseRefusalNote(refusalNote)
    {
        value := refusalNote ? Trim(refusalNote) : "Refused"
        return this._ParseData(value)
    }
    
    ParsePassport(passport)
    {
        pattern := "^[0-9a-zA-Z]+$"
        errorMessage := "0-9A-Z only"
        return this._ParseData(passport, pattern, errorMessage)
    }
    
    ParseVisa(visa)
    {
        pattern := "^[0-9a-zA-Z]+$"
        errorMessage := "0-9 A-Z only"
        return this._ParseData(visa, pattern, errorMessage)
    }
    
    ParseCountryCode(countryCode)
    {
        pattern := "^[a-zA-Z]{2,3}$"
        errorMessage := "A-Z only"
        return this._ParseData(countryCode, pattern, errorMessage)
    }
    
    ParseDate(inputDate)
    {
        pattern := "^(0[1-9]|[12]\d|3[01])(?:\.|\/)(0[1-9]|1[0-2])(?:\.|\/)([1-9]\d{3})$"
        errorMessage := "dd./mm./yyyy"
        parsedData := this._ParseData(inputDate, pattern, errorMessage)
        match := parsedData.match
        monthName := {01: "JAN"
                     ,02: "FEB"
                     ,03: "MAR"
                     ,04: "APR"
                     ,05: "MAY"
                     ,06: "JUN"
                     ,07: "JUL"
                     ,08: "AUG"
                     ,09: "SEP"
                     ,10: "OCT"
                     ,11: "NOV"
                     ,12: "DEC"}
        parsedData.value := match.Value(1) . monthName[match.Value(2)] . match.Value(3)
        return parsedData
    }
    
    ParseGender(gender)
    {
        switch gender
        {
            case 2: {
                value := "F"
            }
            case 3: {
                value := "MI"
            }
            case 4: {
                value := "FI"
            }
            default: {
                value := "M"
            }
        }
        return this._ParseData(value)
    }
    
    ParseAddress(address)
    {
        pattern := "^\s*[a-zA-Z0-9]+(?: [a-zA-Z0-9]+)*\s*$"
        errorMessage := "0-9 A-Z space"
        return this._ParseData(address, pattern, errorMessage)
    }
    
    ParseDestinationType(destinationType)
    {
        value := destinationType == 2 ? "R" : "D"
        return this._ParseData(value)
    }
    
    ParseState(state)
    {
        pattern := "^\s*[a-zA-Z]+(?: [a-zA-Z]+)*\s*$"
        errorMessage := "A-Z space"
        return this._ParseData(state, pattern, errorMessage)
    }
    
    ParseCity(city)
    {
        pattern := "^\s*[a-zA-Z]+(?: [a-zA-Z]+)*\s*$"
        errorMessage := "A-Z space"
        return this._ParseData(city, pattern, errorMessage)
    }
    
    ParseZip(zipCode)
    {
        pattern := "^\s*[a-zA-Z0-9]+(?: [a-zA-Z0-9]+)*\s*$"
        errorMessage := "0-9 A-Z space"
        return this._ParseData(zipCode, pattern, errorMessage)
    }
}