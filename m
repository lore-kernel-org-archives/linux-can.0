From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] can: Use correct type in sizeof() in nla_put()
Date: Fri, 30 Oct 2015 15:24:58 +0100
Message-ID: <201510301524.58411.marex@denx.de>
References: <1446209299-6250-1-git-send-email-marex@denx.de> <201510301501.28536.marex@denx.de> <56337C08.40001@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:54329 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428AbbJ3OZA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 30 Oct 2015 10:25:00 -0400
In-Reply-To: <56337C08.40001@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, netdev@vger.kernel.org

On Friday, October 30, 2015 at 03:17:44 PM, Marc Kleine-Budde wrote:
> On 10/30/2015 03:01 PM, Marek Vasut wrote:
> > On Friday, October 30, 2015 at 02:40:26 PM, Marc Kleine-Budde wrote:
> >> On 10/30/2015 01:48 PM, Marek Vasut wrote:
> >>> The sizeof() is invoked on an incorrect variable, likely due to some
> >>> copy-paste error, and this might result in memory corruption. Fix this.
> >>> 
> >>> Signed-off-by: Marek Vasut <marex@denx.de>
> >>> Cc: Wolfgang Grandegger <wg@grandegger.com>
> >>> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> >>> Cc: netdev@vger.kernel.org
> >> 
> >> Applies to can and added stable on Cc.
> > 
> > Are you absolutelly positive this doesn't break kernel ABI please ?
> > 
> > I am a little worried there, since the size of can_clock and can_ctrlmode
> > structures differ.
> 
> struct can_clock is a u32, see [1]
> struct can_ctrlmode is 2 x u32.
> 
> in libsocketcan[2] it's accessed like this:
> > 	memcpy(res,
> > 	
> > 		RTA_DATA(can_attr[IFLA_CAN_CLOCK]),
> > 		sizeof(struct can_clock));
> 
> I think it should be ok.

In that case, yes, it's good. Hopefully, noone wrote his own thing.

Best regards,
Marek Vasut
