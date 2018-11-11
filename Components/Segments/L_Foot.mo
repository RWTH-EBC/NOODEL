﻿within NOODEL.Components.Segments;
model L_Foot
  extends BodyPart(
  core( TSET=35.02,
    Ccore=(0.1536*3600),
    QB=0.09,
    weight=0.48,
      Q(start=0.09)),
  skin(
    QB=0.05,
    TSET=34.44,
     TSETpsy=35,
    weight=0.48,
    S=0.056,
    Cskin=(1.088*3600)),
  CoreConv(                     BFB=0.217/3600, BF(start=0.08/3600)),
  SkinConv(                    BFB=1.114/3600, BF(start=0.5/3600)),
  alpha=0.762,
  CD=0.75,
  SKINR = 0.0923,
  SKINS = 0.0155,
  SKINV = 0.0605,
  SKINC = 0.1489,
  CHILF = 0.0002,
  METF = 0.005,
  RESC=0,
  B=12.9,
  n=0.545,
  Bs=12,
  ns=0.495,
  CR=0.75,
  CRS=0.75,
 TClcoeff={-0.3752,0.1152,0.4188},
  CoeffTSl={0.21,0.15,1.79,0.15,109,162,0});

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),
                   graphics={Bitmap(extent={{-18,-28},{24,22}},
          imageSource="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",
          fileName="modelica://ComfortModel33NCM/Pictures/Fuß rechts.png")}));

end L_Foot;