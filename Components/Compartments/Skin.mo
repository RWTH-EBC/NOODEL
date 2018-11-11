within NOODEL.Components.Compartments;
class Skin

  BaseClasses.TwoThermCompartment twoThermCompartment
    annotation (Placement(transformation(extent={{-10,-8},{12,12}},
          rotation=0)));

  Interfaces.Adapters.BloodTherm bloodTherm
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}},
          rotation=0)));
  Interfaces.Adapters.Therm therm  annotation (Placement(transformation(
          extent={{80,-10},{100,10}}, rotation=0)));

  outer Modelica.SIunits.Pressure PAIR;
  outer parameter Interfaces.Parameters parameters;
  parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC
                                                TSET
    "Set point temperature for physiological model";
  parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC
                                                TSETpsy
    "Set point temperature for psychological model";
  parameter Modelica.SIunits.HeatCapacity Cskin "Heat capacity of compartment,
    the order of magnitude was derived from JOS-2";

  parameter Modelica.SIunits.HeatFlowRate QB "Basal metabolic heat production,
    the order of magnitude was derived from JOS-2";
  parameter Modelica.SIunits.Mass weight "Weight of compartment,
  the order of magnitude was derived from JOS-2";
  parameter Modelica.SIunits.Area S "Surface area";

// Heat production
  Modelica.SIunits.HeatFlowRate Q(start=1) "Total metabolic heat production";
  Modelica.SIunits.HeatFlowRate Qcon(start=1)
    "Convective heat exchange rate between skin surface and environment";
  Modelica.SIunits.HeatFlowRate Qrad(start=0)
    "Radiative heat exchange rate between skin surface and environment";
  Modelica.SIunits.HeatFlowRate QMT(start=0)
    "Conductive heat exchange rate between skin surface and material";
  Modelica.SIunits.HeatFlowRate Qs(start=0) "Heat exchange by solar radiation";

  Real CSF "fraction of surface in contact with external surface";
  Real CSR "fraction of surface exposed to solar radiation";

  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC
                                      T(start=parameters.T0sk, fixed=true)
    "Compartment temperature";
  Modelica.SIunits.HeatFlowRate ISolar(start=0) "Solar Radiation";
  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC
                                      Tmt "Material temperature";
  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC
                                      Tair "Air temperature";
  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC
                                      Trad "Radiative temperature of the surrounding";
  Modelica.SIunits.Velocity v "Air velocity";

  //Active system
  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC
                                      COLD(start=0) "Output from cold receptor";
  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC
                                      WARM(start=0) "Output from warm receptor";
  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC
                                      RT=10 "Temperature width";
  Real km "Local multiplier";

  //Evaporation
  Modelica.SIunits.HeatFlowRate EB "Real Heat loss by water vapor diffusion";
  Modelica.SIunits.HeatFlowRate E "Total evaporative heat loss";
  Modelica.SIunits.HeatFlowRate ESW(start=0)
    "Heat loss by evaporation of sweat at skin layer";
  Modelica.SIunits.HeatFlowRate EMAX
    "Calculated maximal rate of evaporative heat loss";
  Modelica.SIunits.Pressure PSKIN "Water vapor pressure at skin temperature";

  //Heat transfer
  NOODEL.NonSIUnits.CoefficientOfEvaporativeHeatTransfer HE
    "Evaporative heat transfer coefficient from skin surface to the environment";
  Modelica.SIunits.CoefficientOfHeatTransfer HR "Radiative heat transfer coefficient";
  Modelica.SIunits.CoefficientOfHeatTransfer HC( start=4) "Convective heat transfer coefficient";
  Modelica.SIunits.CoefficientOfHeatTransfer HCn "Natural Convective heat transfer coefficient";
  Modelica.SIunits.CoefficientOfHeatTransfer HCm "Mixed Convective heat transfer coefficient";
  Modelica.SIunits.CoefficientOfHeatTransfer HCf "Forced Convective heat transfer coefficient";
  NOODEL.NonSIUnits.ClothingInsulation Icl "clothing insulation";
  Real fcl "clothing area factor";
   Real Fpcl "permeation efficiency factor";
  final constant Real sigma(final unit="W/(m2.K4)") = 5.67e-8;
  Real ERAFC;
  Modelica.SIunits.LewisNumber LR "Lewis ratio";

  Modelica.Blocks.Continuous.CriticalDamping ERROR_criticalDamping(
    normalized=false,
    n=3,
    f=0.02) annotation (Placement(transformation(extent={{58,-76},{78,-56}})));
  Modelica.Blocks.Continuous.CriticalDamping ERRORc_criticalDamping(
    n=2,
    normalized=false,
    f=0.0005)
    annotation (Placement(transformation(extent={{16,-74},{36,-54}})));
