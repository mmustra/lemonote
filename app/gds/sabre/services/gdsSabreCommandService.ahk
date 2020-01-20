class GdsSabreCommandService
{
    static commandType := {PCTC: "pctc"
    , PCTM: "pctm"
    , CTCE: "ctce"
    , CTCM: "ctcm"
    , CTCR: "ctcr"
    , DOCS: "docs"
    , DOCO: "doco"
    , DOCA: "doca"}
    
    CreateCommand(commandType, data)
    {
        command := "Command not found for """ . commandType . """ command type!"
        switch commandType
        {
            case this.commandType.PCTC: {
                command := data.ssrCode . "OSI YY PCTC/" . data.passengerName . "/" . data.countryCode . data.passengerPhone . "-" . data.passengerIndex . ".1"
            }
            case this.commandType.PCTM: {
                command := data.ssrCode . "OSI YY PCTM/" . data.passengerName . "/" . data.countryCode . data.passengerPhone . "-" . data.passengerIndex . ".1"
            }
            case this.commandType.CTCE: {
                command := data.ssrCode . "OSI YY CTCE/" . data.passengerEmail . "-" . data.passengerIndex . ".1"
            }
            case this.commandType.CTCM: {
                command := data.ssrCode . "OSI YY CTCM/" . data.countryCode . data.passengerPhone . "-1." . data.passengerIndex
            }
            case this.commandType.CTCR: {
                command := data.ssrCode . "OSI YY CTCR/" . data.refusalNote . "-" . data.passengerIndex . ".1"
            }
            case this.commandType.DOCS: {
                passengerMiddleName := data.passengerMiddleName ? "/" . data.passengerMiddleName : ""
                command := "3DOCS/P/" . data.passportIssuedBy . "/" . data.passportCode . "/" . data.passengerNationality . "/" . data.passengerDOB . "/" . data.passengerGender . "/" . data.passportExpiryDate . "/" . data.passengerLastName . "/" . data.passengerFirstName . passengerMiddleName . "-" . data.passengerIndex . ".1"
            }
            case this.commandType.DOCO: {
                command := "3DOCO/" . data.passengerNationality . "/V/" . data.visaCode . "/" . data.visaIssuedBy . "/" . data.visaIssueDate . "/" . visaApplicableFor . "-" . data.passengerIndex . ".1"
            }
            case this.commandType.DOCA: {
                command := "3DOCA/" . data.destinationType . "/" . data.destinationCountry . "/" . data.destinationAddress . "/" . data.destinationCity . "/" . data.destinationState . "/" . data.destinationZip . "-" . data.passengerIndex . ".1"
            }
        }
        return command
    }
}