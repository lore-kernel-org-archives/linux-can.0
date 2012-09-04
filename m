From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH 1/4] can: c_can: Adopt pinctrl support
Date: Tue, 4 Sep 2012 08:34:11 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA26482@DBDE01.ent.ti.com>
References: <1346673139-14540-1-git-send-email-anilkumar@ti.com>
 <1346673139-14540-2-git-send-email-anilkumar@ti.com>
 <5045161C.4000100@pengutronix.de>
 <331ABD5ECB02734CA317220B2BBEABC13EA2630A@DBDE01.ent.ti.com>
 <5045B0D9.6060003@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39518 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753389Ab2IDIed convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Sep 2012 04:34:33 -0400
In-Reply-To: <5045B0D9.6060003@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "tony@atomide.com" <tony@atomide.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Sep 04, 2012 at 13:12:17, Marc Kleine-Budde wrote:
> On 09/04/2012 08:14 AM, AnilKumar, Chimata wrote:
> > Hi Marc,
> > 
> > On Tue, Sep 04, 2012 at 02:12:04, Marc Kleine-Budde wrote:
> >> On 09/03/2012 01:52 PM, AnilKumar Ch wrote:
> >>> Adopt pinctrl support to c_can driver based on c_can device
> >>> pointer, pinctrl driver configure SoC pins to d_can mode
> >>> according to definitions provided in .dts file.
> >>>
> >>> In device specific device tree file 'pinctrl-names = "default";'
> >>> and 'pinctrl-0 = <&d_can1_pins>;' needs to add to configure pins
> >>> from c_can driver. d_can1_pins node contains the pinmux/config
> >>> details of d_can L/H pins.
> >>
> >> Looks good, is the pinctrl property documented in the dt bindings already?
> >>
> > 
> > Yes, its here Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
> 
> Sorry, I meant not the generic pinctrl, but the c_can/d_can bindings
> documentation (Documentation/devicetree/bindings/net/can/).
> 

No, I have not included because those are pinctrl driver specific
bindings. If the SoC supports pinmux/conf feature then those should
be added according to pinctrl driver. If the SoC is not supported pinmux/config then this configuration is not required.

Thanks
AnilKumar
