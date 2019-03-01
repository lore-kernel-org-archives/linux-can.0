From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [PATCH 09/11] dt-bindings: can: rcar_can: Fix RZ/G2 CAN clocks
Date: Fri, 1 Mar 2019 11:52:42 +0000
Message-ID: <TYXPR01MB17755AA9CC7835B236626F42C0760@TYXPR01MB1775.jpnprd01.prod.outlook.com>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547663874-29411-10-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1547663874-29411-10-git-send-email-fabrizio.castro@bp.renesas.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Thierry Reding <treding@nvidia.com>, =?iso-8859-2?Q?Andreas_F=E4rber?= <afaerber@suse.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>, Lukasz Majewski <lukma@denx.de>, Michal Simek <monstr@monstr.eu>, =?iso-8859-2?Q?Michal_Vok=E1=E8?= <michal.vokac@ysoft.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Ben Whitten <ben.whitten@gmail.com>, Chris Paterson <Chris.Paterson2@renesas.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.ke>
List-Id: linux-can.vger.kernel.org

Hello Marc,

I am sorry to bother you.
Do you think you can take this patch?

Thanks,
Fab

> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Sent: 16 January 2019 18:38
> Subject: [PATCH 09/11] dt-bindings: can: rcar_can: Fix RZ/G2 CAN clocks
>=20
> According to the latest information, the clock options for CAN on RZ/G2
> are the same as the ones available on R-Car Gen3
>=20
> Fixes: 868b7c0f43e6 ("dt-bindings: can: rcar_can: Add r8a774a1 support")
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> ---
>  Documentation/devicetree/bindings/net/can/rcar_can.txt | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/rcar_can.txt b/Doc=
umentation/devicetree/bindings/net/can/rcar_can.txt
> index 7fcf501..b463e12 100644
> --- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
> +++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
> @@ -28,13 +28,8 @@ Required properties:
>=20
>  - reg: physical base address and size of the R-Car CAN register map.
>  - interrupts: interrupt specifier for the sole interrupt.
> -- clocks: phandles and clock specifiers for 2 CAN clock inputs for RZ/G2
> -	  devices.
> -	  phandles and clock specifiers for 3 CAN clock inputs for every other
> -	  SoC.
> -- clock-names: 2 clock input name strings for RZ/G2: "clkp1", "can_clk".
> -	       3 clock input name strings for every other SoC: "clkp1", "clkp2"=
,
> -	       "can_clk".
> +- clocks: phandles and clock specifiers for 3 CAN clock inputs.
> +- clock-names: 3 clock input name strings: "clkp1", "clkp2", and "can_cl=
k".
>  - pinctrl-0: pin control group to be used for this controller.
>  - pinctrl-names: must be "default".
>=20
> @@ -50,8 +45,7 @@ using the below properties:
>  Optional properties:
>  - renesas,can-clock-select: R-Car CAN Clock Source Select. Valid values =
are:
>  			    <0x0> (default) : Peripheral clock (clkp1)
> -			    <0x1> : Peripheral clock (clkp2) (not supported by
> -				    RZ/G2 devices)
> +			    <0x1> : Peripheral clock (clkp2)
>  			    <0x3> : External input clock
>=20
>  Example
> --
> 2.7.4
