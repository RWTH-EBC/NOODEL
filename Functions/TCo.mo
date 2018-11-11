within NOODEL.Functions;
function TCo

  input Real TCl[16];
  output Real TCo "overall thermal comfort";

algorithm
  TCo := 0.5*max(TCl)+0.5*min(TCl);
  annotation (Documentation(info="<html>
<p>The TCo function calculates the overall thermal comfort on a scale between -3 and 3.</p>
</html>"));
end TCo;
