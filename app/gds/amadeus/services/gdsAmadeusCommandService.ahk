class GdsAmadeusCommandService
{
    static commandType := {PCTC: "pctc"
    , CTCE: "ctce"
    , CTCM: "ctcm"
    , DOCS: "docs"
    , DOCO: "doco"
    , DOCA: "doca"}
    
    CreateCommand(commandType, data)
    {
        command := "Command not found for """ . commandType . """ command type!"
        switch commandType
        {
            case this.commandType.PCTC: {
                command := data.ssrCode . "SR PCTC YY/P" . data.passengerIndex . " " . data.countryCode . data.passengerPhone
            }
            case this.commandType.CTCE: {
                command := data.ssrCode . "SR CTCE YY/P" . data.passengerIndex . " " . data.passengerEmail
            }
            case this.commandType.CTCM: {
                command := data.ssrCode . "SR CTCM YY/P" . data.passengerIndex . " " . data.countryCode . data.passengerPhone
            }
            case this.commandType.DOCS: {
                passengerMiddleName := data.passengerMiddleName ? "-" . data.passengerMiddleName : ""
                command := "SR DOCS YY HK1-P-" . data.passportIssuedBy . "-" . data.passportCode . "-" . data.passengerNationality . "-" . data.passengerDOB . "-" . data.passengerGender . "-" . data.passportExpiryDate . "-" . data.passengerLastName . "-" . data.passengerFirstName . " " . data.passengerMiddleName . "/P" . data.passengerIndex
            }
            case this.commandType.DOCO: {
                command := "SR DOCO YY HK1-" . data.passengerPOBCity . " " . data.passengerPOBCountry . "-V-" . data.visaCode . "-" . data.visaIssuedBy . "-" . data.visaIssueDate . "-" . visaApplicableFor . "/P" . data.passengerIndex
            }
            case this.commandType.DOCA: {
                command := "SR DOCA YY HK1-" . data.destinationType . "-" . data.destinationCountry . "-" . data.destinationAddress . "-" . data.destinationCity . "-" . data.destinationState . "-" . data.destinationZip . "/P" . data.passengerIndex
            }
        }
        return command
    }
}