From: Ico Doornekamp <can@zevv.nl>
Subject: Re: CAN libpcap capture endianess
Date: Thu, 12 Sep 2013 11:31:16 +0200
Message-ID: <1378978095-sup-4073@pruts.nl>
References: <1378920814-sup-4559@pruts.nl> <5230C662.6010502@pengutronix.de> <1378929884-sup-7223@pruts.nl> <5230CE58.3020604@pengutronix.de> <1378968239-sup-1257@pruts.nl> <5231748A.2080009@pengutronix.de> <1378975140-sup-5236@pruts.nl> <523180D2.700@pengutronix.de> <1378976796-sup-1310@pruts.nl> <523185C4.1020208@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pruts.nl ([82.94.235.106]:38535 "EHLO fe2.pruts.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751369Ab3ILJbV (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 12 Sep 2013 05:31:21 -0400
In-reply-to: <523185C4.1020208@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can <linux-can@vger.kernel.org>, yegorslists <yegorslists@googlemail.com>

* On 2013-09-12 11:13:40 +0200, Marc Kleine-Budde wrote:
 
> On 09/12/2013 11:09 AM, Ico Doornekamp wrote:
> 
> >> They are assuming the wrong endianes for your capture file. Yegor's
> >> capture file, which comes in another format, is interpreted correctly.
> > 
> > Sorry, I was not completely clear on this: I did the capturing on the
> > slcan0 interface from wireshark, so I did not make a capture file first.
> 
> In your original mail you've captured with wireshark, too, but written
> into a file. Now you are capturing with wireshark directly. 

Correct. Yesterday I did not have access to the test setup, but today
I'm back at the lab.

> I assume the same capturing engine (that one in wireshark) is involved
> in both workflows and the same error is triggered in the
> interpretation/dissection process.

That's what I'm thinking as well. But the confusion arose because of the
dump I received from Yegor, which was decoded correctly by wireshark.

I've long learned that is usually safest to assume that strange errors
originate from myself instead of questioning other peoples software, but
in this case it seems that wireshark is at fault.

-- 
:wq
^X^Cy^K^X^C^C^C^C
