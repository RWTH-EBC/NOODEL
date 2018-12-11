within NOODEL.Functions;
function TSo

    input Real TSl[16];
  // output Real TSo_weight[17];
  output Real TSo "overall thermal sensation";
  Real TSl_sort[16] "sorted thermal sensation";

algorithm
  TSl_sort :=Modelica.Math.Vectors.sort(TSl);

  if TSl_sort[8] > 0 and TSl_sort[3] > 0 then
    TSo := 0.5 * TSl_sort[16]+0.5*TSl_sort[14];
  end if;

  if TSl_sort[8] > 0 and TSl_sort[3] < 0 then
    TSo := 0.33 * TSl_sort[16]+0.33*TSl_sort[14]+0.33*TSl_sort[1];
  end if;

  if TSl_sort[8] < 0 and TSl_sort[14] < 0 then
    TSo := 0.38 * TSl_sort[1]+ 0.62*TSl_sort[3];
  end if;

  if TSl_sort[8] < 0 and TSl_sort[14] > 0 then
    TSo := 0.33 * TSl_sort[1]+0.33*TSl_sort[2]+0.33*TSl_sort[16];
  end if;

  annotation (Documentation(info="<html>
<p>The <b>TSo</b> function calculates the overall thermal sensation on a scale between -3 and 3. </p>
</dl></html>"));
end TSo;
