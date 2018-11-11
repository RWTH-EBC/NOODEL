within NOODEL.Functions;
function Ps

  input Modelica.SIunits.Conversions.NonSIunits.Temperature_degC
                                            T;
  output Modelica.SIunits.Pressure Ps "Saturated vapour pressure";

algorithm
  // Magnus-Formel nach DWD: Aspirations.Psychrometer Tafeln; 5. Auflage, Friedr. Vieweg & Sohn, 1976
  // http://www.wolkenschnueffler.de/media//DIR_62701/df77f3c59fe10fe8ffff8221ac14421f.pdf
   Ps := 610.78*Modelica.Math.exp(1.0)^((17.08085*T)/(234.175+T)); //in Pa
  annotation (Documentation(info="<html>
<p>The <b>Ps</b> function calculates the saturated vapor pressure for a given temperature. </p>
</html>"));
end Ps;
