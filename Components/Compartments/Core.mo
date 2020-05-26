within NOODEL.Components.Compartments;
class Core

  BaseClasses.TwoThermCompartment twoThermCompartment
    annotation (Placement(transformation(extent={{-10,-8},{12,12}},
          rotation=0)));

  Interfaces.Adapters.BloodTherm bloodTherm
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}},
          rotation=0)));
  Interfaces.Adapters.Therm therm  annotation (Placement(transformation(
          extent={{80,-10},{100,10}}, rotation=0)));

  outer Interfaces.Parameters parameters;
  parameter Modelica.SIunits.SpecificHeatCapacity Ccore "Heat capacity of compartment,
    the order of magnitude was derived from JOS-2";
  parameter Modelica.SIunits.HeatFlowRate QB "Basal metabolic heat production,
    the order of magnitude was derived from JOS-2";
  parameter Modelica.SIunits.Mass weight "Weight of compartment,
    the order of magnitude was derived from JOS-2";
  parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC
                                                TSET "Set point temperature";
  Modelica.SIunits.HeatFlowRate Q(start=1) "Total metabolic heat production";
  Modelica.SIunits.HeatFlowRate W(start=0) "External work";
  Modelica.SIunits.HeatFlowRate CH(start=0) "Shivering heat production";

  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC
                                      ERROR "Output from thermoreceptor";
  // parameter Modelica.SIunits.Frequency RATE=0
  //   "dynamic sensitivity of thermoreceptor";
  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC
                                      COLD "Output from cold receptor";
  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC
                                      WARM "Output from warm receptor";

 Modelica.SIunits.Conversions.NonSIunits.Temperature_degC T0core "Start core temperature of body parts";
 // Modelica.SIunits.Conversions.NonSIunits.Temperature_degC T0cr;
  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC
                                      T(start=T0core)
    "Compartment temperature";



  Modelica.SIunits.HeatFlowRate RES "Heat loss by respiration";

equation
  connect(bloodTherm, twoThermCompartment.therm1) annotation (Line(points={{-90,0},
          {-7.8,0}},         color={200,100,0}));
  connect(twoThermCompartment.therm2, therm) annotation (Line(points={{
          9.8,0},{90,0}}, color={200,100,0}));
  Ccore*weight*der(twoThermCompartment.therm1.T)=Q+twoThermCompartment.therm1.Q_dot+twoThermCompartment.therm2.Q_dot-RES;

  Q = QB+W+CH;

  twoThermCompartment.therm1.T = T;
  twoThermCompartment.therm1.T = twoThermCompartment.therm2.T;

  ERROR = twoThermCompartment.therm1.T -  TSET; //Rate is not integrated because of missing data

   if (ERROR > 0) then
    COLD = 0;
    WARM = ERROR;
  else
    COLD = -ERROR; // Review2020: original --> COLD = ERROR;
    WARM = 0;
  end if;

  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),
            graphics),
    DymolaStoredErrors,
    Icon(graphics={Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,255},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}));
end Core;
