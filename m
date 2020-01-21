From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: general protection fault in can_rx_register
Date: Tue, 21 Jan 2020 21:34:24 +0100
Message-ID: <20200121203424.GF13462@x1.vandijck-laurijssen.be>
References: <00000000000030dddb059c562a3f@google.com>
 <55ad363b-1723-28aa-78b1-8aba5565247e@hartkopp.net>
 <20200120091146.GD11138@x1.vandijck-laurijssen.be>
 <CACT4Y+a+GusEA1Gs+z67uWjtwBRp_s7P4Wd_SMmgpCREnDu3kg@mail.gmail.com>
 <8332ec7f-2235-fdf6-9bda-71f789c57b37@hartkopp.net>
 <2a676c0e-20f2-61b5-c72b-f51947bafc7d@hartkopp.net>
 <20200121192248.GC13462@x1.vandijck-laurijssen.be>
 <9a6be054-ac52-761d-83f0-809ec80e7764@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b02.edpnet.be ([212.71.1.222]:55085 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgAUUe3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 21 Jan 2020 15:34:29 -0500
Content-Disposition: inline
In-Reply-To: <9a6be054-ac52-761d-83f0-809ec80e7764@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Dmitry Vyukov <dvyukov@google.com>, Marc Kleine-Budde <mkl@pengutronix.de>, o.rempel@pengutronix.de, syzbot <syzbot+c3ea30e1e2485573f953@syzkaller.appspotmail.com>, linux-can@vger.kernel.org

On di, 21 jan 2020 21:03:42 +0100, Oliver Hartkopp wrote:
> Hi Kurt,
...
> 
> Yes. That's really weird as is just has an impact on the socket API. But it
> should not have any impact on the CAN_RAW socket they are using.
> 
> Hm - in fact is has an impact on the socket API.
> Before the patch the user space was able to send 16 bytes to the CAN_RAW
> socket. Now it's only 8 byte as you reduced the required size.

Nack,
the CAN_REQUIRED_SIZE is applied on struct sockaddr_can only, to guard
against breaking ABI with the upcoming addition of j1939 fields.

But where in the past, the tp members where necessary but unused, they
are now optional and still unused, in both raw_bind and raw_sendmsg.

But this does not propagate to sk_buff, so I could not find how it
changes anything that worked before into a crash.

> 
> Regards,
> Oliver
> 
