within NOODEL.Functions;
function TCl

  input Real TClcoeff[3];
  input Real TSl;
  output Real TCl "Local thermal comfort";

algorithm
 TCl := TClcoeff[1]*TSl^2+TClcoeff[2]*TSl+TClcoeff[3];

  annotation (Documentation(info="<html>
<p>The TCl function calculates the local thermal comfort on a scale between -3 and 3. </p>
</html>"));
end TCl;
