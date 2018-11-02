![E.ON EBC RWTH Aachen University](./doc/_static/EBC_Logo.png)

# 33 NCM - 33 Node Comfort Model

[![License](http://img.shields.io/:license-mit-blue.svg)](http://doge.mit-license.org)

33 NCM (33 Node Comfort Model) allows
fast generation of archetype buildings with low input requirements and the
export of individual dynamic simulation models for the below-mentioned Modelica
libraries. These libraries all use the framework of [Modelica IBPSA
library](https://github.com/ibpsa/modelica). TEASER is being developed at the
[RWTH Aachen University, E.ON Energy Research Center, Institute for Energy
Efficient Buildings and Indoor
Climate](https://www.ebc.eonerc.rwth-aachen.de/cms/~dmzz/E-ON-ERC-EBC/?lidx=1).

 * [AixLib](https://github.com/RWTH-EBC/AixLib)
 * [Buildings](https://github.com/lbl-srg/modelica-buildings)
 * [BuildingSystems](https://github.com/UdK-VPT/BuildingSystems)
 * [IDEAS](https://github.com/open-ideas/IDEAS).

The full documentation of TEASER including examples and description of modules,
classes and functions can be found at the website:

 * http://rwth-ebc.github.io/TEASER/

This GitHub page will be used to further develop the package and make it
available under the
[MIT License](https://github.com/RWTH-EBC/TEASER/blob/master/License.md).

If you have any questions regarding TEASER feel free to contact us at
[ebc-teaser@eonerc.rwth-aachen.de](mailto:ebc-teaser@eonerc.rwth-aachen.de).

---

## Updates

---

## Description

Energy supply of buildings in urban context currently undergoes significant
changes. The increase of renewable energy sources for electrical and thermal
energy generation will require flexible and secure energy storage and
distribution systems. To reflect and consider these changes in energy systems
and buildings, dynamic simulation is one key element, in particular when it
comes to thermal energy demand on minutely or hourly scale.
Sparse and limited access to detailed building information as well as computing
times are challenges for building simulation on urban scale. In addition,
data acquisition and modeling for Building Performance Simulation (BPS) are
time consuming and error-prone. To enable the use of BPS on urban scale we
present the TEASER tool, an open framework for urban energy modeling of
building stocks. TEASER provides an easy interface for multiple data sources,
data enrichment (where necessary) and export of ready-to-run Modelica simulation
models for all libraries supporting the
[Modelica IBPSA library](https://github.com/ibpsa/modelica).


## Version

33 NCM v1.0 as first release.

## How to use 33 NCM

### Dependencies

33 NCM is tested against dymola 2018 and OpenModelica xxx 

### How to contribute to the development of TEASER
You are invited to contribute to the development of TEASER. You may report any issues by using the [Issues](https://github.com/RWTH-EBC/TEASER/issues) button.
Furthermore, you are welcome to contribute via [Pull Requests](https://github.com/RWTH-EBC/TEASER/pulls).
The workflow for changes is described in our [Wiki](https://github.com/RWTH-EBC/TEASER/wiki).

## How to cite TEASER

+ TEASER: an open tool for urban energy modelling of building stocks. Remmen P., Lauster M., Mans M., Fuchs M., Osterhage T., Müller D.. Journal of Building Performance Simulation, February 2017,
[pdf](http://dx.doi.org/10.1080/19401493.2017.1283539),
[bibtex](https://github.com/RWTH-EBC/TEASER/tree/master/doc/cite_jbps.bib)

### TEASER related publications


+ CityGML Import and Export for Dynamic Building Performance Simulation in Modelica. Remmen P.,
Lauster M., Mans M., Osterhage T., Müller D.. BSO16, p.329-336, September 2016,
[pdf](http://www.ibpsa.org/proceedings/BSO2016/p1047.pdf),
[bibtex](https://github.com/RWTH-EBC/TEASER/tree/master/doc/cite.bib)

+ Scalable Design-Driven Parameterization of Reduced Order Models Using Archetype Buildings with TEASER.
Lauster M., Mans M., Remmen P., Fuchs M., Müller D.. BauSIM2016, p.535-542, September 2016,
[pdf](https://www.researchgate.net/profile/Moritz_Lauster/publication/310465372_Scalable_Design-Driven_Parameterization_of_Reduced_Order_Models_using_Archetype_Buildings_with_TEASER/links/582ee96908ae004f74be1fb0.pdf?origin=publication_detail&ev=pub_int_prw_xdl&msrp=eEyK6WYemhC8wK7xkMEPRDO4obE4uxBN4-0BdBy1Ldwhy9FhCe1pXfNObJYubvC_aZN0IWDPf9uayBo3u79bsZvg3hzUoLoYRatES2ARH8c.B2cYwSICt0IOa7lD-4oAiEa_3TtrO-7k-1W9chuNQwr_VNMCpZ5ubSb-eY2D77rGUP4S6wS8m6vudUUbMlXbQQ.Cledgd1Q9fPp11nYGpcpKNhSS6bVTqAEXeMZPkiV3HsJxcVWTFj4Hr_jmLZ0MOzDxbDEZObcGiKfmTL_9k_59A)

## License

33 NCM is released by RWTH Aachen University, E.ON Energy
Research Center, Institute for Energy Efficient Buildings and Indoor Climate,
under the
[MIT License](https://github.com/RWTH-EBC/TEASER/blob/master/License.md).

## Acknowledgements

This  work  was  supported  by  the  Heinz Trox Wissenschafts gGmbH. The development of the base model was supported by Airbus Operations GmbH.
