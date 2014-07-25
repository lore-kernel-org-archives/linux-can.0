From: Ssagarr Patil <hugarsagar@outlook.com>
Subject: RE: [PATCH] GNUmakefile.am: include canpump
Date: Fri, 25 Jul 2014 18:21:26 +0530
Message-ID: <BAY176-W43EFA4124209672C38C9DDD3FC0@phx.gbl>
References: <1406285604-20942-1-git-send-email-mkl@pengutronix.de>,<53D23B7A.9050402@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from [65.54.190.166] ([65.54.190.166]:50606 "EHLO
	BAY004-OMC3S28.hotmail.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751654AbaGYMvr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 25 Jul 2014 08:51:47 -0400
In-Reply-To: <53D23B7A.9050402@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver,

> From: socketcan@hartkopp.net
> To: mkl@pengutronix.de; hugarsagar@outlook.com
> CC: linux-can@vger.kernel.org
> Subject: Re: [PATCH] GNUmakefile.am: include canpump
>
> Tnx!
>
> Applied to the canpump tree.
>
> I tried this canpump to check out the recvmmsg() call.
>
> But the most effective performance enhancement seemed to be the update of the
> open coded ASCII conversion in this patch:
>
> https://gitorious.org/linux-can/can-utils/commit/4a68366bac433d9e95fb74147d68d1386d62cc0a
>
> @Sagar: Do you already use the latest can-utils containing these improvements?
>
Yes I am already using this.

Thanks,
--Sagar

 		 	   		  