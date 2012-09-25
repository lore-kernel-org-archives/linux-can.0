From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: ISOTP-implementation
Date: Tue, 25 Sep 2012 21:44:37 +0200
Message-ID: <506209A5.6050900@hartkopp.net>
References: <OFA6F22965.64945A5F-ONC1257A80.00311F72-C1257A80.00314FED@continental-corporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:9333 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755218Ab2IYTok (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 25 Sep 2012 15:44:40 -0400
In-Reply-To: <OFA6F22965.64945A5F-ONC1257A80.00311F72-C1257A80.00314FED@continental-corporation.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mahesh.Maharjan-EXT@continental-corporation.com
Cc: linux-can@vger.kernel.org

On 21.09.2012 10:58, Mahesh.Maharjan-EXT@continental-corporation.com wrote:

> In socketCan implementation with ISOTP_can, I want to know few things. As 
> far. ISOTP is point to point. But , as in BCM and RAW, Is it possible to 
> create multiple sockets for ISO-TP ??


You can open as much ISO-TP as you like.
Each ISO-TP socket should be bound to a different src-ID / dst-ID pair so that
they don't interfere.

> Or creating each socket with Message object for reading and writing


No. Once bound to a specific src/dst identifier, the connection is defined
properly. You can send and receive on that socket then.

See this example:

https://gitorious.org/linux-can/can-utils/blobs/master/isotptun.c


> Now If I want to implement with ISOTP with InterProcess Com  system  !! . 
> which might have multiple PDU..


One write() syscall -> one ISO-TP PDU is sent

One ISO-TP PDU is received -> one read() syscall get's the PDU


> Suppose , In receiving side , I might have 
> single master PDU and multi Slave PDU ..


???

The ISO-TP socket can only deal with point-to-point connections - due to the
two needed CAN Identifiers.

If you think about functional diagnosis requests: Use the raw socket to send
these requests that are fitting into one CAN frame ...

> So  what could be idea.. if I 
> want to use Socketcan ISO-TP standard Socketcan. and  I check in isotp.c 
> file., But could able to figure out , how it realize with Socket and 
> ISO-TP standard.


Did you read the source of all the ISO-TP tools?

https://gitorious.org/linux-can/can-utils/trees/master (isotp*.c)

And did you read this:

https://gitorious.org/linux-can/can-modules/blobs/master/README.isotp

??

Regards,
Oliver
