tableextension 55003 "KUBP G/L Entry Ext" extends "G/L Entry"
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