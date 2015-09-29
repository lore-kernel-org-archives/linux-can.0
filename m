From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [RFC PATCH 0/4] Net namespaces for SocketCAN
Date: Tue, 29 Sep 2015 10:30:32 +0000
Message-ID: <20150929103032.1141.50295@maxwell.marel.net>
References: <DB3PR05MB09246A6393EF43427D2CC17689400@DB3PR05MB0924.eurprd05.prod.outlook.com>
 <56097EDB.9050607@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-am1on0065.outbound.protection.outlook.com ([157.56.112.65]:65093
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S934550AbbI2Kay convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 29 Sep 2015 06:30:54 -0400
In-Reply-To: <56097EDB.9050607@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

Hi Oliver,

Quoting Oliver Hartkopp (2015-09-28 17:54:35)
> Hi Andri,
> 
> On 27.09.2015 20:22, Andri Yngvason wrote:
> 
> > I've added net namespace support for raw and gw sockets. BCM needs work.
> >
> > I've done some preliminary testing and everything seems to work, but I would
> > like to have some input from you guys before continuing.
> >
> > In particular I'm worried that I might have missed something with regard to
> > receive lists. Devices still share the same "rcv_cache" across namespaces.
> 
> What I know from net namespaces is that you can create virtual interfaces 
> (veth) which are 'peered' to another veth and can be 'bridged' to a real 
> interface.
>
Yes. I'm not actually interested in that though. I just want to be able to run
vcan on LXC.
> 
> As the receive lists are interface specific (for real and virtual CAN 
> interfaces, see dev->ml_priv in find_dev_rcv_lists()) you would need to make 
> the virtual CAN driver namespace aware.
> 
> And you would need to implement some 'bind' and 'peering' between the 
> interfaces to connect your virtual CAN to other vcan's or real CAN interfaces.
>
Actually, it's also possible to connect the two interfaces via a TCP connection.
That's what I'm doing.
> 
> Net namespaces sounds fancy but I wonder what kind of use case you have in 
> mind that cannot be realized by virtual CAN interfaces and can-gw routing 
> assigments?
> 
I can't use vcan under LXC unless namespaces are supported.

Cheers,
Andri
> 
> >
> > Please tell me what you think.
> >
> > Thanks,
> > Andri
> >
> > Andri Yngvason (4):
> >    net: can: make af_can header global
> >    net: can: rename structures
> >    net: can: move shared data into net namespace
> >    net: can: remove net namespace restrictions
> >
> >   include/linux/can/core.h    |   4 +-
> >   include/net/af_can.h        | 131 +++++++++++++++++++
> >   include/net/net_namespace.h |   4 +
> >   include/net/netns/can.h     |  20 +++
> >   net/can/af_can.c            | 183 ++++++++++++++------------
> >   net/can/af_can.h            | 126 ------------------
> >   net/can/bcm.c               |  29 +++--
> >   net/can/gw.c                |  13 +-
> >   net/can/proc.c              | 307 ++++++++++++++++++++++++--------------------
> >   net/can/raw.c               |  34 +++--
> >   10 files changed, 466 insertions(+), 385 deletions(-)
> >   create mode 100644 include/net/af_can.h
> >   create mode 100644 include/net/netns/can.h
> >   delete mode 100644 net/can/af_can.h
> >
