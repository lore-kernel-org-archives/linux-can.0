From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [PATCH 06/11] arm64: dts: renesas: r8a774c0-cat874: Add uSD
 support
Date: Thu, 17 Jan 2019 13:19:06 +0000
Message-ID: <TY1PR01MB1770A5603DE648612A5CA15EC0830@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547663874-29411-7-git-send-email-fabrizio.castro@bp.renesas.com>
 <20190117111147.vb3lkdmgx24zusjx@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190117111147.vb3lkdmgx24zusjx@verge.net.au>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Biju Das <biju.das@bp.renesas.com>, Magnus Damm <magnus.damm@gmail.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Thierry Reding <treding@nvidia.com>, =?iso-8859-2?Q?Andreas_F=E4rber?= <afaerber@suse.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>, Lukasz Majewski <lukma@denx.de>, Michal Simek <monstr@monstr.eu>, =?iso-8859-2?Q?Michal_Vok=E1=E8?= <michal.vokac@ysoft.com>Martin Blumenstingl <mar>
List-Id: linux-can.vger.kernel.org

Hello Simon,

Thank you for your feedback!

> From: Simon Horman <horms@verge.net.au>
> Sent: 17 January 2019 11:12
> Subject: Re: [PATCH 06/11] arm64: dts: renesas: r8a774c0-cat874: Add uSD =
support
>
> On Wed, Jan 16, 2019 at 06:37:49PM +0000, Fabrizio Castro wrote:
> > From: Biju Das <biju.das@bp.renesas.com>
> >
> > This patch adds uSD card support.
>
> Can I confirm that SDHI0 is wired up to a uSD slot?

Yes, it is wired up to a uSD slot

Thanks,
Fab

>
> I ask because if that is the case then this patch looks good to me.
> But if it is wired up to a full-size SD slot then I believe
> a wp-gpio (write protect) should be described.
>
> >
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> > ---
> >  arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts | 50 +++++++++++++++++=
++++++++
> >  1 file changed, 50 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts b/arch/arm=
64/boot/dts/renesas/r8a774c0-cat874.dts
> > index c545ce5..477a56b 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
> > +++ b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
> > @@ -7,6 +7,7 @@
> >
> >  /dts-v1/;
> >  #include "r8a774c0.dtsi"
> > +#include <dt-bindings/gpio/gpio.h>
> >
> >  / {
> >  model =3D "Silicon Linux RZ/G2E 96board platform (CAT874)";
> > @@ -26,6 +27,29 @@
> >  /* first 128MB is reserved for secure area. */
> >  reg =3D <0x0 0x48000000 0x0 0x78000000>;
> >  };
> > +
> > +vcc_sdhi0: regulator-vcc-sdhi0 {
> > +compatible =3D "regulator-fixed";
> > +
> > +regulator-name =3D "SDHI0 Vcc";
> > +regulator-min-microvolt =3D <3300000>;
> > +regulator-max-microvolt =3D <3300000>;
> > +regulator-always-on;
> > +regulator-boot-on;
> > +};
> > +
> > +vccq_sdhi0: regulator-vccq-sdhi0 {
> > +compatible =3D "regulator-gpio";
> > +
> > +regulator-name =3D "SDHI0 VccQ";
> > +regulator-min-microvolt =3D <1800000>;
> > +regulator-max-microvolt =3D <3300000>;
> > +
> > +gpios =3D <&gpio3 13 GPIO_ACTIVE_HIGH>;
> > +gpios-states =3D <1>;
> > +states =3D <3300000 1
> > +  1800000 0>;
> > +};
> >  };
> >
> >  &extal_clk {
> > @@ -37,6 +61,18 @@
> >  groups =3D "scif2_data_a";
> >  function =3D "scif2";
> >  };
> > +
> > +sdhi0_pins: sd0 {
> > +groups =3D "sdhi0_data4", "sdhi0_ctrl";
> > +function =3D "sdhi0";
> > +power-source =3D <3300>;
> > +};
> > +
> > +sdhi0_pins_uhs: sd0_uhs {
> > +groups =3D "sdhi0_data4", "sdhi0_ctrl";
> > +function =3D "sdhi0";
> > +power-source =3D <1800>;
> > +};
> >  };
> >
> >  &scif2 {
> > @@ -45,3 +81,17 @@
> >
> >  status =3D "okay";
> >  };
> > +
> > +&sdhi0 {
> > +pinctrl-0 =3D <&sdhi0_pins>;
> > +pinctrl-1 =3D <&sdhi0_pins_uhs>;
> > +pinctrl-names =3D "default", "state_uhs";
> > +
> > +vmmc-supply =3D <&vcc_sdhi0>;
> > +vqmmc-supply =3D <&vccq_sdhi0>;
> > +cd-gpios =3D <&gpio3 12 GPIO_ACTIVE_LOW>;
> > +bus-width =3D <4>;
> > +sd-uhs-sdr50;
> > +sd-uhs-sdr104;
> > +status =3D "okay";
> > +};
> > --
> > 2.7.4
> >



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
