within NOODEL.Interfaces;
model Parameters "BC human body"

   // Kai: add Coupling Parameter: if UseCoupling = false --> no coupling (Standalone Mode); if UseCoupling = true --> coupling Mode (via fmu)
 parameter Boolean UseCoupling = false "Boolean Coupling Flag" annotation(Evaluate=true, HideResult = false);
 // Kai: end of modification

  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC TempEnv
    "Average environmental temperature for evaporation";

//    parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC T0sk
//      "Initial skin temperature";
//    parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC T0cr
//      "Initial core temperature";

//      "Initial skin temperature"
  parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC T0sk[16] = {33,33,31.4,32,31.5,31.5,31.5,31.5,31,31,32.2,32.2,31,31,31,31} "Initial local skin temperature of body part" annotation(Evaluate=false, Placement(transformation(extent={{128,-130},{88,-90}})));
  //      "Initial core temperature"
  parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC T0cr[16] = {36.4,36.4,36.4,36.4,36.4,36.4,36.4,36.4,36.4,36.4,36.4,36.4,36.4,36.4,36.4,36.4} "Initial local core temperature of body part" annotation(Evaluate=false, Placement(transformation(extent={{88,-130},{48,-90}})));




//   parameter ComfortModel33NCMStandaloneOM2.Functions.Position Position=
//       ComfortModel33NCMStandaloneOM2.Functions.Position.seat

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

  // Intitial values / parameter definition

    // relative humidity
  parameter Real rh_Coupled = 0.47 if UseCoupling "Relative humidity (0-1); Only available in coupling mode" annotation(Evaluate=false);
  Modelica.Blocks.Interfaces.RealInput rh annotation (Placement(transformation(extent={{128,-44},{88,-4}})));

  // metabolic rate
  parameter Modelica.SIunits.HeatFlux met_Coupled = 58 if UseCoupling "Metabolic rate; Only available in coupling mode" annotation(Evaluate=false);
  Modelica.Blocks.Interfaces.RealInput met
    annotation (Placement(transformation(extent={{128,-80},{88,-40}})));

  // clothing insulation
  parameter Real Icl_Coupled[16] = {0, 1.1, 0.8, 1.3, 0.4, 0.4, 0, 0, 0, 0, 0.6, 0.6, 0.55, 0.55, 0.5, 0.5} if UseCoupling "Local clothing value in clo; Only available in coupling mode" annotation(Evaluate=false);
  Modelica.Blocks.Interfaces.RealInput Icl[16]
    annotation (Placement(transformation(extent={{-126,68},{-86,108}})));

   // contact surface fraction
  parameter Real CSF_Coupled[16] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} if UseCoupling "Relative local surface area in contact with material; Only available in coupling mode" annotation(Evaluate=false);
  Modelica.Blocks.Interfaces.RealInput CSF[16]
    annotation (Placement(transformation(extent={{-126,34},{-86,74}})));

  // contact surface temperature
  parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC Tmt_Coupled[16] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} if UseCoupling "Local contact temperature of material; Only available in coupling mode" annotation(Evaluate=false);
  Modelica.Blocks.Interfaces.RealInput Tmt[16]
    annotation (Placement(transformation(extent={{-126,-6},{-86,34}})));

  // solar radiation: surface fraction
  parameter Real CSR_Coupled[16] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} if UseCoupling "Relative local surface area exposed to solar irradiation; Only available in coupling mode" annotation(Evaluate=false);
  Modelica.Blocks.Interfaces.RealInput CSR[16]
    annotation (Placement(transformation(extent={{-126,-44},{-86,-4}})));

  // solar radiation: heat flux
  parameter Modelica.SIunits.HeatFlux ISolar_Coupled[16] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} if UseCoupling "Solar irradiation on local body part; Only available in coupling mode" annotation(Evaluate=false);
  Modelica.Blocks.Interfaces.RealInput ISolar[16]
    annotation (Placement(transformation(extent={{-126,-80},{-86,-40}})));

    // Position: Sitting or standing
  parameter Real Position_Coupled = 1 if UseCoupling "Position: 0 – sitting, 1 - standing; Only available in coupling mode" annotation(Evaluate=false);
  Modelica.Blocks.Interfaces.RealInput Position annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,106})));


  Modelica.Blocks.Math.RealToBoolean realToBoolean annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,64})));
  Modelica.Blocks.Interfaces.BooleanOutput sitting annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,34})));
algorithm
   TempEnv:=sum(Tair)/16;


equation



  connect(Position, realToBoolean.u)
    annotation (Line(points={{0,106},{0,76}}, color={0,0,127}));
  connect(realToBoolean.y, sitting)
    annotation (Line(points={{0,53},{0,34}}, color={255,0,255}));
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
