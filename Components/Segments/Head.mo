within NOODEL.Components.Segments;
model Head
  extends BodyPart(
  core(
    TSET=36.1,
    Ccore=(0.2584*3600),
    QB=16.5509,
    weight=3.18+0.84,
      Q(start=17.17)),
  skin(
    TSET=35.94,
    QB=0.1287,
    weight=3.18+0.84,
    S=0.14,
    Cskin=(0.1885*3600),
    TSETpsy=34.5),
  CoreConv(                     BFB=35.251/3600, BF(start=38.8/3600)),
  SkinConv(                    BFB=1.754/3600, BF(start=1.5/3600)),
  alpha=1,
  CD=3.822,
  SKINR = 0.0549,
  SKINS = 0.064,
  SKINV = 0.1043,
  SKINC = 0.0213,
  CHILF = 0.0339,
  METF = 0.0,
  RESC=0,
  B=4.9,
  n=0.73,
  Bs=3.2,
  ns=0.73,
  CR=1,
  CRS=1,
  TClcoeff={-0.4418,0.0048,0.9722},
  CoeffTSl={0.4,0.2,1.3,0.2,543,90,0});

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),
                   graphics={Bitmap(extent={{-36,-24},{32,48}},
          imageSource="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",
          fileName="modelica://ComfortModel33NCM/Pictures/Kopf.png")}),
                          Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-100,-100},{100,100}})));

end Head;