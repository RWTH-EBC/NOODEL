within NOODEL.BaseClasses;
class TwoThermCompartment

  Interfaces.Adapters.Therm therm1
               annotation (Placement(transformation(extent={{-90,-30},{-70,
            -10}}, rotation=0)));
  Interfaces.Adapters.Therm therm2
               annotation (Placement(transformation(extent={{70,-30},{90,
            -10}}, rotation=0)));
  annotation (Icon(graphics={Rectangle(extent={{-80,60},{80,-100}},
            lineColor={0,0,255})}),Documentation(info="<html>
<p>The <b>TwoThermCompartment</b> model represents a compartment with two thermal connectors. </p>
</html>"));
end TwoThermCompartment;
