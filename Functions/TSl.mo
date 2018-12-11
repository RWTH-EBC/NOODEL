within NOODEL.Functions;
function TSl

  input Modelica.SIunits.Conversions.NonSIunits.Temperature_degC
                                            Tskin;
  input Modelica.SIunits.Conversions.NonSIunits.Temperature_degC
                                            TskinSet;
  input Modelica.SIunits.Conversions.NonSIunits.Temperature_degC
                                            TskinAve;
  input Modelica.SIunits.Conversions.NonSIunits.Temperature_degC
                                            TskinSetAve;
  input Modelica.SIunits.TemperatureSlope dTskin;
  input Modelica.SIunits.TemperatureSlope   dTcore;
  input Real CoeffTSl[7];
  output Real TSl "Local thermal sensation ";

algorithm
  if (dTskin<=0) then
    if (Tskin-TskinSet <= 0) then
      TSl :=3*(2/(1+exp(-CoeffTSl[1]*(Tskin-TskinSet)-CoeffTSl[2]*((Tskin-TskinAve)-(TskinSet-TskinSetAve))))-1)+CoeffTSl[5]*dTskin+CoeffTSl[7]*dTcore;

    end if;

    if (Tskin-TskinSet > 0) then
      TSl :=3*(2/(1+exp(-CoeffTSl[3]*(Tskin-TskinSet)-CoeffTSl[4]*((Tskin-TskinAve)-(TskinSet-TskinSetAve))))-1)+CoeffTSl[5]*dTskin+CoeffTSl[7]*dTcore;
    end if;
  end if;

  if (dTskin>0) then
    if (Tskin-TskinSet <= 0) then
      TSl :=3*(2/(1+exp(-CoeffTSl[1]*(Tskin-TskinSet)-CoeffTSl[2]*((Tskin-TskinAve)-(TskinSet-TskinSetAve))))-1)+CoeffTSl[6]*dTskin+CoeffTSl[7]*dTcore;

    end if;

    if (Tskin-TskinSet > 0) then
      TSl :=3*(2/(1+exp(-CoeffTSl[3]*(Tskin-TskinSet)-CoeffTSl[4]*((Tskin-TskinAve)-(TskinSet-TskinSetAve))))-1)+CoeffTSl[6]*dTskin+CoeffTSl[7]*dTcore;
    end if;
  end if;

  annotation (Documentation(info="<html>
<p>The <b>TSl</b> function calculates the local thermal sensation on a scale between -3 and 3. </p>
</html>"));
end TSl;