equation
  connect(bloodTherm, twoThermCompartment.therm1) annotation (Line(points={{-90,0},
          {-69.45,0},{-69.45,8.88179e-016},{-48.9,8.88179e-016},{-48.9,0},
          {-7.8,0}},          color={200,100,0}));
  connect(twoThermCompartment.therm2, therm) annotation (Line(points={{
          9.8,0},{29.85,0},{29.85,8.88179e-016},{49.9,8.88179e-016},{49.9,
          0},{90,0}}, color={200,100,0}));
  Q = QB;

  // Clothing area factor, McCullough E, Jones B, Huck J. A comprehensive database for estimating clothing insulation. ASHRAE Transactions 1985,91, 29–47
  fcl= 1.0 + 0.28*Icl;

  // Kandjov, I.: Heat and mass exchange processes between the surface of the human body and ambient air at various altitudes,
  // Int J Biometeorol, 199,43, pp. 38 - 44, eq. p. 42
  // HE = (3.08*(T-parameters.TempEnv)^0.25*(PAIR/101300)^0.5)/100;
  // HE = (3.08*(T-parameters.TempEnv)^0.25*(PAIR/101300)^0.5);

  LR = 16.5;

  //permeation efficiency factor, V. Candas, V. Candas, A. Hoeft (1995) Clothing, assessment and effects on thermophysiological responses of man working in humid heat, ERGONOMICS, 38-1,115-127
  Fpcl = 1/(1+0.155*fcl*HC*Icl/0.45);
  HE = (LR*Fpcl)/(0.155*Icl+(Fpcl/(HC*fcl)));
  HR=4*sigma*0.98*ERAFC*(273.15+(T+Trad)/2)^3;

  //P. O. Fanger: Thermal Comfort: Analysis and applications in environmental engineering. New York: McGraw-Hill Book Company, 1970
  HCn=2.38*abs(Tair-T)^0.25;

  if v<0.2 then // natural convection
   1/HC=1/HCn+0.155*Icl;
  elseif  v<1.5 then //mix convection
   1/HC=1/HCf+0.155*Icl;
  else //forced convection
   1/HC=1/HCf+0.155*Icl;
  end if;

  EMAX = max(HE*(PSKIN-PAIR)*S/1000,0.00000000000000000001);
  Cskin*weight*0.55*der(twoThermCompartment.therm1.T)=Q+twoThermCompartment.therm1.Q_dot+twoThermCompartment.therm2.Q_dot-E-QMT+Qs-Qcon-Qrad;
  if Icl > 0 then
    QMT = 1/(0.155*Icl+1/4.4)*CSF*S*fcl*(T-Tmt);// Heat loss to contact surfaces
  else
    QMT = 4.4*CSF*S*fcl*(T-Tmt);
  end if;
  Qcon = HC*(T-Tair)*S*fcl*(1-CSF);
  Qrad = HR*(T-Trad)*S*fcl*(1-CSF);

 // Heat gain by solar radiation, 0.8 is absorption of clothing
  Qs = S*fcl*CSR*0.8*ISolar;

  E = min(EB + ESW,EMAX);

  if (EMAX<0 or EMAX>0) then
    EB = max(0.06*(1-ESW/EMAX)*EMAX,0);
  else
   EB=0;
  end if;

  PSKIN = (NOODEL.Functions.Ps(twoThermCompartment.therm1.T));

  twoThermCompartment.therm1.T = T;
  twoThermCompartment.therm1.T = twoThermCompartment.therm2.T;

  ERROR_criticalDamping.u = (twoThermCompartment.therm1.T - TSET);
  ERRORc_criticalDamping.u = (twoThermCompartment.therm1.T - TSET); //Rate is not integrated because of missing data

    if (ERROR_criticalDamping.y > 0) then
     COLD = 0;
     WARM =  ERROR_criticalDamping.y;
   else
     COLD = 0.5*ERROR_criticalDamping.y;
     WARM = 0;
   end if;

   km = 2^(ERROR_criticalDamping.y/RT);
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),
            graphics),
    DymolaStoredErrors,
    Icon(graphics={Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={255,237,212},
          fillColor={255,237,212},
          fillPattern=FillPattern.Solid)}));
end Skin;
