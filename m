From: Holger Schurig <holgerschurig@gmail.com>
Subject: Re: CAN question: how to trace frame errors?
Date: Fri, 12 Jun 2015 12:01:07 +0200
Message-ID: <CAOpc7mH-xD+eesJNjhpFwUSeMwGCdsRK8Q9AZSjmE2uw=cBgsw@mail.gmail.com>
References: <CAOpc7mFv6ePXqkCZxRkCOC+BuY-PC14nAopZyFpEKHvj5gN_tw@mail.gmail.com>
	<557AA7BE.6040004@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:33092 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755218AbbFLKBI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 12 Jun 2015 06:01:08 -0400
Received: by wgez8 with SMTP id z8so21075607wge.0
        for <linux-can@vger.kernel.org>; Fri, 12 Jun 2015 03:01:07 -0700 (PDT)
In-Reply-To: <557AA7BE.6040004@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

> These are probably RX-FIFO overrun errors:

You're right.

13:03:16 kernel: ##HS flexcan_irq FIFO overrun

That really puzzles me. The errors occured originally when someuse
used a Kvazer to generate 80% load at 500 kB/s. In my tests, I used 1
MB/s and cangen (no Kvazer here). The i.MX6 was otherwise idle:

root@left:~# uptime
 13:08:43 up 20 min,  2 users,  load average: 0.00, 0.01, 0.03
