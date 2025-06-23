tableextension 55004 "KUBP Gen. Journal Line Ext" extends "Gen. Journal Line"
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