From: Ico Doornekamp <can@zevv.nl>
Subject: Re: CAN libpcap capture endianess
Date: Thu, 12 Sep 2013 08:52:55 +0200
Message-ID: <1378968239-sup-1257@pruts.nl>
References: <1378920814-sup-4559@pruts.nl> <5230C662.6010502@pengutronix.de> <1378929884-sup-7223@pruts.nl> <5230CE58.3020604@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pruts.nl ([82.94.235.106]:60113 "EHLO fe2.pruts.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756884Ab3ILGxC (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 12 Sep 2013 02:53:02 -0400
In-reply-to: <5230CE58.3020604@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can <linux-can@vger.kernel.org>

* On 2013-09-11 22:11:04 +0200, Marc Kleine-Budde wrote:
 
> I'm not familiar with the tcpdump capture format, but the
> "(little-endian)" above suggests that the format supports both little
> and big endianes.

As far as I know wireshark should be able to handle both formats.

Maybe I can change the question so it's not directly related to capture formats
and wireshark:

I have can packets of SDO transfers (not the same objects, though). Can anyone
tell me which one has the data in proper byte order as it passed on the CAN
bus?

1: 8a 05 00 00 08 00 00 00 43 18 10 03 2f 01 00 00  
2: 00 00 06 02 08 5f db f6 2f 00 18 02 01 00 00 00   

1. packet #10 from capture-10. Node ID 10, SDO 0x1018sub3
2. packet #39 from capture-yegor. Node ID SDO 0x0018sub2

Thanks for your patience,

Ico
