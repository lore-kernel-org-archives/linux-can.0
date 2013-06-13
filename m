From: Mirza Krak <mirza.krak@hostmobility.com>
Subject: Dual SJA1000 can controllers on SMP system.
Date: Thu, 13 Jun 2013 14:47:29 +0200
Message-ID: <51B9BF61.8050905@hostmobility.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:45529 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754884Ab3FMMre (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 13 Jun 2013 08:47:34 -0400
Received: by mail-la0-f54.google.com with SMTP id ec20so8980875lab.13
        for <linux-can@vger.kernel.org>; Thu, 13 Jun 2013 05:47:32 -0700 (PDT)
Received: from [192.168.0.85] (static-92-33-5-210.sme.bredbandsbolaget.se. [92.33.5.210])
        by mx.google.com with ESMTPSA id t17sm10707318lbd.11.2013.06.13.05.47.30
        for <linux-can@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 13 Jun 2013 05:47:31 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Dear Sirs.

I am running a 3.1.10 kernel on Nvidia Tegra 2 CPU (Dual Core). Not=20
vanilla kernel (Linux4Tegra).

We are using dual can controllers connected on th external data bus on=20
our custom hardware. The can controllers are SJA1000.

Driver that is used is vanilla sja1000 driver (sja1000.c)

Now to the issue at hand. Will try my best to explain our scenario and=20
issue:
     1. The two can controllers are connected with each other with a=20
loop-back.
     2. What we are attempting is to send data on both controllers in=20
two separate processes. We are using following command "cansequence can=
0=20
-p &" and "cansequence can1 -p &". With a bit-rate configured to 1 Mbit=
/s.
     3. What we see when we attempt the above is that one of the=20
controllers stop sending and the software buffer gets filled up. When i=
t=20
stops varies but usually after a few packets are sent.

After some digging we came to this conclusion. The two cansequence=20
processes end up on different CPU cores. The process that ends up in=20
CPU1 is the one that always stops transmitting.

Workarounds that we have seen that works is
     1. Disable dual core with kernel argument "maxcpus=3D1".
     2. Forcing the cansequence processes to CPU0 with "taskset" comman=
d.

My question to you is if anyone has tested the SJA1000 driver on an SMP=
=20
system or anything similar.
--=20
Med V=E4nliga H=E4lsningar / Best Regards
Mirza

*******************************************************************
Mirza Krak
Host Mobility AB
mirza.krak@hostmobility.com
Anders Personsgatan 12, 416 64 G=F6teborg
Sweden
www.hostmobility.com <http://www.hostmobility.com>
Direct: +46 31 31 32 704
Phone: +46 31 31 32 700
=46ax: +46 31 80 67 51
Mobile: +46 730 28 06 22
*******************************************************************

