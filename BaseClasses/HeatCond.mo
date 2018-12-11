within NOODEL.BaseClasses;
class HeatCond
  extends Interfaces.Adapters.TwoTherm;
  Modelica.SIunits.ThermalConductance CD "thermal conductance";

equation
  therm1.Q_dot + therm2.Q_dot = 0;
  therm1.Q_dot = CD * (therm1.T - therm2.T);
  annotation (Icon(graphics={Text(
          extent={{-48,94},{40,60}},
          lineColor={0,0,255},
          textString=
               "%name")}),Documentation(info="<html>
<p>The <b>HeatCond</b> model represents the phenomenon of heat conduction. </p>
</html>"));
end HeatCond;
