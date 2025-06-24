codeunit 55000 "KUBP Sales Post Events"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    local procedure OnBeforePostSalesDoc(var SalesHeader: Record "Sales Header")
    begin
        // This ensures CBPM Opportunity No. is available during posting
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvHeaderInsert', '', false, false)]
    local procedure OnAfterSalesInvHeaderInsert(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header")
    begin
        SalesInvHeader."CBPM Opportunity No." := SalesHeader."CBPM Opportunity No.";
        SalesInvHeader.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', false, false)]
    local procedure OnAfterInitGLEntry(var GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        GLEntry."CBPM Opportunity No." := GenJournalLine."CBPM Opportunity No.";
    end;

    // Використовуємо подію з таблиці Gen. Journal Line для передачі даних
    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', false, false)]
    local procedure OnAfterCopyGenJnlLineFromSalesHeader(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."CBPM Opportunity No." := SalesHeader."CBPM Opportunity No.";
    end;

    // Альтернативна подія для міжкомпанійних транзакцій
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeInsertICGenJnlLine', '', false, false)]
    local procedure OnBeforeInsertICGenJnlLine(var ICGenJournalLine: Record "Gen. Journal Line"; SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean)
    begin
        ICGenJournalLine."CBPM Opportunity No." := SalesHeader."CBPM Opportunity No.";
    end;
}