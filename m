From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC PATCH 0/4] Net namespaces for SocketCAN
Date: Mon, 28 Sep 2015 19:54:35 +0200
Message-ID: <56097EDB.9050607@hartkopp.net>
References: <DB3PR05MB09246A6393EF43427D2CC17689400@DB3PR05MB0924.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:55587 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754178AbbI1Ryp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 28 Sep 2015 13:54:45 -0400
In-Reply-To: <DB3PR05MB09246A6393EF43427D2CC17689400@DB3PR05MB0924.eurprd05.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, John Ernberg <john.ernberg@actia.se>

Hi Andri,

On 27.09.2015 20:22, Andri Yngvason wrote:

> I've added net namespace support for raw and gw sockets. BCM needs work.
>
> I've done some preliminary testing and everything seems to work, but I would
> like to have some input from you guys before continuing.
>
> In particular I'm worried that I might have missed something with regard to
> receive lists. Devices still share the same "rcv_cache" across namespaces.

What I know from net namespaces is that you can create virtual interfaces 
(veth) which are 'peered' to another veth and can be 'bridged' to a real 
interface.

As the receive lists are interface specific (for real and virtual CAN 
interfaces, see dev->ml_priv in find_dev_rcv_lists()) you would need to make 
the virtual CAN driver namespace aware.

And you would need to implement some 'bind' and 'peering' between the 
interfaces to connect your virtual CAN to other vcan's or real CAN interfaces.

Net namespaces sounds fancy but I wonder what kind of use case you have in 
mind that cannot be realized by virtual CAN interfaces and can-gw routing 
assigments?

Regards,
Oliver

>
> Please tell me what you think.
>
> Thanks,
> Andri
>
> Andri Yngvason (4):
>    net: can: make af_can header global
>    net: can: rename structures
>    net: can: move shared data into net namespace
>    net: can: remove net namespace restrictions
>
>   include/linux/can/core.h    |   4 +-
>   include/net/af_can.h        | 131 +++++++++++++++++++
>   include/net/net_namespace.h |   4 +
>   include/net/netns/can.h     |  20 +++
>   net/can/af_can.c            | 183 ++++++++++++++------------
>   net/can/af_can.h            | 126 ------------------
>   net/can/bcm.c               |  29 +++--
>   net/can/gw.c                |  13 +-
>   net/can/proc.c              | 307 ++++++++++++++++++++++++--------------------
>   net/can/raw.c               |  34 +++--
>   10 files changed, 466 insertions(+), 385 deletions(-)
>   create mode 100644 include/net/af_can.h
>   create mode 100644 include/net/netns/can.h
>   delete mode 100644 net/can/af_can.h
>
