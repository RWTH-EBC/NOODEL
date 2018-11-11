within NOODEL.BaseClasses;
class HeatConvSkin
  extends Interfaces.Adapters.TwoTherm;
  parameter NOODEL.NonSIUnits.FlowRate BFB "Basal effective blood flow";
  NOODEL.NonSIUnits.FlowRate BF(start=0) "Total effective blood flow";
  Real alpha "Ratio of counter-current heat exchange";
  NOODEL.NonSIUnits.VolumetricSpecificHeat rhoC=(1.067*3600)
    "Volumetric specific heat of blood";

equation
  therm1.Q_dot = alpha*rhoC*BF * (therm1.T - therm2.T);
  therm1.Q_dot + therm2.Q_dot = 0;

  annotation (Icon(graphics={Text(
          extent={{-48,94},{40,60}},
          lineColor={0,0,255},
          textString=
               "%name")}),Diagram(graphics),
    Documentation(info="<html>
<p>The <b>HeatConvSkin</b> model represents the phenomenon of heat convection in the skin compartment. The calculation of the total effective blood flow differs from the other compartments. </p>
</html>"));
end HeatConvSkin;
