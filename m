From: Brennan Ashton <bashton@brennanashton.com>
Subject: MCP251x bit rate calculations wrong
Date: Sat, 26 Oct 2013 10:08:01 -0700
Message-ID: <CANQdSEGgf=UiYwKcOyoLA2qmtiF19XaD46_3ZkTHRUXOwe-+yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:36959 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220Ab3JZRIC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 26 Oct 2013 13:08:02 -0400
Received: by mail-wi0-f173.google.com with SMTP id ey11so2285284wid.12
        for <linux-can@vger.kernel.org>; Sat, 26 Oct 2013 10:08:01 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

The bit timing calculations in can-utils are certainly wrong, and
after a quick look at the ones that make up the kernel is appears that
they are not quite right as well.

From the datasheet:
TQ = 2*(BRP-1)/Fosc

Looking at the kernel:

can/dev.c defines best brp as:
182 >---v64 = (u64)best_brp * 1000000000UL;
183 >---do_div(v64, priv->clock.freq);
184 >---bt->tq = (u32)v64;
...
201 >---bt->brp = best_brp;$

so TQ[ns] = BRP/Fosc

in can/mcp251x.c

592 >---mcp251x_write_reg(spi, CNF1, ((bt->sjw - 1) << CNF1_SJW_SHIFT) |
593 >--->--->---  (bt->brp - 1));

This is missing the key /2 factor but does take into account the -1

Now looking at can-calc-bit-timing.c from can-utils:

195 >--->---cnf1 = ((bt->sjw - 1) << 6) | bt->brp;$

This is wrong as it is missing both the -1 and the /2
I have tested this corrected timing  on the MCP2515 at 20MHz Fosc and
20k bitrate.  It worked with the corrected calculations but not
before.

There is a little more work than just adjusting the calculation as the
limits and the best bpr calc must be adjusted for the /2.  I can write
some patches up unless someone thinks I am missing something.

--Brennan Ashton
