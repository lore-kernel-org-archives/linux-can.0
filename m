From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [PATCH v5 5/5] can: move can_stats.bus_off++ from can_bus_off into
 can_change_state
Date: Mon, 8 Dec 2014 11:39:29 +0000
Message-ID: <20141208113929.27703.12971@shannon>
References: <470b7276-2306-4075-814b-7ebd624903dc@GRBSR0089.marel.net>
 <5484B56E.10607@pengutronix.de> <20141208104427.22521.6595@shannon>
 <4163e3170207c529ee01185f156a5240@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db3on0064.outbound.protection.outlook.com ([157.55.234.64]:44081
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752111AbaLHLje convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 8 Dec 2014 06:39:34 -0500
In-Reply-To: <4163e3170207c529ee01185f156a5240@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Quoting Wolfgang Grandegger (2014-12-08 11:24:41)
> On Mon, 8 Dec 2014 10:44:27 +0000, Andri Yngvason
> <andri.yngvason@marel.com> wrote:
> > Quoting Marc Kleine-Budde (2014-12-07 20:15:42)
> >> On 12/03/2014 06:54 PM, Andri Yngvason wrote:
> >> > In order to be able to move the stats increment from can_bus_off()
> into
> >> > can_change_state(), the increment had to be moved back into code that
> >> > was using
> >> > can_bus_off() but not can_change_state().
> >> > 
> >> > Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
> >> > ---
> >> >  drivers/net/can/bfin_can.c                  | 1 +
> >> >  drivers/net/can/c_can/c_can.c               | 1 +
> >> >  drivers/net/can/cc770/cc770.c               | 1 +
> >> >  drivers/net/can/dev.c                       | 3 ++-
> >> >  drivers/net/can/m_can/m_can.c               | 1 +
> >> >  drivers/net/can/pch_can.c                   | 1 +
> >> >  drivers/net/can/rcar_can.c                  | 1 +
> >> >  drivers/net/can/softing/softing_main.c      | 1 +
> >> >  drivers/net/can/spi/mcp251x.c               | 1 +
> >> >  drivers/net/can/ti_hecc.c                   | 1 +
> >> >  drivers/net/can/usb/ems_usb.c               | 1 +
> >> >  drivers/net/can/usb/esd_usb2.c              | 1 +
> >> >  drivers/net/can/usb/peak_usb/pcan_usb.c     | 1 +
> >> >  drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 1 +
> >> >  drivers/net/can/usb/usb_8dev.c              | 1 +
> >> >  15 files changed, 16 insertions(+), 1 deletion(-)
> >> 
> >> What about:
> >> 
> >> > drivers/net/can/c_can/c_can.c-910-            cf->can_id |=
> >> > CAN_ERR_BUSOFF;
> >> > drivers/net/can/c_can/c_can.c:911:            can_bus_off(dev);
> >> 
> > State changes are counted in the switch above. See line 869.
> > However, can_bus_off() is called in both of those swiches. Is this a
> bug?
> 
> Yes, the first one should be replaced with
> "priv->can.can_stats.bus_off++".
> 
Ok, I'll just remove the first can_bus_off() then.
>
> >> > drivers/net/can/janz-ican3.c-1010-                    cf->can_id |=
> >> > CAN_ERR_BUSOFF;
> >> > drivers/net/can/janz-ican3.c:1011:                   
> can_bus_off(dev);
> >> 
> > Line 1024. It was there before. That's a bug. This patch actually fixes
> > it. ;)
> 
> At this line "bus_error" is counted:
> 
> http://lxr.free-electrons.com/source/drivers/net/can/janz-ican3.c#L1024
>
Agh, I seem to be having a bad case of the Mondays... 
> 
> >> > drivers/net/can/xilinx_can.c-560-             priv->write_reg(priv,
> >> > XCAN_SRR_OFFSET, XCAN_SRR_RESET_MASK);
> >> > drivers/net/can/xilinx_can.c:561:             can_bus_off(ndev);
> >> 
> > Line 557. Same as for the janz.
> 
> This one is (or was after your patch) wrong. It does not need a fix,
> indeed.
> 
> It's fine for me if you just mention the bug fixes in the commit message.
Ok, I'll add the count to the janz, remove the first can_bus_off() in c_can and
do nothing for xilinx. I'll mention that this fixes bugs in c_can and xilinx.

Thanks,
Andri
