From: Drew Fustini <drew@beagleboard.org>
Subject: Re: isotp in mainline?
Date: Fri, 12 Jun 2020 17:36:41 +0200
Message-ID: <20200612153641.GA3433528@x1>
References: <20200611154337.GA3166627@x1>
 <9d3bcfde-68f3-c9e0-4c63-cbae61915585@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLPgr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 12 Jun 2020 11:36:47 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D380DC03E96F
        for <linux-can@vger.kernel.org>; Fri, 12 Jun 2020 08:36:45 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j10so10179539wrw.8
        for <linux-can@vger.kernel.org>; Fri, 12 Jun 2020 08:36:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9d3bcfde-68f3-c9e0-4c63-cbae61915585@posteo.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Patrick Menschel <menschel.p@posteo.de>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>

On Fri, Jun 12, 2020 at 03:47:45PM +0200, Patrick Menschel wrote:
> Hi Drew,
> 
> > Is there a current effort to get the isotp driver accepted into mainline?
> 
> I believe ISOTP has been mainline for quite a while.
> 
> I remember writing a test script when Python 3.7 came out in Aug 2018
> and added the isotp socket type to socket class [1].
> 
> I tested on a X86_64 machine with Ubuntu 18.04 LTS, so it must have been
> mainline at that time.
> 
> Regards,
> Patrick
> 
> [1]
> https://docs.python.org/3.7/library/socket.html?highlight=socket#socket.CAN_ISOTP
>

Hi Patrick,

Maybe it was just to a test to see if the the protocol type existed?

It does look like the protocol is defined in include/uapi/linux/can.h:

#define CAN_ISOTP	6 /* ISO 15765-2 Transport Protocol */

However, there does not appear to be any implementation in the mainline
kernel.

I recall Oliver mentioning that he should try to mainline isotp modules
at the end of the J1939 talk at ELC-E last October [1]. I don't see any
posts regarding isotp in the linux-can archives since then, so I thought
I would bring it up.

Thanks,
Drew

[0] https://elixir.bootlin.com/linux/v5.7/source/include/uapi/linux/can.h#L159
[1] https://youtu.be/3NfN8B4-w8w?t=2052
