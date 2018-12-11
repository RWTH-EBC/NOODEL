within NOODEL.Interfaces.Adapters;
connector Temp "Basic thermal connector"
  Real T;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
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
        Text(
          extent={{-36,22},{24,-18}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          fontSize=8,
          textString="T")}), Documentation(info="<html>
<p>The <b>Temp</b> connector is used within coupling to CFD to send the skin temperature calculated within NOODEL to the CFD calculation.</p>
</html>"));

end Temp;
