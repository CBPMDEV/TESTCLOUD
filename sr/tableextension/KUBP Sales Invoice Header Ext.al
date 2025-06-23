tableextension 55002 "KUBP Sales Invoice Header Ext" extends "Sales Invoice Header"
{
    fields
    {
        field(55001; "CBPM Opportunity No."; Code[20])
        {
            Caption = 'CBPM Opportunity No.';
            DataClassification = CustomerContent;
            TableRelation = Opportunity."No.";
        }
    }
}