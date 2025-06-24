tableextension 55001 "KUBP Sales Line Ext" extends "Sales Line"
{
    fields
    {
        field(55000; "Quantity New"; Integer)
        {
            Caption = 'Quantity New';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdateHeaderQuantityNew();
            end;
        }
    }

    local procedure UpdateHeaderQuantityNew()
    var
        SalesHeader: Record "Sales Header";
    begin
        if SalesHeader.Get("Document Type", "Document No.") then begin
            SalesHeader.CalcFields("Quantity New");
        end;
    end;
}