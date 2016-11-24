From: Chris Paterson <Chris.Paterson2@renesas.com>
Subject: RE: [PATCH 0/3] arm64: dts: r8a7796: Add CAN/CAN FD support
Date: Thu, 24 Nov 2016 10:05:08 +0000
Message-ID: <HK2PR0601MB132929329C3574A0B4D9A0EAB7B60@HK2PR0601MB1329.apcprd06.prod.outlook.com>
References: <1479903243-1860-1-git-send-email-chris.paterson2@renesas.com>
 <f358442c-8373-328c-1270-709498c133f5@pengutronix.de>
 <20161123142938.GF9057@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:19220 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S936459AbcKXKFP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Nov 2016 05:05:15 -0500
In-Reply-To: <20161123142938.GF9057@verge.net.au>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Simon Horman <horms@verge.net.au>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Simon,

From: Simon Horman [mailto:horms@verge.net.au]
Sent: 23 November 2016 14:30
> On Wed, Nov 23, 2016 at 02:18:13PM +0100, Marc Kleine-Budde wrote:
> > On 11/23/2016 01:14 PM, Chris Paterson wrote:
> > > This patch series adds CAN and CAN FD support to the r8a7796.
> > >
> > > Based on renesas-devel-20161122-v4.9-rc6.
> > >
> > > Chris Paterson (3):
> > >   arm64: dts: r8a7796: Add CAN external clock support
> > >   arm64: dts: r8a7796: Add CAN support
> > >   arm64: dts: r8a7796: Add CAN FD support
> > >
> > >  .../devicetree/bindings/net/can/rcar_can.txt       | 12 +++--
> > >  .../devicetree/bindings/net/can/rcar_canfd.txt     | 12 +++--
> > >  arch/arm64/boot/dts/renesas/r8a7796.dtsi           | 61
> ++++++++++++++++++++++
> > >  3 files changed, 75 insertions(+), 10 deletions(-)
> >
> > For all three:
> >
> > Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> >
> > Who takes this series?
>=20
> I would like to see these patches split up so that the .../devicetree/bin=
dings/
> portions can go through you whole the arch/arm64/boot/dts/renesas/
> portions go thorugh my renesas tree.

Okay, will do.

>=20
> Regarding the arch/arm64/boot/dts/renesas/ portion, I would like some
> consideration given to what effect enabling memory above 4Gb (64bit
> addressing) would have.

Can you give me some guidance here? I'm not sure what you're referring to. =
As far as I know the DT reg definition here is 64-bit, or are you referring=
 to DMA usage? If the later, neither CAN driver uses DMA.

Kind regards, Chris
