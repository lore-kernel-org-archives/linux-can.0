From: Mohamed HAMZAOUI <requinham@gmail.com>
Subject: Re: [SocketCan] Problem of accuracy
Date: Mon, 9 Jul 2012 17:39:13 +0200
Message-ID: <CABMxt4iBB4aP6STAbYcgCYyvOx-JAPnP48P1k=EMGsjQPmWN-Q@mail.gmail.com>
References: <CABMxt4ijuTMYFYXx0n4AYBO6-=SRD0U3F4BTA2=rWE80Z4-yOA@mail.gmail.com>
	<201207091519.04235.pisa@cmp.felk.cvut.cz>
	<20120709144042.GA2671@vandijck-laurijssen.be>
	<23562188.349Ls0e8RT@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63904 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710Ab2GIPjO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Jul 2012 11:39:14 -0400
Received: by yhmm54 with SMTP id m54so10989640yhm.19
        for <linux-can@vger.kernel.org>; Mon, 09 Jul 2012 08:39:13 -0700 (PDT)
In-Reply-To: <23562188.349Ls0e8RT@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Kurt Van Dijck <kurt.van.dijck@eia.be>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Wolfgang Grandegger <wg@grandegger.com>, Linux-CAN <linux-can@vger.kernel.org>

> I compared itimer with clock_nanosleep on an ARM board and noticed the signal
> overhead of itimer is much bigger, resulting in a higher CPU usage, than
> clock_nanosleep upon hrtimer.
> So I ended up using clock_nanosleep adding a constant to the last timeout.

but my problem is that when i specify 1 ms of period i have 1.3ms and
the problem is how to eliminate the 0.3ms. If i substitute 0.3 ms from
all payload, what's the assurance that it does not change with CPU
load  change ?

Regards,
Mohamed
