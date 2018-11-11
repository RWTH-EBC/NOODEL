within NOODEL.Interfaces.Adapters;
connector p "Basic pressure connector"
  Real p;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Rectangle(
          extent={{-80,80},{82,-80}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,127,0}), Text(
          extent={{-28,22},{32,-20}},
          lineColor={0,0,255},
          textString=
               "Temp")}),
    Window(
      x=0.35,
      y=0.23,
      width=0.44,
      height=0.65),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Rectangle(
          extent={{-80,80},{82,-80}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,127,0}), Text(
          extent={{-32,18},{28,-24}},
          lineColor={0,0,255},
          textString=
               "plocal")}),
    Documentation(info="<html>
<p>The <b>p</b> connector is used within coupling to CFD to get the ambient pressure from the CFD calculation.</p>
</html>",
      revisions="<html>
<ul>
  <li><i>March 14, 2005&nbsp;</i>
         by Timo Haase:<br>
         Implemented.</li>
</ul>
</html>"));

end p;
