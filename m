From: Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] can: add tx/rx LED trigger support
Date: Tue, 24 Apr 2012 21:10:50 +0200
Message-ID: <20120424191050.GB1589@gmail.com>
References: <1335214966-20478-1-git-send-email-fabio.baltieri@gmail.com>
 <4F963736.4040602@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:33794 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757036Ab2DXTJD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Apr 2012 15:09:03 -0400
Received: by wejx9 with SMTP id x9so634512wej.19
        for <linux-can@vger.kernel.org>; Tue, 24 Apr 2012 12:09:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F963736.4040602@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

On Tue, Apr 24, 2012 at 07:16:38AM +0200, Oliver Hartkopp wrote:
> On 23.04.2012 23:02, Fabio Baltieri wrote:
> 
> > This patch implements the functions to add two LED triggers, named
> > <ifname>-tx and <ifname>-rx, to a canbus device driver.
> 
> 
> Hello Fabio,

Hi Oliver,

> to me it looks really good now. I understand everything of the idea at first
> sight which is a good indicator for simple code ;-)

Thanks!

> The only remark i currently have is ...
> 
> > 
> > diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> > index bb709fd..74d6bfb 100644
> > --- a/drivers/net/can/Kconfig
> > +++ b/drivers/net/can/Kconfig
> > @@ -54,6 +54,19 @@ config CAN_CALC_BITTIMING
> >  	  arguments "tq", "prop_seg", "phase_seg1", "phase_seg2" and "sjw".
> >  	  If unsure, say Y.
> >  
> > +config CAN_LEDS
> > +	bool "Enable LED triggers for Netlink based drivers"
> > +	depends on CAN
> 
> 
> CAN_DEV and this entire Kconfig content itself depends on CAN (see at the top
> of this Kconfig) so you can omit that line.

You're right, that was a leftover from the v1.

Removed for v3.

Regards,
Fabio
