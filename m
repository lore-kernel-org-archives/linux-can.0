From: Chris Paterson <Chris.Paterson2@renesas.com>
Subject: RE: [PATCH 0/3] arm64: dts: r8a7796: Add CAN/CAN FD support
Date: Thu, 24 Nov 2016 14:25:06 +0000
Message-ID: <HK2PR0601MB1329C747CA5C6B5222C02C3FB7B60@HK2PR0601MB1329.apcprd06.prod.outlook.com>
References: <1479903243-1860-1-git-send-email-chris.paterson2@renesas.com>
 <f358442c-8373-328c-1270-709498c133f5@pengutronix.de>
 <20161123142938.GF9057@verge.net.au>
 <HK2PR0601MB132929329C3574A0B4D9A0EAB7B60@HK2PR0601MB1329.apcprd06.prod.outlook.com>
 <20161124101733.GA18027@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:54966 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965482AbcKXOZM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Nov 2016 09:25:12 -0500
In-Reply-To: <20161124101733.GA18027@verge.net.au>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Simon Horman <horms@verge.net.au>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Simon,

From: Simon Horman [mailto:horms@verge.net.au]
Sent: 24 November 2016 10:18
> Hi Chris,
>=20
> On Thu, Nov 24, 2016 at 10:05:08AM +0000, Chris Paterson wrote:
> > Hello Simon,
> >
> > From: Simon Horman [mailto:horms@verge.net.au]
> > Sent: 23 November 2016 14:30
> > > On Wed, Nov 23, 2016 at 02:18:13PM +0100, Marc Kleine-Budde wrote:
> > > > On 11/23/2016 01:14 PM, Chris Paterson wrote:
> > > > > This patch series adds CAN and CAN FD support to the r8a7796.
> > > > >
> > > > > Based on renesas-devel-20161122-v4.9-rc6.
> > > > >
> > > > > Chris Paterson (3):
> > > > >   arm64: dts: r8a7796: Add CAN external clock support
> > > > >   arm64: dts: r8a7796: Add CAN support
> > > > >   arm64: dts: r8a7796: Add CAN FD support
> > > > >
> > > > >  .../devicetree/bindings/net/can/rcar_can.txt       | 12 +++--
> > > > >  .../devicetree/bindings/net/can/rcar_canfd.txt     | 12 +++--
> > > > >  arch/arm64/boot/dts/renesas/r8a7796.dtsi           | 61
> > > ++++++++++++++++++++++
> > > > >  3 files changed, 75 insertions(+), 10 deletions(-)
> > > >
> > > > For all three:
> > > >
> > > > Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > > >
> > > > Who takes this series?
> > >
> > > I would like to see these patches split up so that the
> > > .../devicetree/bindings/ portions can go through you whole the
> > > arch/arm64/boot/dts/renesas/ portions go thorugh my renesas tree.
> >
> > Okay, will do.
>=20
> Thanks.
>=20
> > > Regarding the arch/arm64/boot/dts/renesas/ portion, I would like
> > > some consideration given to what effect enabling memory above 4Gb
> > > (64bit
> > > addressing) would have.
> >
> > Can you give me some guidance here? I'm not sure what you're referring
> > to. As far as I know the DT reg definition here is 64-bit, or are you
> > referring to DMA usage? If the later, neither CAN driver uses DMA.
>=20
> Sorry for not being clearer.
>=20
> What I would like to know is if there are any problems in the CAN driver =
or
> hardware that would prevent it from functioning with memory that requires
> 64bit addressing present.
>=20
> If the CAN hardware cannot use DMA then DMA doesn't need to be taken
> into account. But if it DMA could be enabled in future for CAN, for examp=
le
> after some driver enhancements, then it would be good to know if 64bit
> memory can be supported - if not it would imply DMA cannot be enabled.

Thank you for the clarification.

The CAN interface for r8a7795/6 does not support DMA.

With CAN FD there is currently a H/W issue that means DMA is unusable. Pote=
ntially this issue could be fixed in the future and DMA support could be ad=
ded to the driver. If this happens I can see no reason why the CAN FD IP wo=
uldn't be able to handle DMA transfers when using 64bit addressing.

>=20
> As for non-DMA mode, will this function if memory above 4G is present?
> If not then in theory such memory couldn't be enabled if the CAN driver i=
s
> enabled. This is my main concern.

Yes, it functions fine. We have already tested this with the Renesas v3.3.2=
 BSP with >4Gb memory.

If this is explanation okay for you, I'll proceed with a v2 splitting off t=
he DT bindings documentation.

Kind regards, Chris

>=20
> Does the above help?
