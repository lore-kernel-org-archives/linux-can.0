From: Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH 1/2] Documentation: can: flexcan: add PE clock source
 property to device tree
Date: Fri, 21 Dec 2018 03:34:16 +0000
Message-ID: <AM0PR04MB42113435FFFF1C01330A35D180B80@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20181213070537.25095-1-qiangqing.zhang@nxp.com>
 <20181213070537.25095-2-qiangqing.zhang@nxp.com>
 <20181220202247.GA26362@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181220202247.GA26362@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-can.vger.kernel.org

> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Friday, December 21, 2018 4:23 AM
>=20
> On Thu, Dec 13, 2018 at 07:07:57AM +0000, Joakim Zhang wrote:
> > From: Dong Aisheng <aisheng.dong@nxp.com>
> >
> > The FlexCAN controller can parse clock source property from DTS file
> > to select PE clock source.
> >
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/net/can/fsl-flexcan.txt | 8
> > ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> > b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> > index bc77477c6878..a04168605998 100644
> > --- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> > +++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> > @@ -32,6 +32,13 @@ Optional properties:
> >  		 ack_gpr is the gpr register offset of CAN stop acknowledge.
> >  		 ack_bit is the bit offset of CAN stop acknowledge.
> >
> > +- fsl,clk-source: Select the clock source to the CAN Protocol Engine (=
PE).
> > +		  It's SoC Implementation dependent. Refer to RM for detailed
>=20
> If SoC dependent, then it should be implied by the SoC specific compatibl=
e.
> Also, seems like you should add clock binding support here if you need mo=
re
> clock control.

The clock source selection is done by a register bit inside the IP block:
BIT13 CLKSRC CAN Engine Clock Source
0b - The CAN engine clock source is the oscillator clock.=20
1b - The CAN engine clock source is the peripheral clock.

Currently it's written 1 by default during driver initialization.
drivers/net/can/flexcan.c
/* select "bus clock", chip must be disabled */
reg =3D priv->read(&regs->ctrl);
reg |=3D FLEXCAN_CTRL_CLK_SRC;
priv->write(reg, &regs->ctrl);

I'm not sure if it's a typical case to abstract CLKSRC bit into a common cl=
ock mux.
(Is there any similar case in kernel?)
But I think we can also use SoC specific compatible to write 0 for those sp=
ecial
Ones (currently only imx8qxp). Then this patch may not be needed.

Marc,
Please let us know if you have a different idea.

Regards
Dong Aisheng

>=20
> > +		  definition. If this property is not set in device tree node
> > +		  then driver selects clock source 1 by default.
> > +		  0: clock source 0 (oscillator clock)
> > +		  1: clock source 1 (peripheral clock)
> > +
> >  Example:
> >
> >  	can@1c000 {
> > @@ -40,4 +47,5 @@ Example:
> >  		interrupts =3D <48 0x2>;
> >  		interrupt-parent =3D <&mpic>;
> >  		clock-frequency =3D <200000000>; // filled in by bootloader
> > +		fsl,clk-source =3D <0>; // select clock source 0 for PE
> >  	};
> > --
> > 2.17.1
> >
