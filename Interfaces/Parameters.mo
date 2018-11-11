within NOODEL.Interfaces;
model Parameters "BC human body"

  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC TempEnv
    "Average environmental temperature for evaporation";

//  parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC T0sk
//    "Initial skin temperature";
//  parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC T0cr
//    "Initial core temperature";

//   parameter ComfortModel33NCMStandaloneOM2.Functions.Position Position=
//       ComfortModel33NCMStandaloneOM2.Functions.Position.seat
  Modelica.Blocks.Interfaces.RealInput Position annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-4,94})));

//Control coefficients
   Modelica.SIunits.ThermalConductance CSW=371.2 "Sweating from head core";
   Modelica.SIunits.ThermalConductance SSW=33.64 "Sweating from skin";
   Modelica.SIunits.ThermalConductance PSW=0 "Sweating from head core and skin";
   Modelica.SIunits.ThermalConductance CCH=0 "Shivering from head core";
   Modelica.SIunits.ThermalConductance SCH=0 "Shivering from skin";
   Modelica.SIunits.ThermalConductance PCH=24.36
    "Shivering from head core and skin";
  NOODEL.NonSIUnits.Vasodilation CDL=117 "Vasodilation from head core";
  NOODEL.NonSIUnits.Vasodilation SDL=7.5 "Vasoldilation from skin";
  NOODEL.NonSIUnits.VasodilationSkinHeadCore PDL=0
    "Vasodilation from head core and skin";
  NOODEL.NonSIUnits.TemperatureDependentChange CST=10.8
    "Vasoconstriction from head core";
  NOODEL.NonSIUnits.TemperatureDependentChange SST=10.8
    "Vasoconstriction from skin";
  NOODEL.NonSIUnits.TemperatureDependentChangeSquare PST=0
    "Vasoconstriction from head core and skin";

  Modelica.Blocks.Interfaces.RealInput Tair[16]
    annotation (Placement(transformation(extent={{126,68},{86,108}})));
  Modelica.Blocks.Interfaces.RealInput Trad[16]
    annotation (Placement(transformation(extent={{126,34},{86,74}})));
  Modelica.Blocks.Interfaces.RealInput v[16]
    annotation (Placement(transformation(extent={{128,-6},{88,34}})));
  Modelica.Blocks.Interfaces.RealInput rh
    annotation (Placement(transformation(extent={{128,-44},{88,-4}})));

  Modelica.Blocks.Interfaces.RealInput met
    annotation (Placement(transformation(extent={{128,-80},{88,-40}})));
  Modelica.Blocks.Interfaces.RealInput Icl[16]
    annotation (Placement(transformation(extent={{-126,68},{-86,108}})));
  Modelica.Blocks.Interfaces.RealInput CSF[16]
    annotation (Placement(transformation(extent={{-126,34},{-86,74}})));
  Modelica.Blocks.Interfaces.RealInput Tmt[16]
    annotation (Placement(transformation(extent={{-126,-6},{-86,34}})));
  Modelica.Blocks.Interfaces.RealInput CSR[16]
    annotation (Placement(transformation(extent={{-126,-44},{-86,-4}})));
  Modelica.Blocks.Interfaces.RealInput ISolar[16]
    annotation (Placement(transformation(extent={{-126,-80},{-86,-40}})));
  Modelica.Blocks.Interfaces.RealInput T0sk
    annotation (Placement(transformation(extent={{-126,-110},{-86,-70}})));
  Modelica.Blocks.Interfaces.RealInput T0cr
    annotation (Placement(transformation(extent={{128,-110},{88,-70}})));
algorithm
   TempEnv:=sum(Tair)/16;

    annotation (Dialog(group="Body"),
    defaultComponentName="parameters",
    defaultComponentPrefixes="inner",
    missingInnerMessage="
Your model is using an outer \"system\" component but
an inner \"system\" component is not defined.
For simulation drag Modelica.Fluid.System into your model
to specify system properties. The default System setting
is used for the current simulation.
",  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,150},{150,110}},
          lineColor={0,0,255},
          textString="%name"),
        Line(points={{-86,-30},{82,-30}}, color={0,0,0}),
        Line(points={{-82,-68},{-52,-30}}, color={0,0,0}),
        Line(points={{-48,-68},{-18,-30}}, color={0,0,0}),
        Line(points={{-14,-68},{16,-30}}, color={0,0,0}),
        Line(points={{22,-68},{52,-30}}, color={0,0,0}),
        Text(
          extent={{-84,32},{80,0}},
          lineColor={0,0,0},
          textString="Parameters
")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Documentation(info="<html>
<p>The parameter component provides system-wide settings, such as ambient conditions, intial skin and core temperature and position of the human body.</p>
</html>"));
end Parameters;
