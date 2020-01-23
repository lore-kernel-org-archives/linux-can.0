From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/3] Add Support for MCAN in AM654x-idk
Date: Thu, 23 Jan 2020 12:17:52 +0100
Message-ID: <e3025ab6-04b5-3eba-5e0d-70caabee26fb@pengutronix.de>
References: <20200122080310.24653-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4983768349075934911=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200122080310.24653-1-faiz_abbas@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Faiz Abbas <faiz_abbas@ti.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: mark.rutland@arm.com, nm@ti.com, catalin.marinas@arm.com, sriram.dash@samsung.com, t-kristo@ti.com, robh+dt@kernel.org, dmurphy@ti.com, davem@davemloft.net, wg@grandegger.com
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============4983768349075934911==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="NYPXrD8dZpuBhFWGBbPAmL2QzBA7ljtTf"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NYPXrD8dZpuBhFWGBbPAmL2QzBA7ljtTf
Content-Type: multipart/mixed; boundary="QyFCGrPkezEuEBS1nbpXxyDGG5wrx8uVJ";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Faiz Abbas <faiz_abbas@ti.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: catalin.marinas@arm.com, mark.rutland@arm.com, robh+dt@kernel.org,
 davem@davemloft.net, wg@grandegger.com, sriram.dash@samsung.com,
 dmurphy@ti.com, nm@ti.com, t-kristo@ti.com
Message-ID: <e3025ab6-04b5-3eba-5e0d-70caabee26fb@pengutronix.de>
Subject: Re: [PATCH 0/3] Add Support for MCAN in AM654x-idk
References: <20200122080310.24653-1-faiz_abbas@ti.com>
In-Reply-To: <20200122080310.24653-1-faiz_abbas@ti.com>

--QyFCGrPkezEuEBS1nbpXxyDGG5wrx8uVJ
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 1/22/20 9:03 AM, Faiz Abbas wrote:
> This series adds driver patches to support MCAN in TI's AM654x-idk.
>=20
> Faiz Abbas (3):
>   dt-bindings: net: can: m_can: Add Documentation for stb-gpios
>   can: m_can: m_can_platform: Add support for enabling transceiver
>     through the STB line
>   arm64: defconfig: Add Support for Bosch M_CAN controllers
>=20
>  Documentation/devicetree/bindings/net/can/m_can.txt |  2 ++
>  arch/arm64/configs/defconfig                        |  3 +++
>  drivers/net/can/m_can/m_can_platform.c              | 12 ++++++++++++
>  3 files changed, 17 insertions(+)

What about adding support for xceiver-supply as done in several other
drivers (ti_hecc.c, flexcan.c, mcp251x.c)? And using this for the stb lin=
e?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--QyFCGrPkezEuEBS1nbpXxyDGG5wrx8uVJ--

--NYPXrD8dZpuBhFWGBbPAmL2QzBA7ljtTf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl4pgOAACgkQWsYho5Hk
nSC/egf/eNjB8/lL8muUSORGL2cgcDJIY77iCCdmjkPckQ0gG//AAseZ6T8y/rph
I66pOuysdn2ON8V1N5aeFefGwxF9T9bNvjJe1vsSHqIdLNUmpstuHMKs7jgKQxPE
ublvNPRh/XtrQ2/ERSFApv55CqA2+9VwSSKAPFKmhrmyUHuZCVlPPWCF06AkuLac
sZaFffTh0ZCNuq5XoGiZPJWDJ8IjLN//nH/eBrCZpd9omTqC84EUFBW8aV7F2gZa
quhtzwoufrEFUUAqdkQlFHvTOeiMnHmJhSx0PLetoscDBc7dVoajELf9pUmaAGBt
/fa70dou1CkvLPpdYxpUUrrzi/3qRw==
=0YB1
-----END PGP SIGNATURE-----

--NYPXrD8dZpuBhFWGBbPAmL2QzBA7ljtTf--


--===============4983768349075934911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4983768349075934911==--
