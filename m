From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 packet stuffing
Date: Wed, 23 Apr 2014 14:21:48 +0200
Message-ID: <20140423122148.GA1860@vandijck-laurijssen.be>
References: <loom.20140409T155830-71@post.gmane.org>
 <20140409194939.GD15221@vandijck-laurijssen.be>
 <loom.20140410T155519-838@post.gmane.org>
 <20140411083139.GB449@vandijck-laurijssen.be>
 <loom.20140417T051332-76@post.gmane.org>
 <20140417201835.GA12665@vandijck-laurijssen.be>
 <loom.20140421T164905-320@post.gmane.org>
 <20140422083115.GB12818@vandijck-laurijssen.be>
 <loom.20140423T044633-183@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay007.isp.belgacom.be ([195.238.6.173]:57651 "EHLO
	mailrelay007.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751924AbaDWMV7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 23 Apr 2014 08:21:59 -0400
Content-Disposition: inline
In-Reply-To: <loom.20140423T044633-183@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: swapnil <patilswa@gmail.com>
Cc: linux-can@vger.kernel.org

Hey Swapnil,

On Wed, Apr 23, 2014 at 02:58:27AM +0000, swapnil wrote:
> 
> Hi Kurt,
>     1.For time being i am doing change in user space as i need to start 
> testing for multiple(example 6 ECU ) ECU connected on J1939.
>     Once it et update in the can-j1939 module i will update it.

Modifying userspace means adjusting the dlc, which I think may not ideal
for transport protocol.
Hence, I understand your situation, therefore please find below a
quick fix proposal, similar to the interpacket delay insertion earlier.

This patch will stuff _all_ CAN frames with 0xff up to 8 bytes.
This conforms more strictly to the spec

>   
>     2.Yes,the packet stuffing issue occurred with every ecu that i have 
> tested .. These all ECU from same manufacturer used in US

I see. They all originate from the same programmer.
Well, that's a strict programmer.

--
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 7edf843..1479de4 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -156,7 +156,9 @@ static int j1939_send_can(struct sk_buff *skb)
 		canid |= ((sk_addr->pgn & 0x3ffff) << 8);
 
 	msg->can_id = canid;
-	msg->can_dlc = dlc;
+	if (dlc < 8)
+		memset(msg->data+dlc, 0xff, 8 - dlc);
+	msg->can_dlc = 8;
 
 	/* set net_device */
 	ret = -ENODEV;
