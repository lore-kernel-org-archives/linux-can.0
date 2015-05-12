From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Raw CAN socket support in LXC?
Date: Tue, 12 May 2015 20:09:28 +0200
Message-ID: <555241D8.6050503@hartkopp.net>
References: <554C6FDE.6080706@actia.se> <554C79D4.8000901@pengutronix.de> <554C9B67.1030201@actia.se> <201505111345.51998.pisa@cmp.felk.cvut.cz> <5550A95B.1000605@actia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:57271 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932809AbbELSJe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 May 2015 14:09:34 -0400
In-Reply-To: <5550A95B.1000605@actia.se>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: John Ernberg <john.ernberg@actia.se>, Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, =?UTF-8?B?QWRhbSBFbmdzdHLDtm0=?= <adam.engstrom@actia.se>

On 05/11/2015 03:06 PM, John Ernberg wrote:

> I succeeded in forwarding the can interface into the container.
> When I tried to open a socket, and bind it to the interface to make a 
> test for receiving frames I got an error saying "socket: Address family 
> not supported by protocol".
> Looking around in LXC, and then the kernel, I discovered that the AF_CAN 
> implementation does not support net_namespaces yet, and net_namespaces 
> does not implement any handling for CAN, so we cannot open any kind of 
> socket to actually read from the interface.
> 
> Is there anything quick and dirty I could try to see if socket traffic 
> can be forwarded into the container on a phys-forwarded CAN interface? 

You can try to read CAN frames from the CAN netdev via AF_PACKET socket:

https://github.com/linux-can/can-tests/blob/master/tst-packet.c

Or use wireshark which has CAN support too.

> Or would a proper net_namespaces implementation for CAN be necessary?

When you use AF_PACKET you bypass the CAN network layer stuff.

Best regards,
Oliver

