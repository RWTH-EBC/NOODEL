within NOODEL.Components.Segments;
model L_Shoulder
  extends BodyPart(
  core(
    TSET=36.25,
    Ccore=(1.223568 * 1000),
    QB=1.215,
    weight=1.944,
      Q(start=1.215)),
  skin(
    QB=0.05,
    TSET=34.29,
    TSETpsy=33.32,
    weight=0.216,
    S=0.096,
    Cskin=(0.4536 * 1000)),
  CoreConv(                     BFB=1.808/3600, BF(start=0.28/3600)),
  SkinConv(                    BFB=0.91/3600, BF(start=0.4/3600)),
  alpha=0.537,
  CD=2.001,
  SKINR = 0.0227,
  SKINS = 0.051,
  SKINV = 0.0313,
  SKINC = 0.0213,
  CHILF = 0.0024,
  METF = 0.026,
  RESC=0,
  B=11.4,
  n=0.64,
  Bs=10.05,
  ns=0.625,
  CR=0.7,
  CRS=0.7,
  TClcoeff={-0.4255,0.0456,0.8853},
  CoeffTSl={0.3,0.1,0.43,0.1,156,167,0});

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),
                   graphics={Bitmap(extent={{-30,-36},{36,38}},
          imageSource="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",
          fileName="modelica://ComfortModel33NCM/Pictures/Oberarm rechts.png")}));

end L_Shoulder;
