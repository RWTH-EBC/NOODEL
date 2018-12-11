within NOODEL.Interfaces.Adapters;
connector TS "Thermal sensation"
   Real TSl;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Rectangle(
          extent={{-80,82},{80,-78}},
          pattern=LinePattern.None,
          lineThickness=1,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-54,62},{-40,34}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={255,0,0}),
        Rectangle(
          extent={{-54,34},{-40,6}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={255,96,64}),
        Rectangle(
          extent={{-54,6},{-40,-22}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={0,128,255}),
        Rectangle(
          extent={{-54,-22},{-40,-50}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),
        Text(
          extent={{-20,30},{32,-20}},
          lineColor={0,0,0},
          fillColor={255,96,64},
          fillPattern=FillPattern.Solid,
          textString="TS")}), Documentation(info="<html>
<p>The <b>TS</b> connector is used for output of results and within coupling to CFD to send the thermal sensation calculated within NOODEL to the CFD calculation.</p>
</html>"));
end TS;
