within NOODEL.Model;
model NOODEL_standalone "NOODEL as standalone model"

   inner Modelica.SIunits.Power Qb=(head.core.QB
       + chest.core.QB + back.core.QB + pelvis.core.QB + l_Shoulder.core.QB +
      r_Shoulder.core.QB + l_Arm.core.QB + r_Arm.core.QB + l_Hand.core.QB +
      r_Hand.core.QB + l_Thigh.core.QB + r_Thigh.core.QB + l_Leg.core.QB +
      r_Leg.core.QB + l_Foot.core.QB + r_Foot.core.QB + head.skin.QB + chest.skin.QB
       + back.skin.QB + pelvis.skin.QB + l_Shoulder.skin.QB + r_Shoulder.skin.QB
       + l_Arm.skin.QB + r_Arm.skin.QB + l_Hand.skin.QB + r_Hand.skin.QB +
      l_Thigh.skin.QB + r_Thigh.skin.QB + l_Leg.skin.QB + r_Leg.skin.QB +
      l_Foot.skin.QB + r_Foot.skin.QB) "Basal metabolic rate of whole body";
  inner Modelica.SIunits.Area   Stotal = head.skin.S+back.skin.S+chest.skin.S
          +pelvis.skin.S+l_Shoulder.skin.S+r_Shoulder.skin.S+l_Arm.skin.S+r_Arm.skin.S
          +l_Thigh.skin.S+r_Thigh.skin.S+l_Leg.skin.S+r_Leg.skin.S+l_Foot.skin.S
          +r_Foot.skin.S+l_Hand.skin.S+r_Hand.skin.S
    "surface area of whole body";

  // Evaporative heat transfer
  Modelica.SIunits.HeatFlowRate ESW_total
    "Total heat loss by evaporation of sweat";
  Modelica.SIunits.HeatFlux E_total_m2
    "Total evaporative heat loss per sqr meter";
  Modelica.SIunits.HeatFlowRate Qe;

  // Signals active system
  inner Modelica.SIunits.Conversions.NonSIunits.Temperature_degC WRMS
    "Integrated warm signal"                                                                   annotation(HideResult=true);
  inner Modelica.SIunits.Conversions.NonSIunits.Temperature_degC CLDS
    "Integrated cold signal"                                                                   annotation(HideResult=true);
  inner Modelica.SIunits.Conversions.NonSIunits.Temperature_degC Cerr(start=0) annotation(HideResult=true);
  inner Modelica.SIunits.Conversions.NonSIunits.Temperature_degC Cwarm(start=0) annotation(HideResult=true);
  inner Modelica.SIunits.Conversions.NonSIunits.Temperature_degC Ccold(start=-1) annotation(HideResult=true);
  inner Real ST "Vasoconstriction signal";
  inner NOODEL.NonSIUnits.FlowRate DL "Vasodilation signal";

  // Temperatures
  inner Modelica.SIunits.Conversions.NonSIunits.Temperature_degC TskinAve
    "Mean skin temperature";
  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC TskinAve_seven_point
    "Seven point mean skin temperature according Hardy and DuBois";
  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC TsetAve
    "Mean set point temperature";
  inner Modelica.SIunits.Conversions.NonSIunits.Temperature_degC TsetpsyAve
    "Mean psychological set point temperature";

  // Heat flows
  inner Modelica.SIunits.HeatFlowRate Qshiv
    "Heat production by shivering";
  inner  Modelica.SIunits.HeatFlowRate Qmet;
  inner NOODEL.NonSIUnits.MetabolicRate met "Metabolic rate of whole body";

  //Psychological model
  Real TSmean( start=0) "Mean thermal sensation";
  Real TSlo[16] "Local thermal sensation" annotation(HideResult=true);
  inner Real TSo "Overall thermal sensation";
  Real TCmean "Local thermal comfort";
  Real TClo[16] "Local thermal comfort" annotation(HideResult=true);
  Real TCo "Local thermal comfort";

  inner Modelica.SIunits.Pressure PAIR;

  Interfaces.Adapters.TC TCl_head
    annotation (Placement(transformation(extent={{-98,88},{-86,100}})));
  Interfaces.Adapters.TS TSl_head
    annotation (Placement(transformation(extent={{86,88},{98,100}})));
  Interfaces.Adapters.TC TCl_chest
    annotation (Placement(transformation(extent={{-98,68},{-86,80}})));
  Interfaces.Adapters.TS TSl_chest
    annotation (Placement(transformation(extent={{86,68},{98,80}})));
  Interfaces.Adapters.TC TCl_back
    annotation (Placement(transformation(extent={{-98,58},{-86,70}})));
  Interfaces.Adapters.TS TSl_back
    annotation (Placement(transformation(extent={{86,58},{98,70}})));
  Interfaces.Adapters.TC TCl_pelvis
    annotation (Placement(transformation(extent={{-98,48},{-86,60}})));
  Interfaces.Adapters.TS TSl_pelvis
    annotation (Placement(transformation(extent={{86,48},{98,60}})));
  Interfaces.Adapters.TC TCl_lshoulder
    annotation (Placement(transformation(extent={{-98,38},{-86,50}})));
  Interfaces.Adapters.TS TSl_lshoulder
    annotation (Placement(transformation(extent={{86,38},{98,50}})));
  Interfaces.Adapters.TC TCl_rshoulder
    annotation (Placement(transformation(extent={{-98,28},{-86,40}})));
  Interfaces.Adapters.TS TSl_rshoulder
    annotation (Placement(transformation(extent={{86,28},{98,40}})));
  Interfaces.Adapters.TC TCl_larm
    annotation (Placement(transformation(extent={{-98,18},{-86,30}})));
  Interfaces.Adapters.TS TSl_larm
    annotation (Placement(transformation(extent={{86,18},{98,30}})));
  Interfaces.Adapters.TC TCl_rarm
    annotation (Placement(transformation(extent={{-98,8},{-86,20}})));
  Interfaces.Adapters.TS TSl_rarm
    annotation (Placement(transformation(extent={{86,8},{98,20}})));
  Interfaces.Adapters.TC TCl_lhand
    annotation (Placement(transformation(extent={{-98,-2},{-86,10}})));
  Interfaces.Adapters.TS TSl_lhand
    annotation (Placement(transformation(extent={{86,-2},{98,10}})));
  Interfaces.Adapters.TC TCl_rhand
    annotation (Placement(transformation(extent={{-98,-12},{-86,0}})));
  Interfaces.Adapters.TS TSl_rhand
    annotation (Placement(transformation(extent={{86,-12},{98,0}})));
  Interfaces.Adapters.TC TCl_lthigh
    annotation (Placement(transformation(extent={{-98,-22},{-86,-10}})));
  Interfaces.Adapters.TS TSl_lthigh
    annotation (Placement(transformation(extent={{86,-22},{98,-10}})));
  Interfaces.Adapters.TC TCl_rthigh
    annotation (Placement(transformation(extent={{-98,-32},{-86,-20}})));
  Interfaces.Adapters.TS TSl_rthigh
    annotation (Placement(transformation(extent={{86,-32},{98,-20}})));
  Interfaces.Adapters.TC TCl_lleg
    annotation (Placement(transformation(extent={{-98,-42},{-86,-30}})));
  Interfaces.Adapters.TS TSl_lleg
    annotation (Placement(transformation(extent={{86,-42},{98,-30}})));
  Interfaces.Adapters.TC TCl_rleg
    annotation (Placement(transformation(extent={{-98,-52},{-86,-40}})));
  Interfaces.Adapters.TS TSl_rleg
    annotation (Placement(transformation(extent={{86,-52},{98,-40}})));
  Interfaces.Adapters.TC TCl_lfoot
    annotation (Placement(transformation(extent={{-98,-62},{-86,-50}})));
  Interfaces.Adapters.TS TSl_lfoot
    annotation (Placement(transformation(extent={{86,-62},{98,-50}})));
  Interfaces.Adapters.TC TCl_rfoot
    annotation (Placement(transformation(extent={{-98,-72},{-86,-60}})));
  Interfaces.Adapters.TS TSl_rfoot
    annotation (Placement(transformation(extent={{86,-72},{98,-60}})));
  Interfaces.Adapters.TC TC_overall
    annotation (Placement(transformation(extent={{-98,-82},{-86,-70}})));
  Interfaces.Adapters.TS TS_overall
    annotation (Placement(transformation(extent={{86,-82},{98,-70}})));
  Interfaces.Adapters.TC TCl_neck
    annotation (Placement(transformation(extent={{-98,78},{-86,90}})));
  Interfaces.Adapters.TS TSl_neck
    annotation (Placement(transformation(extent={{86,78},{98,90}})));

  inner Interfaces.Parameters parameters(T0sk=34, T0cr=36.2)
    annotation (Placement(transformation(extent={{-40,66},{-20,86}})));
  Modelica.Blocks.Sources.CombiTimeTable InputData(
    tableOnFile=true,
    tableName="table",
    columns=2:132,
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://NOODEL/DataBase/BC_Nagano_37-31_degree.txt"))
    annotation (Placement(transformation(extent={{20,66},{0,86}})));

algorithm

  // Mean thermal sensation and mean thermal comfort
  TSmean := (head.TSl + chest.TSl+ back.TSl + pelvis.TSl+ l_Shoulder.TSl+
    r_Shoulder.TSl+ l_Arm.TSl+ r_Arm.TSl+ l_Hand.TSl+ r_Hand.TSl+ l_Thigh.TSl
     + r_Thigh.TSl+ l_Leg.TSl+r_Leg.TSl+ l_Foot.TSl+ r_Foot.TSl)/16;

  TCmean := (head.TCl*head.skin.S + chest.TCl*chest.skin.S + back.TCl*
    back.skin.S + pelvis.TCl*pelvis.skin.S + l_Shoulder.TCl*l_Shoulder.skin.S +
    r_Shoulder.TCl*r_Shoulder.skin.S + l_Arm.TCl*l_Arm.skin.S + r_Arm.TCl*r_Arm.skin.S
     + l_Hand.TCl*l_Hand.skin.S + r_Hand.TCl*r_Hand.skin.S + l_Thigh.TCl*
    l_Thigh.skin.S + r_Thigh.TCl*r_Thigh.skin.S + l_Leg.TCl*l_Leg.skin.S +
    r_Leg.TCl*r_Leg.skin.S + l_Foot.TCl*l_Foot.skin.S + r_Foot.TCl*r_Foot.skin.S)
    /Stotal;

  // Average temperatures
  TskinAve := (head.skin.T*head.skin.S+chest.skin.T*chest.skin.S+back.skin.T*back.skin.S+pelvis.skin.T*pelvis.skin.S+l_Shoulder.skin.T*l_Shoulder.skin.S
            +r_Shoulder.skin.T*r_Shoulder.skin.S+l_Arm.skin.T*l_Arm.skin.S+r_Arm.skin.T*r_Arm.skin.S+l_Hand.skin.T*l_Hand.skin.S+r_Hand.skin.T*r_Hand.skin.S
            +l_Thigh.skin.T*l_Thigh.skin.S+r_Thigh.skin.T*r_Thigh.skin.S+l_Leg.skin.T*l_Leg.skin.S+r_Leg.skin.T*r_Leg.skin.S+l_Foot.skin.T*l_Foot.skin.S
            +r_Foot.skin.T*r_Foot.skin.S)/Stotal;
            // Tskin ave seven point method according Hardy and DuBois
  TskinAve_seven_point := 0.07*head.skin.T+0.35*chest.skin.T+0.14*(l_Arm.skin.T+r_Arm.skin.T)/2+0.05*(l_Hand.skin.T+r_Hand.skin.T)/2+0.19*(l_Thigh.skin.T+r_Thigh.skin.T)/2
                          +0.13*(l_Leg.skin.T+r_Leg.skin.T)/2+0.07*(l_Foot.skin.T+r_Foot.skin.T)/2;

  TsetpsyAve := (head.skin.TSETpsy*head.skin.S+chest.skin.TSETpsy*chest.skin.S+back.skin.TSETpsy*back.skin.S+pelvis.skin.TSETpsy*pelvis.skin.S+l_Shoulder.skin.TSETpsy*l_Shoulder.skin.S
            +r_Shoulder.skin.TSETpsy*r_Shoulder.skin.S+l_Arm.skin.TSETpsy*l_Arm.skin.S+r_Arm.skin.TSETpsy*r_Arm.skin.S+l_Hand.skin.TSETpsy*l_Hand.skin.S+r_Hand.skin.TSETpsy*r_Hand.skin.S
            +l_Thigh.skin.TSETpsy*l_Thigh.skin.S+r_Thigh.skin.TSETpsy*r_Thigh.skin.S+l_Leg.skin.TSETpsy*l_Leg.skin.S+r_Leg.skin.TSETpsy*r_Leg.skin.S+l_Foot.skin.TSETpsy*l_Foot.skin.S
            +r_Foot.skin.TSETpsy*r_Foot.skin.S)/Stotal;

  TsetAve := (head.skin.TSET*head.skin.S+chest.skin.TSET*chest.skin.S+back.skin.TSET*back.skin.S+pelvis.skin.TSET*pelvis.skin.S+l_Shoulder.skin.TSET*l_Shoulder.skin.S
            +r_Shoulder.skin.TSET*r_Shoulder.skin.S+l_Arm.skin.TSET*l_Arm.skin.S+r_Arm.skin.TSET*r_Arm.skin.S+l_Hand.skin.TSET*l_Hand.skin.S+r_Hand.skin.TSET*r_Hand.skin.S
            +l_Thigh.skin.TSET*l_Thigh.skin.S+r_Thigh.skin.TSET*r_Thigh.skin.S+l_Leg.skin.TSET*l_Leg.skin.S+r_Leg.skin.TSET*r_Leg.skin.S+l_Foot.skin.TSET*l_Foot.skin.S
            +r_Foot.skin.TSET*r_Foot.skin.S)/Stotal;

  // Heat fluxes
  Qe := (head.skin.E+chest.skin.E+back.skin.E+pelvis.skin.E+l_Shoulder.skin.E+r_Shoulder.skin.E+l_Arm.skin.E+r_Arm.skin.E+
  l_Hand.skin.E+r_Hand.skin.E+l_Thigh.skin.E+r_Thigh.skin.E+l_Leg.skin.E+r_Leg.skin.E+l_Foot.skin.E+r_Foot.skin.E);

  Qmet:=(head.core.Q + chest.core.Q + back.core.Q + pelvis.core.Q + l_Shoulder.core.Q
     + r_Shoulder.core.Q + l_Arm.core.Q + r_Arm.core.Q + l_Hand.core.Q + r_Hand.core.Q
     + l_Thigh.core.Q + r_Thigh.core.Q + l_Leg.core.Q + r_Leg.core.Q + l_Foot.core.Q
     + r_Foot.core.Q+head.skin.Q + chest.skin.Q + back.skin.Q + pelvis.skin.Q + l_Shoulder.skin.Q
     + r_Shoulder.skin.Q + l_Arm.skin.Q + r_Arm.skin.Q + l_Hand.skin.Q + r_Hand.skin.Q
     + l_Thigh.skin.Q + r_Thigh.skin.Q + l_Leg.skin.Q + r_Leg.skin.Q + l_Foot.skin.Q
     + r_Foot.skin.Q);

  Qshiv:=(head.core.CH + chest.core.CH + back.core.CH + pelvis.core.CH +
    l_Shoulder.core.CH + r_Shoulder.core.CH + l_Arm.core.CH + r_Arm.core.CH +
    l_Hand.core.CH + r_Hand.core.CH + l_Thigh.core.CH + r_Thigh.core.CH + l_Leg.core.CH
     + r_Leg.core.CH + l_Foot.core.CH + r_Foot.core.CH);

public
  Components.Segments.Head head annotation (Placement(transformation(
          extent={{-38,-6},{20,32}},rotation=0)));
  Components.Segments.Chest chest annotation (Placement(transformation(
          extent={{-40,-16},{2,12}},  rotation=0)));
  Components.Compartments.CentralBlood centralBlood
    annotation (Placement(transformation(extent={{-16,-24},{-6,-14}},
                                                                   rotation=
           0)));
  Components.Segments.Back back annotation (Placement(transformation(
          extent={{-26,-18},{22,14}},
                                    rotation=0)));
  Components.Segments.Pelvis pelvis annotation (Placement(
        transformation(extent={{-34,-46},{12,-18}},
                                                 rotation=0)));
  Components.Segments.R_Shoulder r_Shoulder annotation (Placement(
        transformation(extent={{-50,-18},{-10,12}},rotation=0)));
  Components.Segments.L_Shoulder l_Shoulder
    annotation (Placement(transformation(extent={{-8,-18},{28,8}},rotation=0)));
  Components.Segments.R_Arm r_Arm annotation (Placement(transformation(
          extent={{-48,-30},{-16,-2}},
                                     rotation=0)));
  Components.Segments.R_Hand r_Hand annotation (Placement(
        transformation(extent={{-50,-42},{-16,-12}},
                                                   rotation=0)));
  Components.Segments.R_Thigh r_Thigh annotation (Placement(
        transformation(extent={{-30,-64},{-4,-28}}, rotation=0)));
  Components.Segments.L_Hand l_Hand annotation (Placement(
        transformation(extent={{-6,-44},{28,-16}},
                                                 rotation=0)));
  Components.Segments.L_Thigh l_Thigh annotation (Placement(
        transformation(extent={{-18,-60},{6,-32}}, rotation=0)));
  Components.Segments.R_Leg r_Leg annotation (Placement(transformation(
          extent={{-32,-76},{-4,-42}}, rotation=0)));
  Components.Segments.L_Leg l_Leg annotation (Placement(transformation(
          extent={{-24,-74},{18,-42}},rotation=0)));
  Components.Segments.R_Foot r_Foot annotation (Placement(
        transformation(extent={{-38,-84},{0,-58}},  rotation=0)));
  Components.Segments.L_Foot l_Foot annotation (Placement(
        transformation(extent={{-18,-84},{16,-56}}, rotation=0)));

  Components.Segments.L_Arm l_Arm
    annotation (Placement(transformation(extent={{-8,-32},{28,-4}},
                                                                  rotation=0)));
equation
  connect(head.bloodTherm, centralBlood.bloodTherm1) annotation (Line(
        points={{-9,7.68},{-9,-14.5},{-9,-14.5}},
                                            color={255,186,151},
      pattern=LinePattern.Dot));
  connect(back.bloodTherm, centralBlood.bloodTherm1) annotation (Line(
        points={{-2,-6.48},{-2,-14.5},{-9,-14.5}},
                                        color={255,186,151},
      pattern=LinePattern.Dot));
  connect(chest.bloodTherm, centralBlood.bloodTherm) annotation (Line(
        points={{-19,-5.92},{-19,-14.5},{-13,-14.5}},
                                             color={255,186,151},
      pattern=LinePattern.Dot));
  connect(l_Shoulder.bloodTherm, centralBlood.bloodTherm6) annotation (Line(
        points={{10,-8.64},{14,-8.64},{14,-16},{4,-16},{4,-17.1},{-6.5,-17.1}},
                                                      color={255,186,151},
      pattern=LinePattern.Dot));
  connect(r_Shoulder.bloodTherm, centralBlood.bloodTherm4) annotation (Line(
        points={{-30,-7.2},{-30,-17},{-15.5,-17}},
                                             color={255,186,151},
      pattern=LinePattern.Dot));
  connect(pelvis.bloodTherm, centralBlood.bloodTherm3) annotation (Line(
        points={{-11,-35.92},{-11,-23.5},{-9,-23.5}},
                                           color={255,186,151},
      pattern=LinePattern.Dot));
  connect(l_Foot.bloodTherm, centralBlood.bloodTherm3) annotation (Line(
        points={{-1,-73.92},{18,-73.92},{18,-23.5},{-9,-23.5}},
                                                 color={255,186,151},
      pattern=LinePattern.Dot));
  connect(r_Foot.bloodTherm, centralBlood.bloodTherm2) annotation (Line(
        points={{-19,-74.64},{-28,-74.64},{-28,-24},{-13,-24},{-13,-23.5}},
                                                              color={255,186,151},
      pattern=LinePattern.Dot));

  // Thermal sensation and comfort
  TSlo = {head.TSl,chest.TSl,back.TSl,pelvis.TSl,l_Shoulder.TSl,r_Shoulder.TSl,l_Arm.TSl,r_Arm.TSl,l_Hand.TSl,
      r_Hand.TSl,l_Thigh.TSl,r_Thigh.TSl,l_Leg.TSl,r_Leg.TSl,l_Foot.TSl,r_Foot.TSl};
  TClo = {head.TCl,chest.TCl,back.TCl,pelvis.TCl,l_Shoulder.TCl,r_Shoulder.TCl,l_Arm.TCl,r_Arm.TCl,l_Hand.TCl,
      r_Hand.TCl,l_Thigh.TCl,r_Thigh.TCl,l_Leg.TCl,r_Leg.TCl,l_Foot.TCl,r_Foot.TCl};

  TSo = min(max(NOODEL.Functions.TSo(TSlo), -3), 3);
  TCo = min(max(NOODEL.Functions.TCo(TClo), -3), 3);

  //Integrated warm and cold signal as control variables
  Cerr=head.core.twoThermCompartment.therm1.T-36.01;
  Cwarm=head.core.WARM;
  Ccold=head.core.COLD;

  WRMS = head.SKINR*head.skin.WARM+chest.SKINR*chest.skin.WARM+back.SKINR*back.skin.WARM
        +pelvis.SKINR*pelvis.skin.WARM+l_Shoulder.SKINR*l_Shoulder.skin.WARM+r_Shoulder.SKINR*r_Shoulder.skin.WARM
        +l_Arm.SKINR*l_Arm.skin.WARM+r_Arm.SKINR*r_Arm.skin.WARM+l_Thigh.SKINR*l_Thigh.skin.WARM
        +r_Thigh.SKINR*r_Thigh.skin.WARM+l_Leg.SKINR*l_Leg.skin.WARM +r_Leg.SKINR*r_Leg.skin.WARM
        +l_Foot.SKINR*l_Foot.skin.WARM+r_Foot.SKINR*r_Foot.skin.WARM+l_Hand.SKINR*l_Hand.skin.WARM
        +r_Hand.SKINR*r_Hand.skin.WARM;

  CLDS = head.SKINR*head.skin.COLD+chest.SKINR*chest.skin.COLD+back.SKINR*back.skin.COLD
         +pelvis.SKINR*pelvis.skin.COLD+l_Shoulder.SKINR*l_Shoulder.skin.COLD+r_Shoulder.SKINR*r_Shoulder.skin.COLD
         +l_Arm.SKINR*l_Arm.skin.COLD+r_Arm.SKINR*r_Arm.skin.COLD+l_Thigh.SKINR*l_Thigh.skin.COLD
         +r_Thigh.SKINR*r_Thigh.skin.COLD+l_Leg.SKINR*l_Leg.skin.COLD+r_Leg.SKINR*r_Leg.skin.COLD
         +l_Foot.SKINR*l_Foot.skin.COLD+r_Foot.SKINR*r_Foot.skin.COLD+l_Hand.SKINR*l_Hand.skin.COLD
         +r_Hand.SKINR*r_Hand.skin.COLD;

  // Evaporative heat transfer
  ESW_total = head.skin.ESW+chest.skin.ESW+back.skin.ESW+pelvis.skin.ESW+l_Shoulder.skin.ESW+r_Shoulder.skin.ESW+l_Arm.skin.ESW
            +r_Arm.skin.ESW+l_Hand.skin.ESW+r_Hand.skin.ESW+l_Thigh.skin.ESW+r_Thigh.skin.ESW+l_Leg.skin.ESW+r_Leg.skin.ESW
            +l_Foot.skin.ESW+r_Foot.skin.ESW;

  E_total_m2 = (head.skin.E+back.skin.E+chest.skin.E+pelvis.skin.E
          +l_Shoulder.skin.E+r_Shoulder.skin.E+l_Arm.skin.E
          +r_Arm.skin.E+l_Thigh.skin.E+r_Thigh.skin.E+l_Leg.skin.E
          +r_Leg.skin.E+r_Foot.skin.E+l_Foot.skin.E+l_Hand.skin.E
          +r_Hand.skin.E)/Stotal;

  //Signals for vasodilation and vasoconstriction
  ST = max(-parameters.CST*head.core.ERROR-parameters.SST*(WRMS-CLDS)+parameters.PST*head.core.COLD*CLDS,0);
  DL = max(parameters.CDL*head.core.ERROR+parameters.SDL*(WRMS-CLDS)+parameters.PDL*head.core.WARM*WRMS,0);

  // Setting boundary conditions
  for k in 1:16 loop
    connect(InputData.y[k], parameters.Tair[k]);
    connect(InputData.y[k+16], parameters.Trad[k]);
    connect(InputData.y[k+32], parameters.v[k]);
    connect(InputData.y[k+50], parameters.Icl[k]);
    connect(InputData.y[k+66], parameters.CSF[k]);
    connect(InputData.y[k+82], parameters.Tmt[k]);
    connect(InputData.y[k+98], parameters.CSR[k]);
    connect(InputData.y[k+114], parameters.ISolar[k]);
   end for;
   connect(InputData.y[49], parameters.rh);
   connect(InputData.y[50], parameters.met);
   connect(InputData.y[131], parameters.Position);

  parameters.Tair[1] = head.skin.Tair;
  parameters.Tair[2] = chest.skin.Tair;
  parameters.Tair[3] = back.skin.Tair;
  parameters.Tair[4] = pelvis.skin.Tair;
  parameters.Tair[5] = r_Shoulder.skin.Tair;
  parameters.Tair[6] = l_Shoulder.skin.Tair;
  parameters.Tair[7] = r_Arm.skin.Tair;
  parameters.Tair[8] = l_Arm.skin.Tair;
  parameters.Tair[9] = r_Hand.skin.Tair;
  parameters.Tair[10] = l_Hand.skin.Tair;
  parameters.Tair[11] = r_Thigh.skin.Tair;
  parameters.Tair[12] = l_Thigh.skin.Tair;
  parameters.Tair[13] = r_Leg.skin.Tair;
  parameters.Tair[14] = l_Leg.skin.Tair;
  parameters.Tair[15] = r_Foot.skin.Tair;
  parameters.Tair[16] = l_Foot.skin.Tair;

  parameters.Trad[1] = head.skin.Trad;
  parameters.Trad[2] = chest.skin.Trad;
  parameters.Trad[3] = back.skin.Trad;
  parameters.Trad[4] = pelvis.skin.Trad;
  parameters.Trad[5] = r_Shoulder.skin.Trad;
  parameters.Trad[6] = l_Shoulder.skin.Trad;
  parameters.Trad[7] = r_Arm.skin.Trad;
  parameters.Trad[8] = l_Arm.skin.Trad;
  parameters.Trad[9] = r_Hand.skin.Trad;
  parameters.Trad[10] = l_Hand.skin.Trad;
  parameters.Trad[11] = r_Thigh.skin.Trad;
  parameters.Trad[12] = l_Thigh.skin.Trad;
  parameters.Trad[13] = r_Leg.skin.Trad;
  parameters.Trad[14] = l_Leg.skin.Trad;
  parameters.Trad[15] = r_Foot.skin.Trad;
  parameters.Trad[16] = l_Foot.skin.Trad;

  parameters.v[1] = head.skin.v;
  parameters.v[2] = chest.skin.v;
  parameters.v[3] = back.skin.v;
  parameters.v[4] = pelvis.skin.v;
  parameters.v[5] = r_Shoulder.skin.v;
  parameters.v[6] = l_Shoulder.skin.v;
  parameters.v[7] = r_Arm.skin.v;
  parameters.v[8] = l_Arm.skin.v;
  parameters.v[9] = r_Hand.skin.v;
  parameters.v[10] = l_Hand.skin.v;
  parameters.v[11] = r_Thigh.skin.v;
  parameters.v[12] = l_Thigh.skin.v;
  parameters.v[13] = r_Leg.skin.v;
  parameters.v[14] = l_Leg.skin.v;
  parameters.v[15] = r_Foot.skin.v;
  parameters.v[16] = l_Foot.skin.v;

  head.skin.Icl = parameters.Icl[1];
  chest.skin.Icl = parameters.Icl[2];
  back.skin.Icl = parameters.Icl[3];
  pelvis.skin.Icl = parameters.Icl[4];
  r_Shoulder.skin.Icl = parameters.Icl[5];
  l_Shoulder.skin.Icl = parameters.Icl[6];
  r_Arm.skin.Icl = parameters.Icl[7];
  l_Arm.skin.Icl = parameters.Icl[8];
  r_Hand.skin.Icl = parameters.Icl[9];
  l_Hand.skin.Icl = parameters.Icl[10];
  r_Thigh.skin.Icl = parameters.Icl[11];
  l_Thigh.skin.Icl = parameters.Icl[12];
  r_Leg.skin.Icl = parameters.Icl[13];
  l_Leg.skin.Icl = parameters.Icl[14];
  r_Foot.skin.Icl = parameters.Icl[15];
  l_Foot.skin.Icl = parameters.Icl[16];

  head.skin.CSF = parameters.CSF[1];
  chest.skin.CSF = parameters.CSF[2];
  back.skin.CSF = parameters.CSF[3];
  pelvis.skin.CSF = parameters.CSF[4];
  r_Shoulder.skin.CSF = parameters.CSF[5];
  l_Shoulder.skin.CSF = parameters.CSF[6];
  r_Arm.skin.CSF = parameters.CSF[7];
  l_Arm.skin.CSF = parameters.CSF[8];
  r_Hand.skin.CSF = parameters.CSF[9];
  l_Hand.skin.CSF = parameters.CSF[10];
  r_Thigh.skin.CSF = parameters.CSF[11];
  l_Thigh.skin.CSF = parameters.CSF[12];
  r_Leg.skin.CSF = parameters.CSF[13];
  l_Leg.skin.CSF = parameters.CSF[14];
  r_Foot.skin.CSF = parameters.CSF[15];
  l_Foot.skin.CSF = parameters.CSF[16];

  head.skin.CSR = parameters.CSR[1];
  chest.skin.CSR = parameters.CSR[2];
  back.skin.CSR = parameters.CSR[3];
  pelvis.skin.CSR = parameters.CSR[4];
  r_Shoulder.skin.CSR = parameters.CSR[5];
  l_Shoulder.skin.CSR = parameters.CSR[6];
  r_Arm.skin.CSR = parameters.CSR[7];
  l_Arm.skin.CSR = parameters.CSR[8];
  r_Hand.skin.CSR = parameters.CSR[9];
  l_Hand.skin.CSR = parameters.CSR[10];
  r_Thigh.skin.CSR = parameters.CSR[11];
  l_Thigh.skin.CSR = parameters.CSR[12];
  r_Leg.skin.CSR = parameters.CSR[13];
  l_Leg.skin.CSR = parameters.CSR[14];
  r_Foot.skin.CSR = parameters.CSR[15];
  l_Foot.skin.CSR = parameters.CSR[16];

  head.skin.Tmt = parameters.Tmt[1];
  chest.skin.Tmt = parameters.Tmt[2];
  back.skin.Tmt = parameters.Tmt[3];
  pelvis.skin.Tmt = parameters.Tmt[4];
  r_Shoulder.skin.Tmt = parameters.Tmt[5];
  l_Shoulder.skin.Tmt = parameters.Tmt[6];
  r_Arm.skin.Tmt = parameters.Tmt[7];
  l_Arm.skin.Tmt = parameters.Tmt[8];
  r_Hand.skin.Tmt = parameters.Tmt[9];
  l_Hand.skin.Tmt = parameters.Tmt[10];
  r_Thigh.skin.Tmt = parameters.Tmt[11];
  l_Thigh.skin.Tmt = parameters.Tmt[12];
  r_Leg.skin.Tmt = parameters.Tmt[13];
  l_Leg.skin.Tmt = parameters.Tmt[14];
  r_Foot.skin.Tmt = parameters.Tmt[15];
  l_Foot.skin.Tmt = parameters.Tmt[16];

  head.skin.ISolar = parameters.ISolar[1];
  chest.skin.ISolar = parameters.ISolar[2];
  back.skin.ISolar = parameters.ISolar[3];
  pelvis.skin.ISolar = parameters.ISolar[4];
  r_Shoulder.skin.ISolar = parameters.ISolar[5];
  l_Shoulder.skin.ISolar = parameters.ISolar[6];
  r_Arm.skin.ISolar = parameters.ISolar[7];
  l_Arm.skin.ISolar = parameters.ISolar[8];
  r_Hand.skin.ISolar = parameters.ISolar[9];
  l_Hand.skin.ISolar = parameters.ISolar[10];
  r_Thigh.skin.ISolar = parameters.ISolar[11];
  l_Thigh.skin.ISolar = parameters.ISolar[12];
  r_Leg.skin.ISolar = parameters.ISolar[13];
  l_Leg.skin.ISolar = parameters.ISolar[14];
  r_Foot.skin.ISolar = parameters.ISolar[15];
  l_Foot.skin.ISolar = parameters.ISolar[16];

  PAIR = parameters.rh*NOODEL.Functions.Ps(parameters.TempEnv);
  met = parameters.met;

  // Results for thermal sensation and comfort
  TSl_head.TSl=head.TSl;
  TSl_neck.TSl=head.TSl;
  TSl_chest.TSl=chest.TSl;
  TSl_back.TSl=back.TSl;
  TSl_pelvis.TSl=pelvis.TSl;
  TSl_lshoulder.TSl=l_Shoulder.TSl;
  TSl_rshoulder.TSl=r_Shoulder.TSl;
  TSl_larm.TSl=l_Arm.TSl;
  TSl_rarm.TSl=r_Arm.TSl;
  TSl_lhand.TSl=l_Hand.TSl;
  TSl_rhand.TSl=r_Hand.TSl;
  TSl_lthigh.TSl=l_Thigh.TSl;
  TSl_rthigh.TSl=r_Thigh.TSl;
  TSl_lleg.TSl=l_Leg.TSl;
  TSl_rleg.TSl=r_Leg.TSl;
  TSl_lfoot.TSl=l_Foot.TSl;
  TSl_rfoot.TSl=r_Foot.TSl;
  TS_overall.TSl=TSo;

  TCl_head.TCl=head.TCl;
  TCl_neck.TCl=head.TCl;
  TCl_chest.TCl=chest.TCl;
  TCl_back.TCl=back.TCl;
  TCl_pelvis.TCl=pelvis.TCl;
  TCl_lshoulder.TCl=l_Shoulder.TCl;
  TCl_rshoulder.TCl=r_Shoulder.TCl;
  TCl_larm.TCl=l_Arm.TCl;
  TCl_rarm.TCl=r_Arm.TCl;
  TCl_lhand.TCl=l_Hand.TCl;
  TCl_rhand.TCl=r_Hand.TCl;
  TCl_lthigh.TCl=l_Thigh.TCl;
  TCl_rthigh.TCl=r_Thigh.TCl;
  TCl_lleg.TCl=l_Leg.TCl;
  TCl_rleg.TCl=r_Leg.TCl;
  TCl_lfoot.TCl=l_Foot.TCl;
  TCl_rfoot.TCl=r_Foot.TCl;
  TC_overall.TCl=TCo;

  connect(l_Thigh.bloodTherm, centralBlood.bloodTherm3) annotation (Line(
      points={{-6,-49.92},{2,-49.92},{2,-23.5},{-9,-23.5}},
      color={255,186,151},
      pattern=LinePattern.Dot));
  connect(r_Thigh.bloodTherm, centralBlood.bloodTherm2) annotation (Line(
      points={{-17,-51.04},{-22,-51.04},{-22,-26},{-13,-26},{-13,-23.5}},
      color={255,186,151}));
  connect(r_Leg.bloodTherm, centralBlood.bloodTherm2) annotation (Line(
      points={{-18,-63.76},{-24,-63.76},{-24,-26},{-13,-26},{-13,-23.5}},
      color={255,186,151},
      pattern=LinePattern.Dot));
  connect(l_Leg.bloodTherm, centralBlood.bloodTherm3) annotation (Line(
      points={{-3,-62.48},{2,-62.48},{2,-23.5},{-9,-23.5}},
      color={255,186,151},
      pattern=LinePattern.Dot));
  connect(l_Arm.bloodTherm, centralBlood.bloodTherm7) annotation (Line(
      points={{10,-21.92},{6,-21.92},{6,-22},{-6,-22},{-6,-21},{-6.5,-21}},
      color={255,186,151},
      pattern=LinePattern.Dot));
  connect(r_Hand.bloodTherm, centralBlood.bloodTherm2) annotation (Line(
      points={{-33,-31.2},{-30,-31.2},{-30,-24},{-13,-24},{-13,-23.5}},
      color={255,186,151},
      pattern=LinePattern.Dot));
  connect(r_Arm.bloodTherm, centralBlood.bloodTherm5) annotation (Line(
      points={{-32,-19.92},{-20,-19.92},{-20,-21},{-15.5,-21}},
      color={255,186,151},
      pattern=LinePattern.Dot));
  connect(l_Hand.bloodTherm, centralBlood.bloodTherm3) annotation (Line(
      points={{11,-33.92},{6,-33.92},{6,-23.5},{-9,-23.5}},
      color={255,186,151},
      pattern=LinePattern.Dot));
  annotation (Diagram(
      coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                      coordinateparameters(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
      graphics={
        Rectangle(
          extent={{-48,26},{32,-88}},
          lineColor={255,186,151},
          pattern=LinePattern.None,
          fillColor={213,213,213},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-48,100},{34,44}},
          lineColor={255,186,151},
          pattern=LinePattern.None,
          fillColor={213,213,213},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-28,-80},{14,-88}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={213,213,213},
          fillPattern=FillPattern.None,
          textString="Comfort model"),
        Text(
          extent={{-34,98},{8,90}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={213,213,213},
          fillPattern=FillPattern.None,
          textString="Boundary conditions"),
        Rectangle(
          extent={{-98,100},{-78,-94}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-37.5,-19.5},{37.5,19.5}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          textString="Local and overall thermal comfort",
          origin={-81.5,9.5},
          rotation=90),
        Rectangle(
          extent={{78,100},{98,-94}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-37.5,-19.5},{37.5,19.5}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          origin={82.5,7.5},
          rotation=90,
          textString="Local and overall thermal sensation"),
        Text(
          extent={{-46,62},{30,46}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={213,213,213},
          fillPattern=FillPattern.None,
          textString="order: head, chest, back, pelvis, rshoulder, lshoulder, rarm,
 larm, rhand, lhand, rthigh, lthigh, rleg, lleg, rfoot, lfoot",
          textStyle={TextStyle.Italic})}),
                       Icon(coordinateSystem(preserveAspectRatio=false, extent={
            {-100,-100},{100,100}}),
                            graphics={Bitmap(extent={{-60,-64},{62,72}},
          imageSource="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"
               + "nTr6JExSVKHfUu0C0+6Hdji3JhaaWj/sVS/5of3izMXGHqBoFp5eiF0WmAaX+wz9T//5P1X6CVd+l1yYfg1bGyPean3QX/CaH4rcttwu/U4AJk5rgQPfJIdC7xOd10I37y5hVGAqk7C1MRz6F/HddsdyDiZ3d6bLN1BUkfrWJaMykDezAbQq3bxrH5iCcOhf6AsR8YP2WixDCkxaCgBFFmktYIapT+0SjFTN6otfebEWN8m1Onw3tD0I04YRlxT9HUgje7cBUFSR1gLe//v3ZvZCmJCogyfq9pN++eWXYzMgh9uhSbuB/dFSACiNhYVcrc0Jo7K/wBRm66q2yWd6KrqTcvmJOv60Q7uByBp2aDegCHx/Un1M7JADyviBaGT60uh88Ed/9EfVmwGYi86dzNUyMIW11q9//euxpaO32tX/9Cm2lCkwAWX8QDQyPd/vw+xSqlHlc889V5vn/0Sdf2G6tBv4viLwgeQCU9W3lgLl50y5fcktx3UJn5X8rHuizj/50G6gy845ReD9c4YcUDqRw+LNMPWWCpVV3hEdeW71DkxB2DkXTlbOCFOOq343+kvdnQ8itWEAhTM/P7/nzR9p7UmE1Ifls8efrdUYPOFlkOycrByZnj3TXq9lb8s93oQACifSWkBg2lsje2FxYbFOz39OYEo+KwJvNBqxv7qg1cBggSnyJgRQOJGbu8Pe7/sPTGE1ocrNKhefyYXBZYFpNzrOzcXqmcL0o11zXbTfXA73eBMCKF5gip93aZapz5vjxcXF2g2AwNThhS+9EFua+54C8P5+gYKZp8wwAcUXZkccwjvQzXGq397CYv12QwtMmV+g//y1/xz7q1Wj02dg0oMJKAmH8Patkb3QZYZOYKqT0Gogsp1QAXhc6s3FobtAmdgpt7/AVMXjUASmfQq75iLOG5lkzzeXyHImQGHZKbe/wFTXm2OBKfZL1ErOkQLwU2qZcpZ6vPkAFJadcn2rff2SwLSHUAAeYVkuLdXELHICOEBxb47jm1TMMv3/7N1bbxR3nv/xGgSMtDbCBsUEhcSGDSFLYOzJ7Gzm8M/So4myirJSyM2ai5XieQTDPILpPIIhjyDNHb7CXIxGi4jSTianSULsgRg8MHabGBF3BG0LO1LMRf79NdWkDt/qYx1+VfV+SYh0kQT75+6qz+/0/TloATKva1UJTAFkAbiyILBAyzz6EBXavPkAgJmBqY/A1AZfe+RxwXevgelE1hPnoX/1ncL8GsO1wR8idsgBSBvtzDBapbksF6yMKjBl/mEpO+YUTMspNxV2yAFII3bKtcQgQdiBKYskBCo7vwhMyk2FCt8AUnmf929WOUGrBN/r83zAeleB6dT4uC+B79yxM5MN9NRTT3kvFfj8+G8qg3sITADSR+vsac842M/6nTtz+713O8LkG6KTs9iy6NAh3zqm3dqC5zzRbiasXwKQRkOPqbt7R2iZ4Od9Hqx8veK9VGFKrtU7pR4EOW+o9c0k4KYDAMZTppkYYQpoixwvv+g6MLkemFkfoqO8QPMPUJ7ntBG9jY0Nq/pNlYZAZJS1qgVa5YdxA9fz/sdMyfUUmLL+wNz3+D4+TE2+/z179nBLQWQWK4vW/PV5GgKRUdZgMsL0A1eV76wuv/Ha3NwMLTDlilLBenfOFwW6vneOREGUbt64aS0tLW2NNAEx3uNzv51eOw4sL4u+79696700Q2Bq58Okr88p5PQDJDeR3S1uNkAolm8vW+vr64/+GYhCQOVqRplYr+q0SmBqk1KYsZDTpqBMPmJze/n2o3++NneNBkEkpHK1MnJSoGXc9/s8lxQQBKY2sY5J/75lsWRey+QjWg8ePLBu3Ljx6LWMNLH4G1Fhp5xqoEUbZVLA9D8jTO1iHZN+E9m1axdvDkRiYXHBd21xYZGGQVyd4hFaxd9BzkVg+tYfmM5NTrKGqe3ApM/b5nFR4EiLmwwQTmD6pz8wyeJvGXkCwqbs/hqlVdzPuLxv8CEwdUCZv81jDySXW0wRr9XVVW2XytZWXxZ/Iwr9ff7RE45I4X5PYOqSMn+bq8CU5y2miNf8fHDdpevXrtNACF1AGKBHyP2ewISu+AITR6IgCjL1FkRGnqjJhChQ8RuiWvVtLlkiMPWervM2XFtocXMBeiZTblqVXSep/g2ETdnEMpLXttAOme/7l9yuYaoQmDqklM/P23DtQIubC9B7725F7d1dcF5QThIHesZOueb6+lj03bNWvUFkBqdWI3IrK74wVLZ/PXLnzh0aCqFTaspRiwk9BybXzUvbzcKHKZNcva08n1qN6Cj3E19gErKTDgiT0gncTQfZvt+zwYcpOT5MHRl2vuAMOYQtoJL3jBSN815cqTIth3Bpa3S0tTw5kcsq31v3Fv+Uf4XA1KGdO3ZqH6ZcjDJpNw2tPYCeApN/d8qaIyxNu/7dFY5JQciBSV+jM0LLREM2b/zlL39JQ221ngKTbyw8D8PjOa/TMdBmewBdq92reS85R5bKzj+Qs+WAsOW93l5cLl++bH3w1w+2puDL75atd955x5izIoPWZXcVmLTh8c0H+Vj4neM6HWMtbipAFDeqckB4ys3aSSR+j8/rwm/Xsy2sTT5ytNH7779vzc3Nua7LRo6L/3dxK0glTbm3zHQdmPJM2Uqfl2EWVy+LBYCIgrL7reL451yObCNelI/RhbXJ57333mtamFaCVJJ11gJGuSoEpm4+TP6UnZfehyswceguwhZQvftRYDo3OVn2/mFeRrYRH2Ud0wlaJRwShNopCfLp3z5N7JDtWs23LODRrFovgWnWlcqq+ViAqaTskZy8113BUCmxAPQWmL7d0G5U3pC0lMf7DhINTOo5muiMBCAJQoo/WJ7CtDI1f+XKlWTuQ+u++9CjzSa9BKZcjoUrW+mHs/49128WMiTtKqFA0UrE0LNbU/61SoubG9CTwQH13kZg6pEEIGWN4pv1TtGZ+u8T3s6QTM0lcWakch+aCSMwIT+9D9+0Y47PFEKEPdCgG1XQNXbKIWwyes65of6Q2MusggQf7yJvOyBJWJKRZBmAOe39F65evRr7N61MGRKYujX02BC9D4szhRBBz85fUkAbxXZd41gmREHZBZzHhd+u2ZNeZhXm5+e1y6ftoGTZoWnK8tRak8Xhca5lCthEUgk9MDE0nmmFFjcToGdK+Gk5wkRpAcRkhCbo3q1bt7yXpu2A5FX03hMWFhfi67Stqgu+y2EEprLzRc6HxnP1YaKkAKKghJ+WI0wiqd00yC5lFzCBqUsyaqPkg5L279rhxDXKtPxVfFXAldMDXJvbmJLrwv79+/P2YeJmgch1M8IU1CsE0D3tKKxu160uLPhGiGQzx1ST/8T1Z+2UIQiLUh9qhsCEngITNZgQtnZ3wzjXPABRUdZojtEmnQcmGf29efOmLxC1+ByXvRfiODJFzrNTOm1TBKbwUQkW6CUwtVeD6VFH0HUzpRYTog8Hu/PcSe7W/D/mW4YQ5XMvozprcX/Gby/f9l5a866zCi0w3b9/PzfvpBxW+z7Ra08DaBqYOqu3UqHFEDe7Hl0uA5OyDKUlGV2a+9JfSiBgsbeXq7O08vVK5N+wMh3n+zozvehbbsJRLAgN60ydDPW+gLAD03S7gSmOmynyJaB4ZZ6m5UZ6/R8ETHEV2/zPY90N2850XK+ByVgSkuTE4/Pnz1uXLl3igM7eelUjtAIMU6EJECWOfup93er1a9e9l2R0qdTmf152vpAwE+VzvJ3puNADkwnBROZMJSg1qopKMr148eJWgozwwzSSlw+OCCjeCQCZkfNq3z1NP8qIsTIqdKbd/15bvxjlbth2puN6Ckxxf0PteOedd7YO9/MOrcnr8rvlrTAVBmUN07AFoPsbrL/wLcPCSFTOq32Pur7xgc6+9YABiqkOvwZXDSSlRlIo2p2O6ykwad9QEgflOb/pVvUaJEzFsT0xYwrOF/39/bQIQqesgZyhVWCY3O6G7rRY8bW5a95LF85NTlY6/GvLLe4RoWh3Oi6MwOS6qSW1+FLWLH326Wdt/buff/Y5H/se7Nq1i0ZA0lz3nTgL2yE/crgbekuv61Zl4EQJN1Nd/K8iH2WW7NDudFzogSmpc51kqk35Ab0l73lJtt6vMaypOXpVQCKYrkPkcrwb2heYOlm3GtJ0XCwCpuNKsQQm+YvjnpYLqvVQ/1W0q4lOWJ4iWLMzs5w/1T5Xr4oq3wDyQNncM0artKadx2Zqhf6Ff/qObVlqUjA33MAktIq9UQqoJNoIS42jFIreYHflypWu/06tRod29g4AIJ2UKbndtEpzAVNcJRO/VhncUabzm36tPQUmO4wkdkxBk0qiJc/XKdsZXQvUb926FWbPI8vGcvy9IybKjYtF30DKBEzHlU38Wufn1aU50QUm7cZWu1eL9YfTQSVR13VZ8xRmbaYM292i1wVEYbWTP0tyhy6yKcczCa5Ocic75Ja/8j1Tl+yz4YyjDJq03MkXemCKc8eKMlcaWEnU3iboWsukbCfsReYWR+fs7CSkhHYDjnspALIvx6PpvrXJ7QiYjjtj4jcogyXd7OQLIzBNeRs3rpEbJZxNdfK1yg+328XfymGEWVwQONZOrwvoBaNDSBE6kU1CSKtnrikCai+VIg9Mdm9vqcUXE8lNVkmIZVPDHb0uIOCzrIwONdup0rjBEboQtZx0jFtqZ2BBdp97L3VRrDKW7+XGjRtdBbuwzpLzjdxELeAYlnKLcDflDXfKD7ktyrxugdsLEJsZAhMQCV/IaTWwICdoKAMYJRO/uYA6jG1NHYYVmFwNE8fITcD6pXZqPRSdL+SHvFhZ7PjvH9yTi6kpVwhUzlYCekbYQYpkfkrOHhVyjSQo9YrcIeS6L4SshRCYImnrmzduei/NtrswfXtIDTxzanxcRm4eHUIr03IHnjgQ2Q+1VvONMJXb/FpL9a9V0uSj3V/Xr123Do4c7Ojv7+vr8146kfUP0nfffWdd/fKq65pM0bFzDt2SCsJKYJpu4z91dY7kWKahoSEaFKEE+MZ7UlnwnJcpOXmePjqAV9YLy8CC9pxcXV1VjxcJoVilq8Pe6Xl2GvkelJGwthembw+xgWW66/eNF9KAL7zwQmQ/zR7rtkgD/bHxQo5LkR96JycyK4Ep8+SNNvMF5XFgBHkjvua8H3CmHBCaM87nuZDD62UQxLmOVQKIXFcUe/nL7fPsRp3XDjzZ+wCMsgRnqZ3F3g3bQmxg118a5bSchJuARNzJm8FlYWGho69h546d2g85a72PAvcNJICz4oAE2dNyb3qf6ZcuXdp6rsuapcuXL1sf/PUDbRRuOoTF3r5nTyfn2WnCWGe1LcQGjm233Ep1Jejvb/drlRuy61DeTit/B4xGseUU6F07n2VCFZJwIkffq++EDJmNKb9bti7+30Vrbm5O+2/k358I4e8+6Xwh62d7ndW58nffcWhrVod1oraH3MC+abnnn38+9K3oyhbH6S6/1kdD+pI8O52W48G1ZcRyrF0DDHpvAt2Qjn8l740gAwunxscl/HzR5n8iYanQ69olezruNee1J596sqfvJeDcuI7XWYUdmErOwNSYlut0QXVMJDC97bwgX2sngam/v987xFewDD03p8sPzGnunYiKXUlem8autPHelM/Zj2hFINJngGzo+kP9H/8UR1hy5AiXXjeQXb16Vbtc7PT/sz2CxnXtlutmB1qM6fmCM8l+desr69hzx9r+f+zatUubEwXQ5mcwSx0MIKOf0zP1Z+WqPSBQcDzf1+zPb9k+4D6MTpR00l3TnjId18vMT0ChyrPdrLPaHkH7nnGmUZnzlOEwQ3eVuablDP9aAQBIIjSVLHvkx54yGwj7UF1701TReU1KCfzyl7/s6f8bUKiy1M3/K4rANGV5hu/m5+e31jIZyNe7lWm5I88c4RMCAMisekCRhdXya8T5/G41WhTFcSd2WJLn8W7n9dGx0Z7XFQcUqix38//aFvY3bjdmTzvQYkzN8rV2VNHUm349RvgYAgAMD0vy7Dtf//WG9XAKrPHrT/JndpiK62tRw5Kc49fr4IUMgPRSqDLywGQrOV/IF2zwIbeur7UxLddlYGKLHQDA5LBUtJrvbJY/O1//98pR1xYMCkvybP3FL37R8/9fKW0k666muv3/RRKY7ENuXaeJLy4smvr+mdJSaTuU5MpWZwCAqWFJOvXt7n6WEacv7KPEYg1LL7/8cs9riQMWe/d0ZMu2CH82JecLqcmk1E9KXK/TcgAApMSYN6AMDw9bYz8da3ZW2+/r4aYUVmCT6T77/xcYlsKoh7iwqD7Hewp/2yP8wUiD/N77DRi6oFq+VtfOPimj3qoUu/x7AACkRMEbUF588cWtf5Zns+woCzgv9I16yJHfT3c6QlP/7+TvHLEeLjB/LejfCzMsiWtz17yXZnvd2RdZYLJrMsnIzajzG0hDYBIyhdgsMElVcOUMnTKfRwBAGkiNowY5kUPqEErdRDknTmaFvKFJQk/9uS7LWOSXMziNWO5NT/LPY5bnAN24wpIcChzmYu/IA5PjC3xUTVu+AflGIihkOdJjuJMilmftN8QWmfs8duxY4Dzq559/rv1/CEwAgNSSZ56MOkmIUdYA7bafk2+E9ffJiRmFQiHUY8lmZ2a9l3pa7N0Q5RqmRrEr1+JvqfzdK6Vhh0NYze9Ln++995667koWhSvn0lzgowYASAtlluSRF154wTp8+HAkf6+EpKNHj1r//d//bZ08eTLUsBQ0uhTGsS3bYviZuIJIY31QL/YN7dMuF3oMdzK3Oe39Wi9duuQKTVJy4MMPPtT+F5y7BgAwWcX7jGtWRkdCU+E3hWYLwtsmdZWcIUmKWUdx2H3A6FIoO/22x/ADki/0j84L89fnWy6obkbmWmVlv2eOdSKERpH//oT3DXX+/PmtH7a8aWRkSUnlb0ZR/TRJ9kK9AvcX40iwX83yN9jp1Lb9XgViCx0pvt/7PltyMK0EoyBy8O3//M//bM2sSF0jee5qI1PyjHQNbDy+b2t6b3BgMJJgpJHBmKhGl8SPvv/++zgeviXLM+f5+uuv91RnQVbzf/q3T72XB3ttmPrXKsHr7U4CrRXeKc0mBaaiN+gCMViqf5ZG2nyPlr0dHCAGcnDrRIrv7b7PjYz6xBVqovTOO+94l8vI6NJIWM/nbTF9H0Ut1fZCUm87f08XvVsJd7+xPGuvmpjIWlgCkuy9R/TvAmEZSfnX73tOlstlI+skduLql1e1tcVnwnw+xxKYtPPlZPV9Lz8gGZ2ShWMevw9jeN6eEii0EZr+EPaJzQbhmBdkKVwB+OH55noeyzTWxx9/nNrvSabiAupHhVqlfHuM35N84a6iVTKtJnUfuvWrX//Kuvh/F72Xp+qhqechODsIDTjW8hTsnoVsTZQ3XDnjI0uuXYcSTnft2sXdJmFKD4oQBNCZ7NSE/Vl7VGlb1ibJOt1m65lMJIvWy++WtT96M+xndGyBSVKtt5DlzRs3ewpMsnBcVt3Pzc05L8sboGQ9rCoaVhovd/rfSWizA9ZMFoLV04ef7ulnBWiUNQedBCbfv/u///u/NCpCH73wdMxH0/492bUH5Rn5rvO6zPwM7RuKolZiZKT8j7II/UL9eyyG/Xdti/l7cw2PyTBguwfdBjl+/Lg2NfdaWGffdBqSpApq/ZespF+034w1+9TntJUdYEoOpqvQBEBPgwFveq9/8NcPtmoZpcEnn3yiHVEmAzMTUfx922L+AUmIca0LkiNIeiElBmRqTvFGXKHJPlCwaIck7awc2ZHwJ3sHXlq4elFZ2EEB8zQrnAeYSu75GQlN8tw6q4UmWURtelhSKpFLvohsI9a2BL5PV4iRedNmhbPaIVNzv/5/v04kNNkjR9LTbWcLfjGtH7QwCpcBXkrvcIZWgUmkjpBiLCvfn10iwReaZBH1X/7yl61zU00j65+VsCROR7kRK/HAJMIY/pM51yahacZeUxR2WJLvRQ7t3d3mfzJsRTRUCGREJ3dn342x11MEAC+Zxcg6OzRNax2aixcvbgUUU0heUGowij/Ys1iR2ZbAD0Zucq7a5bL4OwxNQpNMLy3awel0GOFJK8bZIBVPpZy8FOdU1leNWADCuJdQ/wwIz0ktNMm0uQQU2aAha46TrNckYUmmCxVSTPRM1H//9oS+b/nGHlXTlsXf0hBhrMxv/D8CGlWCk4wI/cnesTfj/NXODdguM3DGUnZKSDj695//u6uo5lNPPeXdxWf8UG5W5udhtrQXygMy2AEp2MtMipZn5kR2szZ2tMqzTgYGZEddHEefyMixrHcOmIaLrfJ6UoFpyg4dj34gcmBeWFsZW4QmZ3iSX284goL8JgfUVQL+mxHr4bSaz8//4+fWkWeO+K7v/HEq1/74Ql0vZ/8BmtpqTbtpl2kZINHgdEZ2e1sPl8+oRw/JIIeEl0aAkTWuEqAG9wxaQ0NDVt+/9PV09JmQtc0yonVt7pp2Ptyj6BDnMTXbE/qBSA0I16G80iCSIsN6MEtokrnnK3+/oi0sbWY4KBQFpoufjqlhCUDkXLXdqtUq4R5xGMl4aJJBg8Zo059a/fsybScbuOSXk4QoGY3q6+9rO0hJSJLRJO//K+CzX4izXbYn+DORwCQ/jEejTBJufvvb34b2F8jUmPxqJNXlr5ZDrZQsqXp0bLRpWNpY3+DWAkSHdUyInDz4Pc+OkTx83/ZoU9l+Vhc6HUyI8GSCRA69357gD8I3yiSNG+YoU4MkWgk18kvWTUh4khC18vXK1uhTp7VgJCgNDw9bx44da5qW5e9SUjLbpgGLGkxASkKTPLMm5J/t9a0Fx684q55LjaWt5TxJneG6PeGfRcny1C8Ke5TJS6bpGmucGkd9SHja+PbhSJAM6Tcji9uci7qbuXLlivZQKPMRBCytvss0rQIYHZ5W7dAy1bjmOW9V1r/uDvmvnbazwlTSO2O3J9z4lXpjS8GsRwuvoxplakZGiRojRWH9vfIw8OyOE0v173mKjx0QmorlWJgqo8aceQjE+hwvOwcC7FGoMfvXiOOfOwlSa3ZIOmOvpzLCdgO+hqLlqWckJw+/+uqrPa+yT4pMxZXLZe2PJlLyLbh2ySm1pACTAhMAcwLUqh2gXA9BR5BqN4QZZ7sBjesbZZJpLDmB+JVXXknlG0a+dmUb5HSKtky7imrs2rWLuwAAIIwglVrbDPk6ZAW+a3W0LMaWw/XSRr5mZWeADC+e5CMD/EDZQcqONxhJGWUv0Cr5Y0RgspPnSTtYPCJFscI4Zy7OsBRQibTAMQ6AmzIKyw5SGEnqCAGmjDA1ti6e9l6Xat1SBsB0V7+8GhSWfpfUFkggB1yfrQjrvgAgMJnDPmn4Le/1Dz/4UNuCbARZ4P3+++9bM1+omehs1KcnAznHyC2A/AUmOzTJKNOs85osAr948aJxoUlGvs6fPx9Uwv1snGfcAACAHAUmW0ELTbJV34QTzhujSlL+IKBaMWEJaEE545HRIgAEpk7YC6QlNLmGbmSR6KVLl7Yqc8dNRrfm/zG/tbD7z3/+c7ODAd/MQFgacb6Qo2CAsCmdjVDW+pnQqQKQPdtN/cLss+Zk51zZclQIlV6pTIPJWW4Hnjzw6JiTsEm1cTkmpXavtrWQtI1zryRBnczIAm9XYBrcM8gnBabeJ8r1+4TrWm21FutJAQAITCbcDGfsc2pcoWkrnSwtbf369G+fWk8//bR16NChrXPeOtU4R07CkdSFkVGsLnbayEL1IqUDAAAgMCUZmibq/3he+3MZ+ZEz2+TX3r17rSeferJ1SOo+GHnJqNJEiip4A0aQEVxFhZaBiZRjusZoFQKTqaFpqh6aXrce1mk6EfTvyXSdspA0bHJysky7SUgqM6oEhPY57zYwScdl+FEYq1aZkkPUgWk3rUJgMjo01X+T4DRiB6eTzptkRNbsYDRjh6Mybxmgd22sCexEJYZ7AQACUyp7oRKYTtuLwifqv14LKRzNOH9RoRuIhlJTbTqs/7dyRh0A5C8wecJTY9RpwA5OnRxwO2P3TBvhiKk1IJ3KlmOqXjmjDgDyHZgcwUnCzhn7FwDDSbkOjwqtAsBk22gCAHFT1jD1Ephc/y0H8AIgMCEuAzQBYg5MvajQogAITEjCqPPF0BBbtBEupfxHqBsskjg+CQCBCQCi1vWmC63ch1TvBwACE4D0JqPV1VADEwAQmABkzuYD//qlEGqeLTlfSLVvICx9/+Kr9G3Z55yCwAQA0VDCzFoI/9uK8wXFKxFqYPIfjQICEwBES6nBFMaCb9f/4969ezQ0AAITgPRSdsiVww5MMRzCDYDABADRePDggXZ0SRgjTL7QVf2GdUwACEwAUqi2Wmsr7HTKPpTbtRaqVqvR4AAITADSR1nwvRTiwdeukarVGpUKABCYAKRQRAu+G8rOF5wpB4DABCCVlBATZmBy/b9krZSsmQIAAhNCd2p8fMx7TSvaBnRKzndTDt0tRxWYRMCaKQAgMKFnA77ARNE2hCAgvIQ2wqQt/KbiNwACE4BUqa5EuuBbDWDKmikAIDABMNetW7e8l8oR/DWu/+fS0hINj6gM0AQEJgAI1erqqlawciqCv8r3/1y+vcwPAD3bv3+/99IYrUJgAoBQrVRXtMvlsP+ec5OTMiXnGla6vXybHwAAAhMA8y1/5RvlmY5g/ZIaxKjHBIDABMB4UgtJCS1TEf6Vrv+3TAXKlCAAEJgAGCtgDVFkgenc5KTv/x0wJQgABCYAZggoJ1CJ+K+94Hyx8M8FfhAACEwAzKVs7Z+K4a8tO1/cvXuXY1IAEJgAmKn6TVU7DiWOwER5AQAEJgDpoOyOWzs3OVmO+u+1p/xmW3wtAEBgApC8mKp7B3H9XbJTj2k5AAQmAEaR6biYqnsHKTlfyNQg03IACEwIC+cjIRSLC4veS2txBiat6jfTcgAITAiL63wk5fwkoC3a7rgIq3sHKXm/po2NDX44AAhM6JnrgXb//n1aBB1brCxqu+NKCXwpvr+TaTkABCaEYcb5QlmDArSkTH0txbE7zkvbLXdt7ho/IAAEJgDJkimvhIpVBjnj7QRwthwAAhOARAVMeZ1J8EvyhbWFBY5KAUBgApAg5dy22RjOjgtkLzQ/67x28+ZNflAACEwAkiFTXXJum8cZA7401ygTNZkAEJgAJCZgqmsq6a/r3OSkfA1rzmtKnSgAIDABiJ4y1XUhgdpLQUrOF7IwnaNSABCYAMRKprgMqb3UVmBqfM0AQGACEJvby7e9l9bsqTAj2EeluGoyXb92nR8cAAITgPgotZdKBn6Zrq9JFqgzLQeAwAQgFrI7TpmOmzLwS/V9TUzLASAwAYiFsjtuLYmjUFrRjkqprlT5AaIlpVxGhVYhMAFAR1ZWVryXygZ/ua6vTZlKBHyUEVQCE4EJANonZ8cpve8pg79kXxHL6jeMMgEgMKEzM94LPEzQTMD7o2zq12tPFbqKWC5/xTomAAQmdPYw4Rh3dEQJG4meHdcmV6BTphQBgMAEIDx37tzxXppKwZft+hplSlGmFgGAwAQgdDIdl5JyAi2/RqaeARCYAERCmY5bsytqG82eep5t8b0AAIEJQO9u3brlvTSVoi/f9bUqU4sAQGAC0BtZ87O+vu69XE5rYJKpRap+AyAwAQhVQLhIzQiTPXXoKi9A1W8ABCYAoVLCxWwKy1K4Ap4yxQgEbQiYoWUITADQknKkSCmF30bZ+UKmGCkvgHZQs47ABAjXNAUPELTZ4y6n8FuhvAAAAhO6NkNgQtPAVPWFilSUEwgYJaC8AAACE4DwfXXrK++lcoq/HdfXTnkBAAQmAD178ODB1lEiGQpMvvICq6ssTwFAYALQg5XqSsvQkSbnJifLbX6PAAhMANAepZzAUj10VFL+bU23+B4BEJgAoH0rK77Rl3IGvi3X96CUTABAYAKA9siOyYytX2qgvAAAAhOAcASEiKm0f1/qMSlVAhMeko0AAIEJQPuBKRvHoQQpO1+sfM3Cbzyk7JqcplUITAAQSKlRVM7Qt1f2fq9SQgEACEwIUnG+qN2r0SLYWr8kZ63lJTAJygsAIDCh7cDE/D3E8u3ltkJGWtnrmFzb4ygvAIDABKAjSniYzuCJ7a4AqJRQAEBgAgCdrOVRahOVM/itur4nKaHA4dMACEwA2hIwHTeVwW91qs3vHQCBCQA8oeErX2hYstf8ZIo9xXjBeW3hnwu8AQAQmAA0FzAdN5Xhb9n1vTEtB4DABKClgCmpUl4CU5M2AEBgAgA7LORkOq6BaTl4baz7RhhXaRUCEwA8ksPpOPV7ZFou35SCrTO0CoEJAB7J4XRcYChkWg4gMAFNe0/K+WHIS2DK2XRcA9NyAAhMaAfz88jzdJz6vTItBxCYAMAnx9NxgeGQaTmAwAQA7nCQ0+m4BqblABCYADTFdJz+PTMtBxCYAOARpuOCQyLTcgCBCQC2VFeq3ku5mo5rYFoOAIEJQCCllMRUjpvDNy0nU5YACEyADw+I/JA1Okpl43KOm8T3va9UV3ij5LsDUaFVCEyA8E291FZrtEpOBKzRyW1gOjc5KQ9H1wp4ZcoS+UJgIjABj9ZtIKeUMDDNe8IdGFdWGGECCEwAck2ZfijTKu42YB0TQGACVJubmzRCDqyurmo/awIT65hyq/qNOv06Q8sQmICGWe+DFNmnhYBzk5O5D0ysY4Ln/cANkcAE/JCRaIIc9qaV9Uu0yiOu4Hjr1i1aBCAwAcgj1i815arHJKUXOCYFIDABLpvfsYYp62SthrJ+aYqWCQ6PAetbkKXPRdX3M56lVQhMQODDoVajDlMOHwxreTwOJYi9bsX1sGQdUy6xXIHABCDPVr5eaRqa4W8TZQoTAIEJQJaxfqnzwMQ6JoDABLhQhynbAtbiEJjaaBPWMWWbMvLKNDWBCQh+MEhlY2TX8le+8+NYv6TQ1jEpbYdsYw0TgQlAbnvR/rPR2B0XzNU2rGMCCEwAckDW4CgjiGVaJpCrbWS6mmm57GI5AghM6BiHjWYT65c6Yx8Vs+a8xrRcdimdCaaqCUyA76HgUlulFlMWKQ/7WfvsNARzfT6UKU1kF2uYCEwA8ohyAl1xrWOSUQhGYAECE4CM4jiUrvlC5fJtpuUAAhOAbAYm/TiUMi3TnD1lyTEpOehQKCq0DIEJQM58desr7yXCUvtcbbW0tESL5Ccsg8AEuLh70FV60Fkia26UHUBMx7XP1VYytbm6ynpggMCEPOLun2EBa27KtEx71PICrGMCCEwAskVZc0M5gc65AqYyxQmAwAQgzZQ1N2VapWOUFwAITACyStbaUE4gFL6QybQcQGACkBHKQ51yAl2wpzBdQ3WUFwAITAAyonbPd8wNYal7rpG5e/fu0SIZIQdTezsWtAqBCUCOcKBoqMot2hbZCUx8TghMgMpVVkAZlUAKyaLk9fX1pg99dMT3EA2oEA2AwIQ8PAiURcJIodqqGnwrtEx3tFIMtRqdC4DABCDdgcn/MF+j/lLPpp0vNtY3aBGAwAQgzVZrvgLurMvo3UyLUAqAwAQgTZT1SwSm3lWcL+7cuUOLAAQmAGmmPMwJTL3ztaGywwoAgQlAGkiF73Ye9uiMVvQzYHE9UmTzOza6gMAE5JL2EK8/7AlM4VhqI5wCIDABMJ0yTTRLq4TGvfCbumWpt/PHO2kEEJjQlgGaIFtWvl5p+pBHeIGJit8AgQn5MeZ8se/xfbRIyikP8QqtEpqy84XsRpSq6gAITABSRB7eSrX2Mi0TGl/4ZOF3ug0M+AbZT9AqBCYAGceRKNHSqqVTWiDddu5kDRMITGizg0UTZId2FiBHooRumsAEEJiQP6POF0NDQ7RIiinb3NkhF0EzO1+wUy57To2P05EkMAHIMuVAWAoFhc+1U04b1UN6DA4MapfHaBkCE4AMU86QK9MqoXOFUEoLpNuOHTtoBBCY0Nyp8fERWiFblIc3I0zhY4QJIDAhZ3yBaegx1jClmfLwpmhl+CreC9VvqrRKtrCGicAEIKsCzjVjhClk2q5DRpnSbe/evd5LrGEiMAHIqs0HakkBRpiiMdtGWEVKUIsJBCa0MkITZEe16psWWqJVIuNKSJvfMcIEEJiQm8C0f/9+WiTFlId2hVaJjGvkrlajFlPGsIaJwAQgq5SHNtNx0XGNMN2/f58WSbHBQV8tJtYwEZgAZJWy8JiFNdEpO18o9a+QIjt/zBomEJjQ3IjrpsHCx1RTajAxwhQdXxhl4TdAYEJOAtPgnkFaJKUCDoDlCR4RbfehtksRAIEJgEmB6dsN7aFepmUi5dqFqOxSBEBgAmAS5WG9RqtEruJ8QWkBgMAEwHDKw5r1S9GjtEBGKAfwjtAqBCYAGURJgURUnC+URfdICaWswDCtQmACkEHKw5oF39FzhVLOkwMITAAMpzysy7RK5CreC9VvWPgNEJgAGCngIV2hZaJ1bnLS18YB5R0AEJgAJE17SGsPc0RimsAEEJgApDMwzdIqsXGtFavdY6ccQGACYCTlIV2hVWLjWvjNmXIAgQmAoZSHNCUFEgpMlBYACEwADKU8pCu0Smx85RtYxwQQmAAYJuDhTGCKiXZen3auHwACE4AE1VZrbT3EESkO4QUITABMtrq62vThjVhUXCGWnXIAgQmAWVa+XvFeYsF3/MrOFyz8BghMyJ4BmiDdlIczgSl+vtICDx48oFUAAhMyZNT5YmhoiBZJEVnwzRlyRvC1uba2DACBCUACWPBthnqby0IyFn4DBCYAJlIWfHMkSnJc03Is/E6/U+PjLFkgMAHIAhZ8mxuY7ty5Q4ukyNBj6nKEMVqGwAQgA5SHMoEpOWXnC1lbRsVvgMAEIGHKdByBKVm+tmfhN0BgApAwFnybRVv4HRBqARCYAMQWmPyLilnwnTzXKJOyxgwAgQlArIGpVmv6sEbygYmK3wCBCUDCWPBtpLLzBQu/AQITMuDU+PiI99rOHTtpmBQIWBtTpmWSpa0hY+E3QGBC+vkC08AAddrSIGDBNyNMZnCtJauuUPEbIDABSITyEJ6mVYzhrvhdY4QJIDAh7SreC2yDTod79+41fUjDnMBExW+AwISUOzc56QtMmw82aRjDPXjwQNt9VaZljOH7WVS/YVoOIDAhU2RXD8wWsIiYESZzOiL+it9MyxkvYHSdIXcCE/DIbBs3DRikWvWNVixpo4VIlGtNGQu/U9BZVEbX2UhBYALoQaWYUj2am7p5ys4XFLBMQWBidB0EJnQSmJTjNmAY1i+lgivErq+vU8DS9Buhf3Sdo4YITEDwjZ1elvk3deVnxAiTeXwhlgKW6e5MgsAEWASm9Fip+g9z1apLI1n1n4k8bJec11jHZLaN9Q0CEwhMaIrDQtPU5a357uEUrDSXK8iyU85sMm3a7N4IAhNALypFOHA3vZ0RClgCBCZkLDCxONVMUrBS6QWXaRlj+X42FLBMVWekQqsQmIBHtDojG98SmEy0fHtZu8wIU4o+W8tfLdMw6UFgIjABzTHCZKbr1657L81SsNJ4F5wvbt26RYsYiIK9IDChXVQlTkGIVRbkl2gZ4005X8iUKg9n82glH9h9SmACNCxONVzAdNwULWO2+kNXQu2a89rCwgINYxilk8juUwIToCp7e8GywBjmWPin7yHLdFx6uIIt03LmYfcpCEzoKjAJrUAiksF0XLYCk3RI2C1nDnafgsCEtlGV2GxMx6X+8yU/K9e03OLCIg1jiIDOIYGJwAQEct0gqEpsDqbjMsEVcJeWlmgRQyidwyW7EwkCE6Bi4beBAqbjztAy6Q5McmZjwMghYqZ0Dsu0CoEJaMZ3k2CdRfIWK4stH74wnzYtd3v5Ng1jABZ8g8CETm/oM94berVKYEra3Jdz3ksXmC5ILd+0HLtRkxXQKSzTMgQmoBVXz6p2j3VMSZLRJZm6afbQRaqUnC/kZzv/j3laJcnA5O8UrmlH2oDABDTtWbGOKVmzM7PeS0t2IUSkkF052vVDlRFERpmSo3QKCUsgMKHzwCQ9YM6VS4YsCFZqw7DYO/3OeD9jLP5OjtIpLNMqIDCh3R6wCwu/kzF/3TdVI+vLSrRM6j9j8jN01RRQRhIRA+kMKlPeBCYQmNC2We9NBfGSkKr0fM+w2Dszis4XMpIYsBsSEX/O2uk0gsAEBOGhnDBldEmUaJnM8JUYUIqTImJKZ5ChPhCYgDTdxJUq0Gep7J0d9kihay2TjCgy/U1nEQQmAG26evWqdrlIy2SObwH/lb9foVUAAhOAVmR7+Y0bN7yXpxldyh57lOms85qMMrFmECAwAWghoIhhkZbJLN/PNmCEEQCBCYCQkQXlGJRpdu1klz1yeMF5TUYYGWUCCEwAAsjIglITpkTLZJ5vLdPHH39MqwAEJgBesjtKWbs0yzEo2WePIE47r8laJqp/AwQmAB6ff/a5dvk0LZMbE94Ln336GWfMAQQmAA2y0Pvu3bvey2dZu5Qf9lqmN53XpPp3wCYAAAQmIF9kBEE5R0wqQDO6lD+ylslVsXTmixkWgAMEJgCXL1/WFnoXOTMuf+yfedF7nQXgAIEJyLUmC73P0Dq5DU0liwXgAIEJwA9Y6I0AvveALAAHQGCCeQZogmix0BtB6u+BmfpvbzmvyQLwq19SATxsfX193ksnaBUQmNCJUVd6GiA/hYmF3mhD0X5PPCJV4FkAHnlgsk6Nj4/RMiAwoSXtZtHf10/DhEhGl5SF3mdY6I0G+73gCtDynuGcuXANPTakXR6hZUBgQjt8gYkRpvDI6JJyXtxS/QFZpHXgCU0ly7MAnHPmwrd3796W90AQmICWvSvlZoIeLCwuqGUEaBkE8L03FiuLtEqI+vv7CUwgMKErBeeLPXv20CIhujZ3zXtpifPiEEQ7Z05GKDkyJTyDewYJTCAwoSsjzhd9/X20SEhkZEB2O7UaQQA8XHW5ZISSI1PCoyw5GKZV8KPvv/+eVkCgU+PjcueoOa8dPnyY0BSSmzduegPT2rnJSRaIoZ3PZsX5IN+5cyfT5SGRAKqU+PgNJT7ybTtNgBZ8Q9FKJWpENHIANFGs/3rb+ZCXCuCI9F5IYMoxpuTQcWBCZNYITGiXvc5tiZaIzQhNQGACuEmYgbpL6Pg9QxPQeUQ8mJJDO6ZpgliUaAJ08Z5hzVs86MzkHIu+AQAACEwAAAAEJgAAAAITAAAAgQkAAIDABAAAQGACAAAgMAEAABCYAAAAQGACAAAgMAEAABCYAAAACEwwwKnx8UL9t0LGvi2Tv58z5yYnp3jnocfPbaX+2zAtEZuD9c9thWbIj+00ARQT9V9v0AyxOUkTIATF+q+3aYbYjNR/EZhyZBtNAMUYTRCbs/Ve6irNgF7V30el+m9rtERsCjQBgQk5dmp8XMLSKC0R66gAEJYzNEFsJmiCfGFKDl6nvRf279+f+m9q3+P7Ev37N9Y3rBs3bngvn2UNBCIITPIZ3t240N/fb/3q17+iZXq0/NWyNTc357w0LOs965/hMq1DYELO1D/8I5Zn7dLhw4etF154gcbp0SeffKJdLtEyCJNM79Y/xxKa/ti4tr6+vvX70GNDNFAPBgcGrZs3b1qbm5vOy0WLqbncYEoOTr7RpYOHDtIqPXrw4IG1tLTkvTxNzxQR8QXx+evztEqPduzYYT399NPeyyfsZQwgMCEv6h/6AcszJy9TcfRKezf/j3lvr7TRMwVCZ0/znnVek8C+sbFB4/ToyJEjbXU0QWBCtrnWPWzdHJ49QquEYO7LOe+lWUaXEDFfIL969Sqt0qO+vr6tZQoeb9jLGUBgQk5MOF/IQtEDTxygVXq0fHtZG11iJxMiZY8yXXBeU6aF0QVGmQhMyLF670jCkqtC8OgYlQXCcHv5tvfSkl0vB4iaK5hLcJcAj94MDAxoO4cn7GUNIDAh44rOFzt37rQOjrDYu1ey2FspJcARKIiFPe271CLAowvHf3Lce0mWMzDKRGBCltnnxrlGl44+d5SGCUFAb75EyyBGroAuAV6CPHojm2Fk2YLHaUaZCEzItqLzhYwuHXmGxd6hBKavfIFJpuNmaBnEqNRmkEeHlGULjDIRmJBV9tqlE85rMrok9UbQm4DaS0zHIVZ2QF9qEeTRBVm2wCgTgQn5UXS+YHQpPAG9eHbHIQmuoC5Bnmm5cDDKRGBCDmg74xhdCs/1a9e9l2Y5Nw4JOdNmoEeHGGUiMCEfis4XjC6FRyoq371713u5RMsgCXZQn20R6NElRpkITMgwRpeiFdB7Z/0SkuQK7BLoOSolHIwyEZiQbUXnC0aXwrXwzwXvJabjkLSpNoM9uhAwyjRByxCYkGL2mUeMLkWE6TiYSJuWU4I9uhQwykRgIjAh5U56LzC6FB6KVcJgrsXfEuzZLRceZZRplEN5CUzIUGCSM5EYXQqP8gCarvfuV2kZGMA3LVdbrdEqIZHq34oCLUNgQgrZixBdhSoPPHmAhgnR5nebNAKMRHCPVl9fn7V3796mHVQQmJAevt7OvqF9tEqIajVfj52jUGBuwN8k4Ifpyaee9F56jVYhMCGdXL0dWaQ4MMDO14jRq4dJpl1vzlXenmE68IR/xP7U+DijTAQmpD0wPfXUU7RIyO7fv08jADklHVBltxyBicCENKn3csash7VBHhnaN0TDhGx9fd17qUyrwFQb6xSvDJtspPEo0CoEJqTLhPOFFKvUho8BZFq5RcBHj5448IT30rDdYQWBCSlRaNELQq+9df2oCRaJADkS0BFlWo7AhDSwi6e5qqpRTiCCwPStPzCdm5xklxxM4grwSlV6hGB4eJjARGBCSp1ssxcEINtcAZ6yAtFQOqSjHMZLYEI6FJwvpLga1b3Dp9RgWqNVgPyh6jeBCenlWnCoFFdDCJRjUZiOg2kq3gvVb6q0Ssik6rdSXoDARGCCyez1S64JdYpVAvl0bnKyQivEg/ICBCakj+9DynEo0Vj5eqVlbx5APih17ljHRGBCmgIT65diRUkBGK9aZUouksDEOiYCE9IdmPbtY3QpKoODg95LFKuDUbQRjqEhKv5HgXVMBCak6+Y4YnnWL3EcSoQ3yP4+76UTtAoM4wvxgwODtEpEWMdEYEJ6+D6crF+KjjLC1AitgJH3BDkiiSn66LCOicCElN4cWb8U8c1RX7PAtBxMMuK9JyD2e0KBliEwwfDAxPql6ClrFghMMInr/bjvce4JUWIdE4EJKWCfjs36pZgpPXYCE0wy6n2gI1qsYyIwwXy+DyXrl6I3uIedcjC6E+V+v7LgO3IB65hGaBkCEwwNTNLLYf1S9JQq6sO0Cgwx1sb7FWEHJtYxEZhgvNecL1irEA+tx17vTXJzhAlGnC9Y8B0PmfZU2pp7AoEJJtAe0AeeOEDDxHRzbKdnDyTAdV/Ys2cPLRITZcPNSVqFwAQDb4xSa4Wh9/iwyBMGdqLkBuAqpKoUWkVElHVMu7U1ZSAwIX4nWzzAESGlgOVrFKuDSZ0owahzfALamo4UgQkG9CRdW4cPPMmNMU6HDh1qGWKBJDtRUhuIUed4MfJMYEIKepIBuzQQEXkQKcXqCEwwJjA99dRTtEjMlI7ra7QKgQmG9SQpThc/5YFEbxKJODU+LveE3c5rAaOgiJBWB8/+2YDABHqS+aU8kHZzc4QpnSim4+LHyDOBCYb3JFm/xM0RBCbnCzaBJEdpe+4JBCaYcGOUcgKsX0qOMrrHzRFxd6IK3k7UEweeoGESorT9bgrbEpiQDNcHb3iYUzmSpIzu7eYMKcRszNuJopxAgveEetvLz4COFIEJyfYk5cY4TE/SHAGjexSrQ2KdKI5DSZ7SkSUwEZgQswl6kuZRHlAEJsTJ9X7jTMnkKR3ZYap+E5gQLxZ2Gkg5r6tAqyAOdhFb13AGu+OSp5UX8HZ4QWBCdDdG33Qcu+PMMDA40LTHD0TI914bHBikVRK2Y8cObVqOjhSBCTHxfdiYjjODcq4ch24ikfuCTNNTxNYMSod2lA0hBCYkcGOU3ov0YpA8Fn4jQa73GQu+DQpMeoeW+wKBCTFw9UwG9zDsbhIWfsOEwMSCb3NIh5b7AoEJyRh1vmBhp1mUhd/cGBEHFnwbTDkJgPsCgQlR0qrE9vf10zAG6ev3rRsZoVUQ932BBd9mUWYCCEwEJkTM9/ClJ2mWoaGhpj1/IAK+mwALvg37Afnv09wXCEyIMzCxsNM8O3fs1EYA6E0iSiz4Npw24se5cgQmRMv1AVPWy8C8nqQ6AgBE1ZFSzi9DwgJG/EZoGQITYroxKutlYADlgUVPErHdF5R6YDCAciIDI88EJkRBO/pAWS8DAzAlgiQD084fM8JkInbKEZgQH9+Hq+9fGGFKyY2xQKsgQnSkUkCZESAwEZgQR2Di6INU3RhZw4RIaBsKtI0HSJ4SZHfbMwcgMCFkBecLpn3MpSz8HqVVENXbrY33HwwQUBurQMsQmBA+jj5ICW2XEodtIo6OlDIdDEPIESlM1xOYEDH7YcvRBykRcAgvgQlRcN0Idu3aRYsYTNkpR2AiMCHKXqTYN8QIk8mUUSYWeCIKrvcVJQUM70zt83WmRlnHRGBChIFJ1i/J8C7Mpawx46aIKLjeV5QUMDww6aPPBVqGwISIAtO+fYwupf3BBoTEtaGAqXqzyc5m6jERmBARbf2SMqwLwyhTI9wUETmORTEf65gITIiO78PE+qUUPLiYGgGgGBj0jQKeoFUITAiH7yRy1i8B0E67p/q/+bQOr/azBIEJnXN9kFi/lJJe5AC9SMSP6v/puDdwQDeBCdFwLeoc3MO24TRgLQmAIKxjIjAhZNowbcC2VAD545qup8p3eigdX7Y3EpgQNobcU/JzUtaSsE4BIaPKd1p/cJw3SWBCtD1IpnkItgDSj3s5gQkR9yCV6tEA6FDxEE5bh4oRaAITQjfCDTG9qOiLODtUbAhJUWBiBJrAhGgDEzfEdFHWlLCwE0BQh6pAqxCYEFJgAgBktkMFAhN64D5DboiSAgCQBcoSC6bsCUzoxqnxcaZvUu7OnTveSzO0CqKy+d0mjZAi1GIiMCE8vt7G4ABrmFJulSZAiFwBvFar0SIpopwJOkKrEJjQnYE2PmAw1IMHD2gEEMARaHDQ1wEeplUITOiOa4SJGkzpUluttRwRAMK0ucmUXNqdGh8foRUITOgRNZjS79zkJCMCCFPZ+eLu3bu0SIoEnAtKYCIwAfT2AQAEJgAOq6u+waRpWgVR29jYoBEAAhMAoOHc5GTZF5i+JTABBKb8KThfKGX0YXJPf50HFwAQmBC7vn4Oa0yT9fV176UyrYIIrDlfUIsJIDABAPxcpSqo/5UuHMBLYAJyTzkWpUKrIGocj5IuHMBLYALgR2BCFDgeBSAwAenE1m7EiGKoAIEp9zi5Oq2BSdnarW0BB8IOTFT7BghMeTTqfDE0NESLAPByTclRYR4gMAGpUa1WvZeWaBXEhZ1yqcbMAoEJyLUKTYCIzHgv1FZZ+J0Wg4OD3ktjtAqBCcgNqnwjLucmJ1n0neZ7hX+DCJ0rAhO64JrGUaZ5YCiqfCNmVPtOKWXNGYGJwIQu8MEB0A6qfQMEJiB9qPKNJDElzL0CBKZc9xpXvl6hRVJgdVVdUsJNELHdK+7du0eLpBf3CgITunn20gTpo+1Qomgl4gxMUrySaTmAwJRbFKRLSWC65wtMs7QKIlZuJ7jDLNVv1I08FVqGwIQQeo0w38rKSsuHGRCmc5OT8pB17ZRjV22qf5YgMKFDTMmlkBJsZ2gVxMAVzJWRTgAEpvxgXYLZAobYCUyIg+t9puy+gmn3C/8oINP3BCaEcQPc6jWyLsFoiwuL3ktr5yYnCUyIQ9n5QtY8BgR4mItZBQITusGRB+kiRxzcuHGj6UMMiLiD5VrHdOXvV2gVg21+x0YeAhOi+4CxU85YV69e1S6foWUQYwfL9X6TaTlGmcylHGHDaDSBCT2Ydr4IKIqIhAWMLk1Tfwkxk8DEKFN6cYMnMAHZFjC6VKRlECdGmdLl/v37NAKBCSGqOF9wPIp5GF2CYRhlSon19XXvJe4ZBCaEFZhgHkaXYBJGmdLT0QKBCREGJmqrmHfTY3QJBvKNMn3+2ee0ikn3jm83tLDLfYPAhLACE8zy8ccfa5eLtAySpI0ySQX6xcoijWNQZwsEJkQcmBhaN4P8HJQRvwv0EmEI3yjT7AyFpA0OTNO0CoEJvfUUK7SCmQIW0p6mZWDIvcM3yiSLjBllMiQwrTPCRGBCFFy9RKXYGWIWMLp0loALw/hGmT7926ecSWkAdsgRmBANV/VXbnbJ+/CDD7XLRVoGJrFHmVzvSzktYP4f8zROwji1gcCEaLiqv9buMcKUJJnSUHqHbzK6BENDk4wyLTmvzX05R8crYbIIv1nHGAQmdGeGnokZ5CEjUxoeMuXBmXEwWdF7D7l8+TKtkuB9pFXHGAQmdGe1Rc8EMbl06ZIWWM/YUx+Akervz5LlGWWS+mFMzSWjtlpr2TEGgQndYYTJANIjV8KqPIQYXUIaTHgvyGgpB3rHT7uH0+kiMCEcvg8SN7l4Ld9etubm5rQ/OsmNDmlg1wd703u9XC6zninuG7r//k2BLAITQrrR+YZqNx8wyhTnzS1gV9zvtJ8NYPC9pGh5CiTKBob33nuPxonR5nebLTvFIDChe9RiSoD0vD/66CNtCP2svS4ESJuT3vuJ1BS7+uVVWiYmyv2bjheBCSGiFlMCZFGssm5Jhs+p6I1UsqeQC74bzBczTPXH5P79+95LNDyBCSGqOF+sfL1Ci0RMHh7yEPGQnjnrlpD20CRv7D94r3/++ec0Tgyo8k1gQoyBiZ1y0Qt4eExQoBIZCU2yu/OC85pMzVFqIPqOmHaZliEwITyuoQ5qMUVLHhrKWXHT9YfMFK2DDJGpZdd6ptmZWab8I6Rt2GHzCIEJIXdMvBc2NjjtOgrysJCHhoc8VCZoHWSJPVpadD3QNzetjz/+mMaJSLVa9V5aolUITAj3xlb2BaZvCUxRkAKVAdW8K7QOMnhvkak5Vw9haWnJqn5TpXEioJQU4L5CYEIEKC0QMRm1kyMjPGbt+jVAVvl2fQbUHkOPKClAYEI8KC0QsatXr7b1MAGyxB7Bfst5TXZySYV7hIuSAgQmxKPifEFpgXAFjC6d1aZDgQwqWp5R7Pnr7JgLGyUFCExIIDBRWiBcAaNLHKyLXLBri7ne77JTlLVM4aEwKIEJ8aG0QEQCRpem2e6LnPF1EK78/QqtEpKAkgJlWobAhAg6KNqDHr2bn1enHoq0DPLEHmU667zGKFN4lJICa7QKgQnR3Mx8PRFKC/ROFs/fvHnTe3manh9yytdRWFxYpFWiwQg2gQlxobRA76Sqt7IerEjLIKcds4rlGWWS6WpGs3unbNSp0CoEJkRn2vmC0gK9u3nDN7q0xOgScs7XYQjYFIEOKB0zAhOBCRFabdFjQQcWK4vaNt8iLYM8s0eZXJ0zqf5NB603ykYdpuQITIgQH7AQXb923Xtprf6wKNEygP+MOZm+RncCpjSpM0BgQoQqzheygwXdkZ0/So+PukuA9WiTietgWGX6Gu0GJmWDDlP/BCbEGJgEw+TdUerLrBGYAJei84VMX8s0NjqnbNChpACBCRHzTcnVVtkp1ykZXVJG56bsOjQArK0RkJL3wT47M0vDdEHp2LK8gsCEiG9gFK8MQUD14iItA/i4Rl0ZZeoOJQUITEjGNIGpe3KekzK6dNbeGQTAH5gYZeoRJQUITDBA7R5Tcp3gGBSgfdqhvIwydU7ZYEJgIjAhBuUWPRcECDhkl9EloDnfKJNSkgMBAjbmcM8hMCEGqy16LggQUK24SMsAwbRRJrnvcChvewI25rDom8CEGLg+aIwwtd/LU0aXLjC6BLTFN8oUsHkCHto6U3bkEpgQD98Dnp5eawFViqm7BLTBfsBPOa/J5gk2nXQVmKZpFQIT4rlx+QITo0ytzX0557tpUWkX6EjRe4FDeVtTNuYwukRgQoxc+3plqzyCyY4eJVSWaBmg487aBec1mebmtIHmlHsP65cITIiRKyFtrDMs3jRd+uvGLHHILtAV3zQ2h/I2p9R9o4dLYEKMXD0UqYsCnYwuKe3D2iWgC/Y0tmsNjkx3M8rU/f0bBCZEy9VDYQ1TMKVejOz0KdEyQNdK3vsPo0y6gA05FVqGwISEeijUYgq+WSltc4YtvUD37OnsJec1ZVMFgtuPwERgQox44LdBqRMjo0tMxwG9KzpfyCgTx6X4MfpPYIKBqIfiJqNLymLLEqNLQO+0USYO5VV6tv4dzDQSgQkx36zKvsD0LYHJKaAKMaNLQHiKzhccyttehqIJCEyAMWS0TRld4pBdINyOW8niUN7m9yJKvhCYYATXjapWq9EitoBebpGWAULnO5SX5QE/UEqalGkVAhPi59opRx2UH9y8cdN7aZrRJSASJe+F+XlKDIDABBhPFnsrvboSLQOETzsu5datWzSMTSlrwhomAhMSUHG+WPl6hRapW1zwTcetcQwKECnX50s6LMu3l2kVi3PkCEwwMjDh4bTk0tKS9/IULQNEp94hkc+Ya03l7eXbNAwITEhNTyZ3pFertAOlBIDolZwvbty4kft1lRyLQmCCOTgexRuYvvJNAyzVe78MgQMxB6ZGBwZubD4hMCEZLB50YDoOSDQISMdkqUUHJlcY9ScwwWB5rn8S0Jst8a4AYuPqoEgHJs/TcsqxKNO8RQhMSKZHV/YFphwfj8J0HJC4UpsdGYDABCSB6TjAiE4c03IgMAEmYzoOMAbTcjalNl6FtweBCclx9eaq1Wo+AxPTcYApSm12aPKIwERgAh/A5DAdB5iDaTkQmABDMR0HGMc3LZdHlBUgMMHkD+h3+fuAVld805BMxwHJKrXZsck0pZhwmbcGgQnJcX0Aa7Va7hqA6TjALNq0HGfLgcAEJCjg7DgCE5A8puVAYAJMoUzHrWkFPQHEzvU5lI5NwGG0maRU+d66zNuCwIQEP5fOF3k7gPfWrVtNe7UAklHvuMhncc15LU+75TYfbGptwtpKAhMSNOPtxeWpB7e+vk5gAsw11aKDAxCYgIR6cAQmwBxl5wulg5Pd+xMlBQhMMF+eTwcHYJRKXr9xZQ3TLG8HAhOS5ZsTr63WaBUAMCxD0QQEJiTo3ORkbj+ESs2pNd4RAAACE+CgTD2yAwWAETbWN7yXGGEiMAEAoKr4UsNqPnKDssCdDh2BCQAAv3OTk77ApO1uBQhMAAAABCYYwnVIUx4P4AUAgMCEVirOF9RhAgCAwAQAAEBgAgAAIDABAAAQmAAAAAhMAAAABCYAAAACEwAAAAhMAAAABCYAAAACEwAAAIEJ6Frtnu/MvAqtAgAgMAEOfX193ksjtAoAgMCEICdaBIlM2vnjnfzkAaTFAE1AYIJh8hKYAMBUg4OD3ktjtAqBCQk6NT4+QisAgFkYAScwwTy+wDT02BCtAgAJ2rFjh/cSI0wEJgAA4KRMye2mVQhMSFbB+aK/v58WAQADnRofZ+E3gQmm2LVrF40AAAkbHBjULjMtR2BCgkZoAgAwi7KGCQQmmBSY9j2+jxYBAAPs3OnbKccIE4EJAAA47d2713uJNUwEJiTIVeV7YIDPIwAYihs0gQlJ0IpWKkPAAIAEUO2bwARz+D58ATszMql2r+a9VOEtAcCYwLTHdz8+QasQmGBAYJIaTHnambG5uUlgAmAs7VzPU+PjjDIRmJB0YFIWGAKA6R2dzAo4pmqEdwGBCQkHJmX4FwCSNut8sbq6mqtvXunIMsKUEttpgkwZdr64eeOmtfL1Sm6++bt37/IOAMznSkhh3aNk+YGyqDoNCrwlCEyI0anxcd+Hbn19fesXAJjqzp07W79yjBGmlGBKjg8dACA5uzmEl8AEAhMAgPt3JjAllx1li230XlM0AWCcmYj+vyOWZx1nihTsezgM9qPvv/+eVgAAACAwAQAAEJgAAAAITAAAAAQmAAAAAhMAAACBCQAAgMAEAABAYAIAAACBCQAAgMAEAABAYAIAACAwAQAAEJgQvlPj40VawaVybnKyRDMAAMKwnSbIRFgaqP/2R1rC5S2aAAAQlm00QSaM0QQ+qzQBAIDABAITAAAxYUouGyacL3bu3Gnt3bs3Vw1w9+5da3Nzk3cCAIDABL9T4+MyujTqvHb0uaPWseeO5aod3nnnHevOnTu8IQCz71fSuRvp8D+bsTI8xX5ucrLMO4PAhHic9l448swRWgWAiSQssUHFHSIP1kNThZYwH2uY0v1Bk91xbzivHT582NqxY0fu2oLpOAApDpEgMCFiE94LBw8dzGVDyBomjzJvDwApUKAJ0oEpuXRzTcfJQu+hx4ZoFQCp0M4GlRysTZSOb5F3A4EJETk1Pn6y/tuw89qz//YsDQMgNSQs/fa3v83V97xYWbQ++OsHzkvD9ft5gcXf5mNKLt29EldP7cATB2gVADCY3Kflfu1xmpYhMCEC9d7ISP2315zXnn766Vwu9gaQKhXnC2XtYebJfXp4eNh7+TX7vg4CE0LmLyVwhFICANIVmPK6u/XYMbVO3gRvDwITQmSXEnB9sPbv32/19fXROACQAnK/lvt2q44wCEzoTbH+a7fzwpFn8z26tLq62rInCwAmOfSvh7yXdtuV0EFgQq/sOe7fO6/19/fnfrH35gP/sD6VcwGY7ODIwa37tweBicCEkBS9F37161/RKgCQQk8fftp76YR9PigITOiW/SFyHYMic+AUqgSAdJJRJgVrmQhM6NEZ74XjPzlOqwBIE9+Cw42Njdw2hiz+lvM/Pd6gxACBCV2SKrD13044r0kdD0aXAKTJucnJGV9g+nYj120ScP5nkXcLgQnd8X14nn/+eVoFAFJOOr5KiYE3WMtEYEKH7G2mrtElGcKl7hIAZEPA8ooztAyBCZ0pOl/IGUSMLgFAdsgok7KW6YS9HAMEJrRijy65Dh06+txRzowDgIwJOC6lSMsQmNA6LMkRKK4hWRldOvIMZ8YBQNYE7Jg7QfVvAhNak56F6wiU0bFRRpcU1WrVe2mJVgGQNrLcQjrGyrMABCZo7N0RviNQGF1qW4UmAJA20iGWZRcew4wyEZgQzLc7giNQACD7pGOsjDKdsZdpgMCEBq2MAEUqASAfZJRJll94yPIMjkwhMMERltSF3pQRAJAhs84XyhrE3JNRJlmG4XGaI1MITPhB0fIs9Jb5bIpUNrexvkEjAOmxShO0FjDKRDFLAhOCFnofe+4YjdPC+vq691KZVgGQZgdHDmpHprxGMUsCE1joDQBw+NnPfqZdLtEyBKbcYqE3AMBrYGDAOnpULTNQpHUITHkMSyz0BgCojh8/rpUZYAE4gSmXYalksdAbQH5UnC9q92q0SBNSZuDn//Fz72UWgBOYcheWyvVfrzmvs9C7c3fu3PFemqFVgHQEps3NTVqkBRaAE5gIS5bl2zfKQu9QUBEXQKawAJzARFhy+PX/+zULvbug9LzodQHIVi+QBeAEJsLSD2FJhl3RucHBQe+lMVoFQNawAJzARFgiLPVkaJ9vVG6UgyqBdLh//z6N0KYmC8CnuOcRmAhLaGlwYFC7zCgTYKay84VSqR9NBCwAl2dLmdBEYEp7WJIH94w3LMmwKmEpHFKCQTmocoKWAYxEZ6ZHx39yXLtMaCIwpT4sSW9q2BuWXn75ZcJSiJQe1xvM6wPmBybls4sWZHOQdLiV9UwSmmbsZw8ITKkLS7u1sCQ7HhCeI0eOaJeLtAxgnILzxb7H99EiXZAOtzxLlNAkHfQyoYnAlJawdJKwFC9p04BRJhobMOfeOGB5Rty5H/Z23wsITbsJTQSmNNwQJuq/nScsxS9gXn+ClgGMUfBeCNi0AUITgSnjYel0/be3vddlQTJhKXoyr793714CE2Cu0957I+dmEpoITPkLS6X6b3/yXpcH+KuvvkpYismhfz3kvTTK4m/AiHukfA5POK+x4JvQRGDK101gwA5Lb2hh6aWXXtoqNoaYAtPBQ9plbhRA8oreC8eOcdB4jKHpC3vJCAhMyYQl6+Hibl9YOnz4sPXKK68QlmIm7a1MyxVoGSDRe+WI9z4p90im46IJTTKrodwHxduEJgJTkmFpVAtLL7zwAo2UkD179ngvMcIEJOuk90JAKRCEQIKozG40CU1naCUCU1xhSR7AFS0syTk/hKWEbxb99FoBw7gWe8uDnHWd0ZLR9iah6ff2UhIQmCIPS2XLUzZASOXVI8/QawIAzz3TVXvp2X97loaJMTQNDw9rfyx16jhKhcAU2Qd/ov7bF5ZWY+m/OOrEFCtfr3gvVWgVIDG+KfEDTxygVWIMTS+++OLWUhGF7FokNBGYQg9LRUupsdQoSCk1gGAsAhNgSGCSKSI2w8RPloocPXpU+6PGob2s9SQwhRKWSvXf/ui9Lh98ClICQPuBSdmUgZg8//zzW0tHCE3d2U4TNA1KgTvhqLEEAJ1jU0ayGktHPv3bp9bm5qbzjxoFLk+em5ws01J+jDAFh6Uxq0nZAMISAHRu87tNGsGA0NSkwOW71GoiMIUSlmQOWOaCCUtmevDggXXnzh3v5QotAyRmxvmiVqvRIgZoUhVcvG2v2wWBqWlYkmTt2wknZO5X5oBhro8//li7TGACkrNKE5gbml5//fWgWk1/pFYTgalZWJJEre+Eo2yA8ZZvL1tLS0vey7PMxwOArkWBS6nVNEPZAQKTMygNtNoJR9kAc8k03CeffGKV31Vz0WlaCABah6aAWk3soCMwPQpLI1bAAbqNnXCUDTDX1S+vWufPn7du3Lih/fFbjC4BiXNNyd2/f58WMTQ0UauJwNQsLMmBkDNWwE64V155hcXdhlqsLFpTU1PWzBcz3q2xDWv1X0VaCkica9H3+vq6tbGxQasYqkmtJlnX+0Wed9DlNjDZpzWft5TF3WM/HeMAXQPJ1Nv8P+a3gtIHf/1g68Yb4Kz8GM9NTrLYFEie73MYsDkDhtgqO/Bf7KDz+tH333+ft6A0Uv9tylJGleTN8fP/+DmLuw1T/aZqLS4sBk27Oc3Wf51mGg4w7r4rn8kT3o7pseeO0TgmJ93VVeujjz6y7t69G9QxPZ2njmmuApM9BVeylFElWa/0y1/+kvVKhpAdb7eXb2/teguYcnNasz+4JVoOMLajuui9vn//futnP/sZ912Dycj+pUuXgkKTdFILeQlNuQlM9hTc77U/k/VKMm/LeqVUhaRGUJKf6xmm3wDj78FFS9mJzD04HWQncsAov9RykeNUZghM2ejZMAVnqMZ0WwchqdGrkaA0RVACUnU/VjfZNO7HR587ah155gjByVCyK1k22gT4Q/1+fIbAlN4P54T9YGUKziAyxLuwuGBdm7vWbOG215odfM/koScDZPSeLDfc0/av3UHBaXh42Dpy5Aj3ZwPJDmXZdBPgQv3XRFY7spkNTHZYelv7M4Z/k9HB4m1vSJKRpClaEMjM/XnE7sy+1uzfk47ts//2rHXgiQPcrw0ii8EvXrwYNCuwZIemMoEpHR/GkqUUomQKLhkyonTlyhVrbm6unX99yRGSyrQekOngVLCD02irf1dGnYb2DW2Fp76+PhrPgPv6e++9px123vBm/R5eJDCZ++EbsD98atXu//zP/+SDFjNZyP3Zp5+1mnpjug3Id3CasB4Wmh1u59+X+/mhfz1EeDJAi3VN09bDBeGZmKLLTGCyw1JZ66lIz+QXv/gFQ7oxkkq+ly9f1g7DdWLxNgDnfbxQ/21C6/Q2C09M2yVLllvIWZ5NTl04mYUZg0wEJvt8m5IVcMQJVbvjJdW4Z2dmm+16k4WBRUaTADTpAE/Yv0bb+W9YLJ4smaKTCu5NOsmp30WX+sBkhyVJrr4dF7JeSbaoIj5NanWIzC4GBBDZPX6k/tvJTsKTjDod/8nxrVEnxN9h/vRvnwb98dn6/X+CwJTMB0kaXi0bIIcHsrg73t5Fk2qw4i3r4agSU28AYglPUklclmOwzilesouuXC4HrV1N7ZEqqQ1MQWUDZFj25ZdfZkjW"
               + "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",
          fileName="modelica://ComfortModel33NCM/Pictures/Mensch in Einzelteilen.png")}),
    experiment(StopTime=15600, Interval=60),
    __Dymola_experimentSetupOutput(events=false),
    Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview </span></h4>
<p>33 Node-Comfort-Model NOODEL as standalone model </p>
<h4><span style=\"color: #008000\">Concept </span></h4>
<p>All 16 body parts are connected via the blodd flow.</p>
<p>According to the boundary conditions the body temperatures are calculated. From the body temperatures the thermal sensation and comfort is calculated.</p>
<p>The order of the body parts for the boundary conditions is as follows:</p>
<p>head, chest, back, pelvis, rshoulder, lshoulder, rarm, larm, rhand, lhand, rthigh, lthigh, rleg, lleg, rfoot, lfoot</p>
<p>In the txt file for the input date the following information have to be given:</p>
<p>Tair, Trad, velocity, rh, met, Icl, CSF, Tmt, CSR, ISolar, initial skin temperature, initial core temperature, position</p>
</html>"));
end NOODEL_standalone;
