From: Andri Yngvason <andri.yngvason@marel.com>
Subject: flexcan napi poll and error frames
Date: Fri, 24 Oct 2014 10:26:11 +0000
Message-ID: <544A2943.1080808@marel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn1bon0059.outbound.protection.outlook.com ([157.56.111.59]:24052
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751907AbaJXK0P (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 24 Oct 2014 06:26:15 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

Hi,

I was running some tests on my patches when I noticed the following:
If I have 2 flexcan devices on the bus, each sending to the bus using
cangen,and then I disconnect the cable to one of them, that device
will enter"error-warning" state, but it will not continue on to
"error-passive" as itshould.

However, when I reconnect the cable, I get the "error-passive" message
followed by an "error-warning" and eventually "back-to-error-active".

Notice the time differences:
root@(none):~# candump -td -e can0,0~0,#FFFFFFFFFF
 (000.000000)  can0  20000004   [8]  00 08 00 00 00 00 00 00   ERRORFRAME
        controller-problem{tx-error-warning}
 (006.493209)  can0  20000004   [8]  00 40 00 00 00 00 00 00   ERRORFRAME
        controller-problem{back-to-error-active}
 (002.701331)  can0  20000004   [8]  00 08 00 00 00 00 00 00   ERRORFRAME
        controller-problem{tx-error-warning}
 (006.498567)  can0  20000004   [8]  00 20 00 00 00 00 00 00   ERRORFRAME
        controller-problem{tx-error-passive}
 (000.013915)  can0  20000004   [8]  00 08 00 00 00 00 00 00   ERRORFRAME
        controller-problem{tx-error-warning}
 (001.990695)  can0  20000004   [8]  00 40 00 00 00 00 00 00   ERRORFRAME
        controller-problem{back-to-error-active}


I suspect that the problem is that the driver doesn't receive any
interruptsother than the one for "error-passive" and so things
won't "weigh" enoughfor napi. There seems to be some truth in this
conjecture, because when Itried setting the napi weight to 1, the
message got through.

Another thing that I found peculiar was that I had to be sending on
both devices for the error states to change to anything other than
"error-warning".

Best regards,
Andri Yngvason
