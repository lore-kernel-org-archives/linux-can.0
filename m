From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 3/3] can: af_can: fix sparse warning for can_rx_alldev_list
Date: Wed, 20 Jun 2012 17:46:56 +0200
Message-ID: <4FE1F070.4060305@hartkopp.net>
References: <1340136320-30840-1-git-send-email-mkl@pengutronix.de> <1340136320-30840-4-git-send-email-mkl@pengutronix.de> <4FE1460F.8040409@hartkopp.net> <4FE1830A.3020605@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:38939 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753883Ab2FTPq5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 20 Jun 2012 11:46:57 -0400
In-Reply-To: <4FE1830A.3020605@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On 20.06.2012 10:00, Marc Kleine-Budde wrote:

> On 06/20/2012 05:39 AM, Oliver Hartkopp wrote:
>> On 19.06.2012 22:05, Marc Kleine-Budde wrote:

>> Is there no way to satisfy the sparse warning in another way?
> 
> Yes, don't use extern, put it into af_can.h.
>


So this would fix the sparse warning then?

diff --git a/net/can/af_can.h b/net/can/af_can.h
index fd882db..1dccb4c 100644
--- a/net/can/af_can.h
+++ b/net/can/af_can.h
@@ -104,6 +104,9 @@ struct s_pstats {
 	unsigned long rcv_entries_max;
 };

+/* receive filters subscribed for 'all' CAN devices */
+extern struct dev_rcv_lists can_rx_alldev_list;
+
 /* function prototypes for the CAN networklayer procfs (proc.c) */
 extern void can_init_proc(void);
 extern void can_remove_proc(void);
diff --git a/net/can/proc.c b/net/can/proc.c
index ba873c3..3b6dd31 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -83,9 +83,6 @@ static const char rx_list_name[][8] = {
 	[RX_EFF] = "rx_eff",
 };

-/* receive filters subscribed for 'all' CAN devices */
-extern struct dev_rcv_lists can_rx_alldev_list;
-
 /*
  * af_can statistics stuff
  */



