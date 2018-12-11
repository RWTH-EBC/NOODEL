within NOODEL.Interfaces.Adapters;
connector HeatFlux "Basic thermal connector"
  Modelica.SIunits.HeatFlux Q;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Rectangle(
          extent={{-80,80},{80,-80}},
          pattern=LinePattern.None,
          lineThickness=1,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Polygon(
          points={{-52,-14},{-40,18},{28,26},{40,-18},{-52,-14}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-8,2},{4,44}},
          color={0,0,0},
          smooth=Smooth.None,
          arrow={Arrow.None,Arrow.Open},
          thickness=0.5)}), Documentation(info="<html>
<p>The <b>HeatFlux</b> connector is used within coupling to CFD to get the total heat flux from the CFD calculation.</p>
</html>"));
end HeatFlux;
