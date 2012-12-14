From: Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: tx/rx LED trigger support
Date: Fri, 14 Dec 2012 17:31:22 +0100
Message-ID: <20121214163122.GA20128@balto.lan>
References: <50CB1618.3040805@pengutronix.de>
 <20121214121649.GA13906@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:42447 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755599Ab2LNQbi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 14 Dec 2012 11:31:38 -0500
Received: by mail-wi0-f180.google.com with SMTP id hj13so634728wib.1
        for <linux-can@vger.kernel.org>; Fri, 14 Dec 2012 08:31:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20121214121649.GA13906@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Kurt Van Dijck <kurt.van.dijck@eia.be>

On Fri, Dec 14, 2012 at 01:16:49PM +0100, Kurt Van Dijck wrote:
>
> I still have pending comments on my last sent patches.
> I must find time to rework some things.
>
> There was a patch to determine if _a_ netdevice is
> actually a can_dev based device (i.e. not slcan or vcan),
> so one can use can_priv.
> That patch is operational and may be usefull for other users
> as well.

Actually if I'm not missing anything we were at a point where we just
missed the safe led-rename function, which I has been accepted in the
meantime and is in LED maintainer's -next branch with a pending pull
request.

I was planning to wait for the merge of that patch, rebase all patches,
retest and send the whole series to the list again, is that ok for you?

Thanks,
Fabio

-- 
Fabio Baltieri
