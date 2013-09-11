From: Ico Doornekamp <can@zevv.nl>
Subject: Re: CAN libpcap capture endianess
Date: Wed, 11 Sep 2013 22:05:38 +0200
Message-ID: <1378929884-sup-7223@pruts.nl>
References: <1378920814-sup-4559@pruts.nl> <5230C662.6010502@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pruts.nl ([82.94.235.106]:48709 "EHLO fe2.pruts.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755701Ab3IKUFn (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 11 Sep 2013 16:05:43 -0400
In-reply-to: <5230C662.6010502@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can <linux-can@vger.kernel.org>

* On 2013-09-11 21:37:06 +0200, Marc Kleine-Budde wrote:
 
> On 09/11/2013 07:42 PM, Ico wrote:
> > 1. capture-ico.pcap: CAN-232 interface, slcan, x86_64
> > 2. capture-yegor.pcap: VScom USB-CAN interface, slcal, x86
> 
> BTW:
> 
> > file *.pcap
> > capture-ico.pcap:   pcap-ng capture file - version 1.0
> > capture-yegor.pcap: tcpdump capture file (little-endian) - version 2.4 (SocketCAN, capture length 65535)
> 
> You are using different tools.

That's fine for all I know, since a sniff is a sniff. The original
question - which endianess is the right one (and what causes the wrong
endian sniff) - still stands.
 

-- 
:wq
^X^Cy^K^X^C^C^C^C
