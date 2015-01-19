From: Viktor Babrian <babrian.viktor@renyi.mta.hu>
Subject: Re: [PATCH 3.19-rc3] c_can: SIE disabled when berr-reporting is off
 to reduce irq flood
Date: Mon, 19 Jan 2015 12:32:41 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1501191219410.24804@login>
References: <9c72f211-becc-4c0f-94f6-0700dfb1195e@GRBSR0089.marel.net> <alpine.DEB.2.02.1501121751530.28201@login> <1735533.0yOonAfCy1@heinz> <alpine.DEB.2.02.1501121948370.28201@login> <54B472B2.4010300@optusnet.com.au> <alpine.DEB.2.02.1501131523290.12789@login>
 <20150113153243.26859.47218@shannon> <alpine.DEB.2.02.1501181809150.32136@login> <54BBFCAF.2090603@pengutronix.de> <alpine.DEB.2.02.1501181938030.32136@login> <54BC01C5.2070803@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx1.renyi.hu ([193.224.79.18]:56394 "EHLO smtp.renyi.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750850AbbASLcw (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 19 Jan 2015 06:32:52 -0500
In-Reply-To: <54BC01C5.2070803@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Viktor Babrian <babrian.viktor@renyi.mta.hu>, Andri Yngvason <andri.yngvason@marel.com>, Tom Evans <tom_usenet@optusnet.com.au>, linux-can@vger.kernel.org

>> Also note that when the system is flooded by these error interrupts,
>> system performace degrades so much that serial terminal echo becomes
>> annoyingly long. When this happens, I wonder how usable the "accurate"
>> state transition reports are anyway.
>
> As I said, they are vital to some applications. The bus error limiting
> series will follow.

OK. possible compromise is to enable buserr interrupts in Warning state 
only. This way Warning->Passive transition is detected for sure.
Interrupt flood can only occur if error counter could stay between 96 and 
128 which can hardly happen if bus is full of error.
