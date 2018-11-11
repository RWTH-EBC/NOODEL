within NOODEL.Interfaces.Adapters;
connector BloodTherm "Basic thermal connector"
  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC
                                      T;
  flow Modelica.SIunits.HeatFlowRate Q_dot;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Rectangle(
          extent={{-80,80},{82,-80}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,0,0})}),
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
          fillColor={255,0,0})}),
    Documentation(info="<html>
<p>The <b>BloodTherm</b> connector is the same connector as the <b>Therm</b> connector. It carries information on temperature and heat flow rate. There is no predetermined direction of the heat flow. The seperation into <b>Therm</b> and <b>BloodTherm</b> gives the possibility to distinguish between heat conduction and heat convection. </p>
</html>",
      revisions="<html>
</html>"));

end BloodTherm;
