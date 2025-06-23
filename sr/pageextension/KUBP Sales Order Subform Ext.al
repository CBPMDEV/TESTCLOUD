pageextension 55001 "KUBP Sales Order Subform Ext" extends "Sales Order Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("Quantity New"; Rec."Quantity New")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the new quantity';

                trigger OnValidate()
                begin
                    CurrPage.Update();
                    CurrPage.SaveRecord();
                end;
            }
        }
    }
}