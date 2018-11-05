From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/6] phy: Add max_bitrate attribute &
 phy_get_max_bitrate()
Date: Mon, 5 Nov 2018 12:47:33 +0100
Message-ID: <1e708b81-ed63-7dbf-3120-d256c0ec76c6@pengutronix.de>
References: <20181102192616.28291-1-faiz_abbas@ti.com>
 <20181102192616.28291-2-faiz_abbas@ti.com>
 <5e1a0b67-510a-5512-d477-0b363e4733fe@pengutronix.de>
 <d75c9e3c-e12b-e0b8-832c-ad117dcbe990@ti.com>
 <0c0885c4-f5ae-a29c-7176-f67fe546cfd8@pengutronix.de>
 <5685cb49-a6bf-3696-f984-020847633e5e@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Q0B2CvaUfKsOKewU1aPi4chqTYQnjVgSF"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5685cb49-a6bf-3696-f984-020847633e5e@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: wg@grandegger.com, robh+dt@kernel.org, mark.rutland@arm.com, kishon@ti.com
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q0B2CvaUfKsOKewU1aPi4chqTYQnjVgSF
Content-Type: multipart/mixed; boundary="rbHSpJqINOLacQhRWrJcLp386iMuEBrQ6";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: wg@grandegger.com, robh+dt@kernel.org, mark.rutland@arm.com, kishon@ti.com
Message-ID: <1e708b81-ed63-7dbf-3120-d256c0ec76c6@pengutronix.de>
Subject: Re: [PATCH 1/6] phy: Add max_bitrate attribute &
 phy_get_max_bitrate()
References: <20181102192616.28291-1-faiz_abbas@ti.com>
 <20181102192616.28291-2-faiz_abbas@ti.com>
 <5e1a0b67-510a-5512-d477-0b363e4733fe@pengutronix.de>
 <d75c9e3c-e12b-e0b8-832c-ad117dcbe990@ti.com>
 <0c0885c4-f5ae-a29c-7176-f67fe546cfd8@pengutronix.de>
 <5685cb49-a6bf-3696-f984-020847633e5e@ti.com>
In-Reply-To: <5685cb49-a6bf-3696-f984-020847633e5e@ti.com>

--rbHSpJqINOLacQhRWrJcLp386iMuEBrQ6
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/05/2018 12:14 PM, Faiz Abbas wrote:
> Hi,
>=20
> On Monday 05 November 2018 03:07 PM, Marc Kleine-Budde wrote:
>> On 11/05/2018 07:27 AM, Faiz Abbas wrote:
>>> I remove the transceiver child node binding documentation in patch 5/=
6.
>>>
>>> The existing implementation is pretty limiting as it just has a child=

>>> node with no associated device. What if a transceiver requires its ow=
n
>>> configurations before it can start sending/receiving messages (for
>>> example, my usecase requires it to pull the standby line low)?
>>>
>>> I think that can be solved by implementing the transceiver as a phy a=
nd
>>> exposing a generic get_max_bitrate API. That way, the transceiver dev=
ice
>>> can do all its startup configuration in the phy probe function.
>>>
>>> In any case, do suggest if you have a better idea on how to implement=

>>> pull gpio low requirement.
>>
>> As long as we don't have any proper transceiver/phy driver, that does
>> more than swtich on/off a GPIO, please add a "xceiver" regulator to yo=
ur
>> driver. Look for:
>>
>>> devm_regulator_get(&pdev->dev, "xceiver");
>>
>=20
> The transceiver is not specific to m_can. The pull down would be
> required even if it were connected to some other controller.

Ok, this is a quite common pattern. For the fsl/nxp boards we add the
regulator to the board dts. See "imx28-evk.dts" for example:

>                         can0: can@80032000 {
>                                 pinctrl-names =3D "default";
>                                 pinctrl-0 =3D <&can0_pins_a>;
>                                 xceiver-supply =3D <&reg_can_3v3>;
>                                 status =3D "okay";
>                         };
>=20
>                         can1: can@80034000 {
>                                 pinctrl-names =3D "default";
>                                 pinctrl-0 =3D <&can1_pins_a>;
>                                 xceiver-supply =3D <&reg_can_3v3>;
>                                 status =3D "okay";
>                         };

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--rbHSpJqINOLacQhRWrJcLp386iMuEBrQ6--

--Q0B2CvaUfKsOKewU1aPi4chqTYQnjVgSF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlvgLdUACgkQk9IU1zQo
ZfHKegf/R5SAXwK6rHPdQ9bSBSvlZX2RhEezFf15g4U8ypCMDo5bTEgd+ov4tHZr
6z3xTZ52XDwy28PvJs+JXSW7FDoreYL9tvyjIbeb0Lz5Q9mP3OVlNkOiiFW+qO8d
QWpOR0jBZQfnsx66q4AvHMvlepmIOiBETjQzKLepRVkSlbtub5m6tJbn5sDQXbk9
YyQQjJ7K01PukSC1m1Ct/JRTfaIbU8Cdr/BbTn+ZDnvCar5RA9OKtZCRLDC5bXBV
uAafR4fEclhoDXwClcHMImdgiWpXpMloZpiAVatM5FbbV0ASFqrho4Xh9KymgPd3
7ClDeczpQBOGrCCMg/bqbFwqaZN39g==
=T/rn
-----END PGP SIGNATURE-----

--Q0B2CvaUfKsOKewU1aPi4chqTYQnjVgSF--
