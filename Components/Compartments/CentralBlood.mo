within NOODEL.Components.Compartments;
class CentralBlood

  Modelica.SIunits.HeatCapacity Cblood=(2.61*3600) "Heat capacity";
  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC
                                      TSET=36.71 "Set point temperature";

  parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC
                                                 T0=36.7 "Initial temperature";
  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC
                                      T(start=T0) "Compartment temperature";

  NOODEL.BaseClasses.BloodThermCompartment bloodThermCompartmentTanabe
    annotation (Placement(transformation(extent={{-10,-8},{10,12}}, rotation=0)));
  Interfaces.Adapters.BloodTherm bloodTherm
    annotation (Placement(transformation(extent={{-50,80},{-30,100}},
          rotation=0)));
  Interfaces.Adapters.BloodTherm bloodTherm1
    annotation (Placement(transformation(extent={{30,80},{50,100}},
          rotation=0)));
  Interfaces.Adapters.BloodTherm bloodTherm2
    annotation (Placement(transformation(extent={{-50,-100},{-30,-80}},
          rotation=0)));
  Interfaces.Adapters.BloodTherm bloodTherm3
    annotation (Placement(transformation(extent={{30,-100},{50,-80}},
          rotation=0)));
  Interfaces.Adapters.BloodTherm bloodTherm4
    annotation (Placement(transformation(extent={{-100,30},{-80,50}},
          rotation=0)));
  Interfaces.Adapters.BloodTherm bloodTherm5
    annotation (Placement(transformation(extent={{-100,-50},{-80,-30}},
          rotation=0)));
  Interfaces.Adapters.BloodTherm bloodTherm6
    annotation (Placement(transformation(extent={{80,28},{100,48}},
          rotation=0)));
  Interfaces.Adapters.BloodTherm bloodTherm7
    annotation (Placement(transformation(extent={{80,-50},{100,-30}},
          rotation=0)));
equation

 Cblood*der(bloodThermCompartmentTanabe.therm1.T)=bloodThermCompartmentTanabe.therm1.Q_dot+bloodThermCompartmentTanabe.therm2.Q_dot
                                            +bloodThermCompartmentTanabe.therm3.Q_dot+bloodThermCompartmentTanabe.therm4.Q_dot
                                            +bloodThermCompartmentTanabe.therm5.Q_dot+bloodThermCompartmentTanabe.therm6.Q_dot
                                            +bloodThermCompartmentTanabe.therm7.Q_dot+bloodThermCompartmentTanabe.therm8.Q_dot;
  bloodThermCompartmentTanabe.therm1.T = T;

  bloodThermCompartmentTanabe.therm1.T = bloodThermCompartmentTanabe.therm2.T;
  bloodThermCompartmentTanabe.therm3.T = bloodThermCompartmentTanabe.therm1.T;
  bloodThermCompartmentTanabe.therm4.T = bloodThermCompartmentTanabe.therm1.T;
  bloodThermCompartmentTanabe.therm5.T = bloodThermCompartmentTanabe.therm1.T;
  bloodThermCompartmentTanabe.therm6.T = bloodThermCompartmentTanabe.therm1.T;
  bloodThermCompartmentTanabe.therm7.T = bloodThermCompartmentTanabe.therm1.T;
  bloodThermCompartmentTanabe.therm8.T = bloodThermCompartmentTanabe.therm1.T;

  connect(bloodTherm, bloodThermCompartmentTanabe.therm5) annotation (Line(
        points={{-40,90},{-40,20},{-4.2,20},{-4.2,7.8}}, color={200,100,0}));
  connect(bloodTherm1, bloodThermCompartmentTanabe.therm4) annotation (Line(
        points={{40,90},{40,20},{3.6,20},{3.6,7.8}}, color={200,100,0}));
  connect(bloodTherm6, bloodThermCompartmentTanabe.therm8) annotation (Line(
        points={{90,38},{90,4},{8,4}}, color={200,100,0}));
  connect(bloodTherm7, bloodThermCompartmentTanabe.therm2) annotation (Line(
        points={{90,-40},{90,-2.2},{8,-2.2}}, color={200,100,0}));
  connect(bloodTherm3, bloodThermCompartmentTanabe.therm3) annotation (Line(
        points={{40,-90},{40,-20},{3.8,-20},{3.8,-7.2}}, color={200,100,0}));
  connect(bloodTherm2, bloodThermCompartmentTanabe.therm6) annotation (Line(
        points={{-40,-90},{-40,-20},{-4,-20},{-4,-7.2}}, color={200,100,0}));
  connect(bloodTherm5, bloodThermCompartmentTanabe.therm1) annotation (Line(
        points={{-90,-40},{-90,-2},{-8,-2}}, color={200,100,0}));
  connect(bloodTherm4, bloodThermCompartmentTanabe.therm7) annotation (Line(
        points={{-90,40},{-90,4.2},{-8,4.2}}, color={200,100,0}));
  annotation (Diagram(graphics),
                       Icon(graphics={Ellipse(
          extent={{-52,32},{54,-72}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid), Polygon(
          points={{-46,4},{0,78},{50,2},{-46,4}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid)}));
end CentralBlood;
