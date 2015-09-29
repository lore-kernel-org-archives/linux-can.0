From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC PATCH 0/4] Net namespaces for SocketCAN
Date: Tue, 29 Sep 2015 19:56:13 +0200
Message-ID: <560AD0BD.6040803@hartkopp.net>
References: <DB3PR05MB09246A6393EF43427D2CC17689400@DB3PR05MB0924.eurprd05.prod.outlook.com> <56097EDB.9050607@hartkopp.net> <20150929103032.1141.50295@maxwell.marel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:22604 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932797AbbI2R4T (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 29 Sep 2015 13:56:19 -0400
In-Reply-To: <20150929103032.1141.50295@maxwell.marel.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

Hi Andri,

On 29.09.2015 12:30, Andri Yngvason wrote:
> Quoting Oliver Hartkopp (2015-09-28 17:54:35)
>> On 27.09.2015 20:22, Andri Yngvason wrote:
>>
>>> I've added net namespace support for raw and gw sockets. BCM needs work.

Do you think about the procfs stuff?

>>> I've done some preliminary testing and everything seems to work, but I would
>>> like to have some input from you guys before continuing.

I'm not a namespace specialist though. But at least it looks consistent.

>>> In particular I'm worried that I might have missed something with regard to
>>> receive lists. Devices still share the same "rcv_cache" across namespaces.

AFAIK the rcv_cache is just a better API to handle small data structures like 
the can_receiver. As the devices are separated and inside their specific 
namespace (right?) the ml_priv is per interface anyway.

So why not use a common rcv_cache ?

>>
>> What I know from net namespaces is that you can create virtual interfaces
>> (veth) which are 'peered' to another veth and can be 'bridged' to a real
>> interface.
>>
> Yes. I'm not actually interested in that though. I just want to be able to run
> vcan on LXC.

Ok - and when you create a vcan inside a namespace with

ip netns add myns

ip link add dev vcan0 type vcan

ip link set vcan0 netns myns

This just works inside the namespace 'myns' ??

---

Generally I appreciate your work after trying to understand it ;-)
So hopefully it doesn't break things we've overlooked.

How do you bridge two vcans over TCP?

Do you have an example for that?

Regards,
Oliver

