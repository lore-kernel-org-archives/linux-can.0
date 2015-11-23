From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 crash after receiving BAM frame and no DT frame
Date: Mon, 23 Nov 2015 21:09:23 +0100
Message-ID: <20151123200923.GA4556@airbook.vandijck-laurijssen.be>
References: <loom.20151120T162359-379@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway02.edpnet.net ([212.71.1.211]:59085 "EHLO
	relaygateway02.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413AbbKWUJm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 23 Nov 2015 15:09:42 -0500
Content-Disposition: inline
In-Reply-To: <loom.20151120T162359-379@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: laurent vaudoit <laurent.vaudoit@gmail.com>
Cc: linux-can@vger.kernel.org

> Hi all,
> i'm facing some issue on my imx6 board, with j1939 patch.
> 
> i setup my can interface with ip link command
> and then i setup this interface in j1939
> 
> ip link set can0 up type can bitrate 250000
> ip link set can0 j1939 on
> 
> and after i launch a candump on can0 
> 
> On can0, i play an can bus trace (logged from a vehicule).
> at the end of the trace, i have a bam frame without the DT frame associated
> 
> on the console, i see the log
> 1939tprx_task timeout on 2 (it seems normal)
> and after, i have a rando crash of my system (not in can stuffs, sometimes 
> a reset, sometimes nand driver...)
> 
> if i remove the BAM frame, problem does not appear.
> if i do not set can0 j1939 on, problem does not appear
> so it seems the problem is related to j1939 timeout

I was not in a position to reproduce your scenario.

I suspect a locking mistake of mine.
Can you try this patch?

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 5c0bdc5..0bc1edb 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -166,9 +166,9 @@ static void put_session(struct session *session)
 	tasklet_disable_nosync(&session->txtask);
 
 	if (in_interrupt()) {
-		spin_lock_bh(&s.del.lock);
+		spin_lock(&s.del.lock);
 		list_add_tail(&session->list, &s.del.sessionq);
-		spin_unlock_bh(&s.del.lock);
+		spin_unlock(&s.del.lock);
 		schedule_work(&s.del.work);
 	} else {
 		/* destroy session right here */

--

You may also enable CONFIG_DEBUG_SPINLOCK

> 
> Is someone yet encountered this problem?
> 
> my kernel is a 3.10 kernel, with j1939 patch
> 
> Thanks in advance
> Best regards
> 
> Laurent
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
