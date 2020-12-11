conix: with conix; 

module (_: []) {

  isEmpty = expr
    "Content -> Bool"
    "Checks if the content evaluates to an empty string"
    (userExpr: (eval userExpr).text == "");
}
