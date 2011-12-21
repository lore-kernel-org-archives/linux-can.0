From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: [can-utils] canbusload: flush output at the end of each cycle
Date: Wed, 21 Dec 2011 10:19:48 +0100
Message-ID: <20111221091948.GC314@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay004.isp.belgacom.be ([195.238.6.170]:10779 "EHLO
	mailrelay004.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752596Ab1LUJTx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 Dec 2011 04:19:53 -0500
Received: from e-circ.dyndns.org (localhost [127.0.0.1])
	by e-circ.dyndns.org (Postfix) with ESMTP id B28B021FA29
	for <linux-can@vger.kernel.org>; Wed, 21 Dec 2011 10:19:42 +0100 (CET)
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

canbusload: flush output at the end of each cycle

When canbusload is piped to another program, the output
is queued for several cycles. This patch will flush the output
explicitely.

Signed-off-by: Kurt Van Dijck <kurt.van.dijck@eia.be>

This patch is available in git@gitorious.org:~kurt-vd/can-j1939-utils
in branch regular.

diff --git a/canbusload.c b/canbusload.c
index 26323d2..2693b9e 100644
--- a/canbusload.c
+++ b/canbusload.c
@@ -201,6 +201,7 @@ void printstats(int signo)
 	}
 
 	printf("\n");
+	fflush(stdout);
 
 	alarm(1);
 }
