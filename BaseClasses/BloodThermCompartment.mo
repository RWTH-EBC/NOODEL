within NOODEL.BaseClasses;
class BloodThermCompartment

  Interfaces.Adapters.Therm therm1
                                  annotation (Placement(transformation(
          extent={{-90,-50},{-70,-30}}, rotation=0)));
  Interfaces.Adapters.Therm therm2 annotation (Placement(transformation(
          extent={{70,-52},{90,-32}}, rotation=0)));

  Interfaces.Adapters.Therm therm3
               annotation (Placement(transformation(extent={{28,-102},{48,
            -82}}, rotation=0)));
  Interfaces.Adapters.Therm therm4
               annotation (Placement(transformation(extent={{26,48},{46,68}},
          rotation=0)));
  Interfaces.Adapters.Therm therm5
               annotation (Placement(transformation(extent={{-52,48},{-32,
            68}}, rotation=0)));
  Interfaces.Adapters.Therm therm6
               annotation (Placement(transformation(extent={{-50,-102},{-30,
            -82}}, rotation=0)));
  Interfaces.Adapters.Therm therm7 annotation (Placement(transformation(
          extent={{-90,12},{-70,32}}, rotation=0)));
  Interfaces.Adapters.Therm therm8 annotation (Placement(transformation(
          extent={{70,10},{90,30}}, rotation=0)));
  annotation (Diagram(graphics),
                       Icon(graphics={Rectangle(extent={{-80,60},{80,-100}},
            lineColor={0,0,255}), Text(
          extent={{-66,96},{62,70}},
          lineColor={0,0,255},
          textString=
               "%name")}),
    Documentation(info="<html>
<p>The <b>BloodThermCompartment</b> model represents the central blood compartment with eight thermal connectors. In the final model each connector is connected to two body segments. </p>
</html>"));
end BloodThermCompartment;
