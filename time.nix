x: with x; module (_: [])
{
  time = expr
    "Month -> Year -> Time"
    ""
    (m: y: { inherit m y; })
    ;

  sortTime = expr
    "Time -> Time -> BooL"
    ""
    (a: b: a.y > b.y || (a.y == b.y && a.m >= b.m))
    ;

  timeToString = expr
    "Time -> String" 
    ""
    (x:
      let
        monthToString = 
          [ 
            "Jan"
            "Feb"
            "Mar"
            "Apr"
            "May"
            "Jun"
            "Jul"
            "Aug"
            "Sep"
            "Oct"
            "Nov"
            "Dec"
          ];
        g = { m, y }: "${builtins.elemAt monthToString (m - 1)}. ${builtins.toString y}";
      in
        if x == null then "present" else g x
    )
    ;
}
