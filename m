From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can-utils: AOSP build improvements
Date: Mon, 18 Feb 2013 22:56:19 +0100
Message-ID: <5122A383.7040804@hartkopp.net>
References: <1361174819-3168-1-git-send-email-yegorslists@googlemail.com> <5121E30E.1050305@pengutronix.de> <CAGm1_ks1qZkaE0UGMV2F9ooFrziMNb3JAtcqMW1AWX7VSP9Teg@mail.gmail.com> <5121F27F.9020102@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:8627 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756461Ab3BRV4X (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Feb 2013 16:56:23 -0500
In-Reply-To: <5121F27F.9020102@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Yegor Yefremov <yegorslists@googlemail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Michal Sojka <sojkam1@fel.cvut.cz>

On 18.02.2013 10:21, Marc Kleine-Budde wrote:

> On 02/18/2013 10:10 AM, Yegor Yefremov wrote:


>>
>> Btw what about isotp.h? Is it going to be mainlined?
> 
> That's Oliver's cup of tea :)


Hm - yes :-)

Of course it is going to be mainlined.

The code itself is working properly for a long time now. The only missing
point is that i do not have a really good idea how to cope with the fact that
up to 500 CAN frames can be pushed into the CAN netdev tx queue at a time.

The advisory to increase the tx_queue_len to 1000 is not a solution.

Maybe qdiscs is a solution or we need to be able to peek the tx queue state
whether we can push the next CAN frame to the device, or if we need to wait.

Once there is a good solution for that, it should be easy to make isotp fit
for mainline inclusion.

Regards,
Oliver

