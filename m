From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [PATCH 1/3] can: m_can: add Bosch M_CAN controller support
Date: Thu, 3 Jul 2014 16:48:05 +0800
Message-ID: <20140703084803.GA11012@shlinux1.ap.freescale.net>
References: <1403863246-18822-1-git-send-email-b29396@freescale.com>
 <1403863246-18822-2-git-send-email-b29396@freescale.com>
 <53ADB1E8.1030504@hartkopp.net>
 <20140630082622.GB25689@shlinux1.ap.freescale.net>
 <53B4473B.2050003@hartkopp.net> <53B459C3.6070807@pengutronix.de>
 <20140703034839.GA20450@shlinux1.ap.freescale.net>
 <53B50271.8070307@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn1blp0185.outbound.protection.outlook.com ([207.46.163.185]:13184
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932212AbaGCItH (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 3 Jul 2014 04:49:07 -0400
Content-Disposition: inline
In-Reply-To: <53B50271.8070307@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, wg@grandegger.com, devicetree@vger.kernel.org

On Thu, Jul 03, 2014 at 09:12:49AM +0200, Marc Kleine-Budde wrote:
> On 07/03/2014 05:48 AM, Dong Aisheng wrote:
> > On Wed, Jul 02, 2014 at 09:13:07PM +0200, Marc Kleine-Budde wrote:
> >> On 07/02/2014 07:54 PM, Oliver Hartkopp wrote:
> >>> I'm not really familiar with the naming concept in device trees.
> >>>
> >>> What is your opinion about the remarks below?
> >>
> >> The entries in the DT, at least on freescale baords, follow the naming
> >> scheme of the reference manual. E.g. on the mx25 it's can1 and can2:
> >>
> >>     can1: can@43f88000 { ... }
> >>     can2: can@43f8c000 { ... }
> >>
> >> And on the mx28, its:
> >>
> >>     can0: can@80032000 { ... }
> >>     can1: can@80034000 { ... }
> >>
> >> Because the imx25 datasheet uses a "1" based counting scheme, while the
> >> imx28 uses a "0" based one.
> >>
> >> So it's best practise to follow the naming and numbering scheme of the
> >> hardware reference manual.....and if you have access to the
> >> documentation of the m_can core, use clock names of the m_can core for
> >> the clock-names property.
> >>
> > 
> > Based on my knowledge, device tree allows define phandle name according to
> > the real device name of HW according spec while the device node name should
> > be general(e.g can@80032000 rather than flexcan@80032000).
> > For imx6sx, there are already following entries in
> > arch/arm/boot/dts/imx6sx.dtsi
> > flexcan1: can@02090000 {...}
> > flexcan2: can@02094000 {...}
> > So i'd prefer to define as:
> > m_can1: canfd@020e8000 {...}
> > m_can2: canfd@020f0000 {...}
> > 
> > 
> > One problem is there're can alias already.
> > aliases {
> > 	can0 = &flexcan1;
> > 	can1 = &flexcan2;
> > 	...
> > }
> > I'm not sure adding can2&can3 for mcan is properly:
> > aliases {
> > 	can0 = &flexcan1;
> > 	can1 = &flexcan2;
> > 	can2 = &m_can1;
> > 	can3 = &m_can2;
> > 	...
> > }
> > Since the m_can driver does not need to use aliases,
> > so i will not add them.
> 
> IMHO It's fine too add the can{2,3} aliases to m_can, too.
> 

I think the main problem for doing this way is that the meaning of id
return by of_alias_get_id may be not persistent.
e.g
For MX6SX
aliases {
	can0 = &flexcan1;
	can1 = &flexcan2;
	can2 = &m_can1;
	can3 = &m_can2;
	...
}

For other platform, it could be:
aliases {
	can0 = &m_can1;
	can1 = &m_can2;
	...
}
It's hard for driver to use.

And actually the M_CAN driver does not need to use the alias.
So i wonder if it makes sense to add the alias for m_can devices
like that.

Regards
Dong Aisheng

> Marc
> 
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 


