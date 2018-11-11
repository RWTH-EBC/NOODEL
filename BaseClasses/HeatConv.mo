within NOODEL.BaseClasses;
class HeatConv
  extends Interfaces.Adapters.TwoTherm;
  parameter NOODEL.NonSIUnits.FlowRate BFB "Basal effective blood flow";
  NOODEL.NonSIUnits.FlowRate BF(start=0) "Total effective blood flow";
  Real alpha=1 "Ratio of counter-current heat exchange";
  NOODEL.NonSIUnits.VolumetricSpecificHeat rhoC=(1.067*3600)
    "Volumetric specific heat of blood";

equation
  therm1.Q_dot + therm2.Q_dot = 0;
  therm1.Q_dot = alpha*rhoC*BF * (therm1.T - therm2.T);
  annotation (Icon(graphics={Text(
          extent={{-48,94},{40,60}},
          lineColor={0,0,255},
          textString=
               "%name")}),Diagram(graphics),
    Documentation(info="<html>
<p>The <b>HeatConv</b> model represents the phenomenon of heat convection. </p>
</html>"));
end HeatConv;
