pageextension 55000 "KUBP Sales Order Ext" extends "Sales Order"
{
    layout
    {
        addafter("External Document No.")
        {
            field("Sales Number"; Rec."Sales Number")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the sales number in format Year.Number';
            }
            field("CBPM Opportunity No."; Rec."CBPM Opportunity No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the related opportunity number';
            }
        }
        addafter("Amount Including VAT")
        {
            field("Quantity New"; Rec."Quantity New")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the sum of Quantity New from sales lines';

                trigger OnAfterValidate()
                begin
                    CurrPage.Update();
                end;
            }
        }
    }

    actions
    {
        addafter("F&unctions")
        {
            action("Check Line Types")
            {
                Caption = 'Check Line Types';
                ApplicationArea = All;
                Image = CheckList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SalesLine: Record "Sales Line";
                    ModifiedCount: Integer;
                    ConfirmMsg: Label 'Do you want to check and update Fixed Asset lines?';
                    ResultMsg: Label '%1 line(s) have been updated.';
                begin
                    if not Confirm(ConfirmMsg) then
                        exit;

                    SalesLine.SetRange("Document Type", Rec."Document Type");
                    SalesLine.SetRange("Document No.", Rec."No.");
                    SalesLine.SetRange(Type, SalesLine.Type::"Fixed Asset");

                    if SalesLine.FindSet(true) then begin
                        repeat
                            SalesLine.Validate("Unit Price", 0);
                            SalesLine.Modify(true);
                            ModifiedCount += 1;
                        until SalesLine.Next() = 0;
                    end;

                    if ModifiedCount > 0 then begin
                        Message(ResultMsg, ModifiedCount);
                        CurrPage.Update(false);
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        Rec.CalcFields("Quantity New");
    end;
}