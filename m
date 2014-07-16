From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [PATCH v5 1/2] can: m_can: add device tree binding
 documentation
Date: Wed, 16 Jul 2014 18:40:54 +0800
Message-ID: <20140716104054.GB20184@shlinux1.ap.freescale.net>
References: <1405503050-16796-1-git-send-email-b29396@freescale.com>
 <53C64E51.9050606@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-by2lp0237.outbound.protection.outlook.com ([207.46.163.237]:3681
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754376AbaGPKqQ (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 16 Jul 2014 06:46:16 -0400
Content-Disposition: inline
In-Reply-To: <53C64E51.9050606@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, wg@grandegger.com, socketcan@hartkopp.net, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, mark.rutland@arm.com, varkabhadram@gmail.com, robh+dt@kernel.org, grant.likely@linaro.org

On Wed, Jul 16, 2014 at 12:05:05PM +0200, Marc Kleine-Budde wrote:
> On 07/16/2014 11:30 AM, Dong Aisheng wrote:
> > add M_CAN device tree binding documentation
> > 
> > Cc: Wolfgang Grandegger <wg@grandegger.com>
> > Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Oliver Hartkopp <socketcan@hartkopp.net>
> > Cc: Varka Bhadram <varkabhadram@gmail.com>
> > Signed-off-by: Dong Aisheng <b29396@freescale.com>
> > ---
> > Changes since v4:
> > - change the name of board dtsi to board dts which is more common
> > 
> > Changes since v3:
> > - change mram-cfg property name to bosch,mram-cfg
> > - indent change
> > ---
> >  .../devicetree/bindings/net/can/m_can.txt          |   67 ++++++++++++++++++++
> >  1 files changed, 67 insertions(+), 0 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/net/can/m_can.txt
> 
> I'll apply this series once we've got an Ack for the DT folks.
> 

Okay, thanks!

Copy Grant, Rob and Mark in case they have comments.

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


