tableextension 55000 "KUBP Sales Header Ext" extends "Sales Header"
{
    fields
    {
        field(55000; "Sales Number"; Text[40])
        {
            Caption = 'Sales Number';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(55001; "CBPM Opportunity No."; Code[20])
        {
            Caption = 'CBPM Opportunity No.';
            DataClassification = CustomerContent;
            TableRelation = Opportunity."No.";
        }
        field(55002; "Quantity New"; Integer)
        {
            Caption = 'Quantity New';
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line"."Quantity New" where("Document Type" = field("Document Type"),
                                                                  "Document No." = field("No.")));
            Editable = false;
        }
    }

    trigger OnInsert()
    begin
        GenerateSalesNumber();
    end;

    local procedure GenerateSalesNumber()
    var
        SalesHeader: Record "Sales Header";
        YearText: Text[2];
        Number: Integer;
        CurrentYear: Integer;
    begin
        CurrentYear := Date2DMY("Document Date", 3);
        YearText := CopyStr(Format(CurrentYear), 3, 2);

        // Find the last number for this year
        SalesHeader.SetFilter("Sales Number", YearText + '.*');
        SalesHeader.SetRange("Document Type", "Document Type");
        if SalesHeader.FindLast() then begin
            Evaluate(Number, CopyStr(SalesHeader."Sales Number", 4));
            Number += 1;
        end else
            Number := 1;

        "Sales Number" := YearText + '.' + PadStr('', 6 - StrLen(Format(Number)), '0') + Format(Number);
    end;
}