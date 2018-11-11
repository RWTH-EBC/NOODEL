within NOODEL.Components.Segments;
partial model BodyPart "Template of any body part"

  outer Interfaces.Parameters parameters;
  outer Modelica.SIunits.Power Qb;
  outer Modelica.SIunits.Conversions.NonSIunits.Temperature_degC WRMS;
  outer Modelica.SIunits.Conversions.NonSIunits.Temperature_degC CLDS;
  outer Modelica.SIunits.Conversions.NonSIunits.Temperature_degC Cerr;
  outer Modelica.SIunits.Conversions.NonSIunits.Temperature_degC Cwarm;
  outer Modelica.SIunits.Conversions.NonSIunits.Temperature_degC Ccold;
  outer Real ST;
  outer NOODEL.NonSIUnits.FlowRate DL;
  outer Modelica.SIunits.Conversions.NonSIunits.Temperature_degC TskinAve;
  outer Modelica.SIunits.Conversions.NonSIunits.Temperature_degC TsetpsyAve;
  outer Real TSo "Overall thermal sensation";
  outer Modelica.SIunits.Power Qshiv;
  outer Modelica.SIunits.Power Qmet;
  outer Modelica.SIunits.HeatFlowRate met;

  parameter Real alpha "Ratio of counter current heat transfer" annotation(Evaluate=true,HideResult=true, Dialog(tab="Initialization"));
  parameter Real CD "Thermal conductance" annotation(Evaluate=true,HideResult=true, Dialog(tab="Initialization"));

  parameter Real RESC "Coefficient of resperation work"
                                                       annotation(Evaluate=true,HideResult=true, Dialog(tab="Initialization"));
  parameter Real SKINR "Fraction of all skin receptors in segment"
                                                                  annotation(Evaluate=true,HideResult=true, Dialog(tab="Initialization"));
  parameter Real SKINS
    "Fraction of sweating command applicable to skin of segment" annotation(Evaluate=true,HideResult=true, Dialog(tab="Initialization"));
  parameter Real SKINV
    "Fraction of vasodilatation command applicable to skin of segment"
                                                                      annotation(Evaluate=true,HideResult=true, Dialog(tab="Initialization"));
  parameter Real SKINC
    "Fraction of vasoconstriction command applicable to skin of segment"
                                                                        annotation(Evaluate=true,HideResult=true, Dialog(tab="Initialization"));
  parameter Real CHILF
    "Distribution coefficient of muscle layer for shivering heat production"
                                                                            annotation(Evaluate=true,HideResult=true, Dialog(tab="Initialization"));
  parameter Real METF
    "Distribution coefficient of muscle layer for heat production by external work"
                                                                                   annotation(Evaluate=true,HideResult=true, Dialog(tab="Initialization"));
  parameter Real CoeffTSl[7] "Local thermal sensation coefficients" annotation(Evaluate=true,HideResult=true, Dialog(tab="Initialization"));

  parameter Real TClcoeff[3] "Local thermal comfort coefficients" annotation(Evaluate=true,HideResult=true, Dialog(tab="Initialization"));

  parameter Real B "Coefficient for convective heat transfer coefficient sitting position" annotation(Evaluate=true,HideResult=true, Dialog(tab="Initialization"));
  parameter Real n "Coefficient for convective heat transfer coefficient sitting position" annotation(Evaluate=true,HideResult=true, Dialog(tab="Initialization"));
  parameter Real CR
    "fraction of seated total body surface area available to radiate" annotation(Evaluate=true,HideResult=true, Dialog(tab="Initialization"));
  parameter Real Bs "Coefficient for convective heat transfer coefficient standing position" annotation(Evaluate=true,HideResult=true, Dialog(tab="Initialization"));
  parameter Real ns "Coefficient for convective heat transfer coefficient standing position" annotation(Evaluate=true,HideResult=true, Dialog(tab="Initialization"));
  parameter Real CRS
    "fraction of Standing total body surface area available to radiate" annotation(Evaluate=true,HideResult=true, Dialog(tab="Initialization"));

  Real TSl( start=0) "Local thermal sensation";
  Real TCl "Local thermal comfort";

  NOODEL.NonSIUnits.TemperatureDependentChange UnitConst=1;

  Compartments.Core core annotation (Placement(transformation(extent={{-86,
            -10},{-66,10}}, rotation=0)));
  BaseClasses.HeatConv CoreConv annotation (Placement(transformation(
          extent={{-78,-36},{-58,-16}}, rotation=0)));
  Interfaces.Adapters.BloodTherm bloodTherm
    annotation (Placement(transformation(extent={{-10,-38},{10,-18}},
          rotation=0)));
  BaseClasses.HeatCond SkinCoreCond
                                   annotation (Placement(transformation(
          extent={{-10,-8},{10,12}},rotation=0)));
  BaseClasses.HeatConvSkin SkinConv annotation (Placement(transformation(extent={{54,-36},
            {74,-16}},          rotation=0)));
  Compartments.Skin skin
    annotation (Placement(transformation(extent={{82,-10},{62,10}})));
