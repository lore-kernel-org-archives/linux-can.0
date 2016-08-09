From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Possible NULL sample_point in the new way of computing bit-timings
Date: Tue, 9 Aug 2016 16:17:08 +0200
Message-ID: <1a3f3f0a-5648-345b-b197-3e956d9ef39b@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:39281 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504AbcHIOYr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 9 Aug 2016 10:24:47 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi all,

With the new way of computing bit-timings introduced in linux-can-next, 
when CONFIG_CAN_CALC_BITTIMING is defined, I think there's a chance to 
set 0 in "bt->sample_point" of a can device. This is a different 
behavior than with the previous versions.

IMHO, there are cases where "can_update_sample_point()" might return 0 
("best_sample_point" is initialized to 0). There is no real damage in 
the main loop of "can_calc_bittiming()": its returned value is ignored 
(and only *sample_point_error matters). But it is not, outside this 
loop, when setting the (real) value of the sample_point. So I think that 
the real value of the sample_point must be computed using the final 
values of tseg and tseg2, something like:

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 7188137..de422b3 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -200,8 +200,8 @@ static int can_calc_bittiming(struct net_device 
*dev, struct can_bittiming *bt,
         }

         /* real sample point */
-       bt->sample_point = can_update_sample_point(btc, 
sample_point_nominal, best_tseg,
-                                         &tseg1, &tseg2, NULL);
+       bt->sample_point = 1000 * (best_tseg + CAN_CALC_SYNC_SEG - tseg2) /
+                                       (best_tseg + CAN_CALC_SYNC_SEG);

         v64 = (u64)best_brp * 1000 * 1000 * 1000;
         do_div(v64, priv->clock.freq);

The best would be to introduce a function that implements the formula...

Stéphane

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183 
Geschaeftsfuehrung: A.Gach, U.Wilhelm
--
