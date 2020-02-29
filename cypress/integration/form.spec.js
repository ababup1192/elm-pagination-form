/// <reference types='cypress' />

describe("Form", () => {
  beforeEach(() => {
    cy.visit("http://localhost:1234");
  });

  describe("正常系", () => {
    it("0,A,a の組み合わせで最後まで到達する", () => {
      cy.get("input").type("0");
      cy.contains("next").click();
      cy.get("input").type("A");
      cy.contains("next").click();
      cy.get("input").type("a");
      cy.contains("end").click();
      cy.contains("Final").should("exist");
    });

    it("5,C,abcde の組み合わせで最後まで到達する", () => {
      cy.get("input").type("5");
      cy.contains("next").click();
      cy.get("input").type("C");
      cy.contains("next").click();
      cy.get("input").type("abcde");
      cy.contains("end").click();
      cy.contains("Final").should("exist");
    });

    it("6,E,efg の組み合わせで最後まで到達する", () => {
      cy.get("input").type("6");
      cy.contains("next").click();
      cy.get("input").type("E");
      cy.contains("next").click();
      cy.get("input").type("efg");
      cy.contains("end").click();
      cy.contains("Final").should("exist");
    });

    it("0, Aを入力した時点で戻り、6, D の組み合わせで入力し直しても、最後まで到達する", () => {
      cy.get("input").type("0");
      cy.contains("next").click();
      cy.get("input").type("A");
      cy.contains("next").click();
      cy.contains("prev").click();
      cy.contains("prev").click();
      cy.get("input")
        .clear()
        .type("6");
      cy.contains("next").click();
      cy.get("input")
        .clear()
        .type("D");
      cy.contains("next").click();
      cy.get("input").type("abc");
      cy.contains("end").click();
      cy.contains("Final").should("exist");
    });
  });

  describe("異常系", () => {
    it("2桁の数字でnextを押しても次の画面に遷移しない", () => {
      cy.get("input").type("10");
      cy.contains("next").click();
      cy.contains("1/3").should("exist");
    });

    it("負の数字でnextを押しても次の画面に遷移しない", () => {
      cy.get("input").type("-1");
      cy.contains("next").click();
      cy.contains("1/3").should("exist");
    });

    it("1でDを入力してnextを押しても次の画面に遷移しない", () => {
      cy.get("input").type("1");
      cy.contains("next").click();
      cy.get("input").type("D");
      cy.contains("next").click();
      cy.contains("2/3").should("exist");
    });

    it("8でBを入力してnextを押しても次の画面に遷移しない", () => {
      cy.get("input").type("8");
      cy.contains("next").click();
      cy.get("input").type("B");
      cy.contains("next").click();
      cy.contains("2/3").should("exist");
    });

    it("最後に空文字のままendを押しても最終画面に遷移しない", () => {
      cy.get("input").type("4");
      cy.contains("next").click();
      cy.get("input").type("B");
      cy.contains("next").click();
      cy.contains("end").click();
      cy.contains("3/3").should("exist");
    });

    it("最後に長さ6の文字列を入力してendを押しても最終画面に遷移しない", () => {
      cy.get("input").type("4");
      cy.contains("next").click();
      cy.get("input").type("B");
      cy.contains("next").click();
      cy.get("input").type("abcdef");
      cy.contains("end").click();
      cy.contains("3/3").should("exist");
    });
  });
});