equation
  //Heat production by external work in the core layer of all segments
  core.W = max((met-Qb)*METF,0);
  //Perspiration
  skin.ESW = max((parameters.CSW*Cerr+parameters.SSW*(WRMS-CLDS)+parameters.PSW*UnitConst*Cwarm*WRMS)*SKINS*skin.km,0);
  //Shivering heat production in each segment
  core.CH = max(parameters.PCH*Ccold*CLDS*CHILF,0);
  //Heat loss by respiration at the core layer in chest segment
  core.RES = Qb*(0.0014*(34 - parameters.TempEnv) + 0.017*(5.867 - parameters.rh
    *NOODEL.Functions.Ps(parameters.TempEnv)/1000))*RESC;
  //Vasomotion in skin layer of all segments
  SkinConv.BF = ((SkinConv.BFB+SKINV*DL)/(1+(SKINC*ST)))*skin.km;
  // Blood flow rate for core layer of all segments
  CoreConv.BF = CoreConv.BFB+(core.W+core.CH)/1.16;

  //Local thermal sensation
  TSl = min(max(NOODEL.Functions.TSl(
    skin.T,
    skin.TSETpsy,
    TskinAve,
    TsetpsyAve,
    der(skin.T),
    der(core.T),
    CoeffTSl), -3), 3);

  //Local thermal comfort
  TCl = min(max(NOODEL.Functions.TCl(TClcoeff, TSl), -3), 3);

  CD = SkinCoreCond.CD;
  alpha = SkinConv.alpha;

  //Convective heat transfer
//   if parameters.Position == ComfortModel33NCMStandaloneOM2.Functions.Position.seat then
//       skin.ERAFC = CR;
//       skin.HCf=B*skin.v^n;
//   elseif parameters.Position == ComfortModel33NCMStandaloneOM2.Functions.Position.stand then
//       skin.ERAFC = CRS;
//       skin.HCf=Bs*skin.v^ns;
//   end if;

  //R. J. de Dear, E. Arens, H. Zhang, M. Oguro: Convective and radiative heat transfer coefficients
  //for individual human body segments, International Journal for Biometeorology, 40, pp. 141 – 156, 1997
  // 0 - standing position, 1 - seated position
  if parameters.Position == 1 then
      skin.ERAFC = CR;
      skin.HCf=B*skin.v^n;
      skin.HCm=10.1*skin.v^0.61;
  else
      skin.ERAFC = CRS;
      skin.HCf=Bs*skin.v^ns;
      skin.HCm=10.4*skin.v^0.56;
  end if;

  connect(core.bloodTherm, CoreConv.therm1) annotation (Line(points={{-85,0},{-90,
          0},{-90,-28},{-76,-28}},         color={200,100,0}));
  connect(SkinConv.therm1, bloodTherm)
    annotation (Line(points={{56,-28},{0,-28}}, color={200,100,0}));
  connect(CoreConv.therm2, bloodTherm) annotation (Line(points={{-60,-28},{0,
          -28}},    color={200,100,0}));
  connect(core.therm, SkinCoreCond.therm1) annotation (Line(points={{-67,0},{
          -8,0}},      color={200,100,0}));
  connect(SkinCoreCond.therm2, skin.therm) annotation (Line(
      points={{8,0},{63,0}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(SkinConv.therm2, skin.bloodTherm) annotation (Line(
      points={{72,-28},{80,-28},{80,-30},{88,-30},{88,0},{81,0}},
      color={0,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Documentation(info="<html>
<p>Partial model for a body part.</p>
</html>"));
end BodyPart;
