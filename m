From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [RFC PATCH 0/4] Net namespaces for SocketCAN
Date: Tue, 29 Sep 2015 19:07:41 +0000
Message-ID: <20150929190741.15756.70022@maxwell.marel.net>
References: <DB3PR05MB09246A6393EF43427D2CC17689400@DB3PR05MB0924.eurprd05.prod.outlook.com>
 <56097EDB.9050607@hartkopp.net> <20150929103032.1141.50295@maxwell.marel.net>
 <560AD0BD.6040803@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db3on0056.outbound.protection.outlook.com ([157.55.234.56]:9088
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964820AbbI2TIE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 29 Sep 2015 15:08:04 -0400
In-Reply-To: <560AD0BD.6040803@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

Hi Oliver,

Quoting Oliver Hartkopp (2015-09-29 17:56:13)
> Hi Andri,
> 
> On 29.09.2015 12:30, Andri Yngvason wrote:
> > Quoting Oliver Hartkopp (2015-09-28 17:54:35)
> >> On 27.09.2015 20:22, Andri Yngvason wrote:
> >>
> >>> I've added net namespace support for raw and gw sockets. BCM needs work.
> 
> Do you think about the procfs stuff?
>
I've handled the procfs stuff in af_can, but BCM has a lot of that too. I've not
changed to proc stuff in BCM to use namespaces.
> 
> >>> I've done some preliminary testing and everything seems to work, but I would
> >>> like to have some input from you guys before continuing.
> 
> I'm not a namespace specialist though. But at least it looks consistent.
>
Neither am I! ;)
> 
> >>> In particular I'm worried that I might have missed something with regard to
> >>> receive lists. Devices still share the same "rcv_cache" across namespaces.
> 
> AFAIK the rcv_cache is just a better API to handle small data structures like 
> the can_receiver. As the devices are separated and inside their specific 
> namespace (right?) the ml_priv is per interface anyway.
> 
> So why not use a common rcv_cache ?
>
That's what I though, but I don't feel like I have the whole picture, so I'm
afraid of side-effects and race-conditions.

I've been experiencing some unstability on my workstation while using CAN under
LXC. Things don't crash under the same conditions in a non-SMP qemu machine so I
reckon there might be something racy going on. It might also be that the patches
didn't apply properly to the kernel I'm running because it's a different
version. I haven't had time to test these theories yet, but we'll see.
> 
> >>
> >> What I know from net namespaces is that you can create virtual interfaces
> >> (veth) which are 'peered' to another veth and can be 'bridged' to a real
> >> interface.
> >>
> > Yes. I'm not actually interested in that though. I just want to be able to run
> > vcan on LXC.
> 
> Ok - and when you create a vcan inside a namespace with
> 
> ip netns add myns
> 
> ip link add dev vcan0 type vcan
> 
> ip link set vcan0 netns myns
> 
> This just works inside the namespace 'myns' ??
> 
Yep, that's about right. A convenient way to test this without LXC is to add a
namespace and then run a screen/tmux session within the namespace. Something
like this:

# ip netns add myns
# ip netns exec myns tmux

Then you can add a vcan interface within the session and check that it appears
in "ip link show". Other things to try: candump any, candump vcan0, cangen vcan,
cat /proc/net/can/stats, cat /proc/net/can/rcvlists_*, ...

It's also good to run these in another namespace or the default namespace at the
same time to verify that nothing bleeds through.
> ---
> 
> Generally I appreciate your work after trying to understand it ;-)
> So hopefully it doesn't break things we've overlooked.
> 
> How do you bridge two vcans over TCP?
> 
> Do you have an example for that?
> 
I don't have any code to show you at the moment. What I have is a part of a
larger project that is not ready for release. I'll tell you how it works
instead.

TCP server:
 * Open can/vcan.
 * Listen on socket.
 * On connection:
   - Set up a callback to forward data from the bus to the client.
   - Set up a callback to forward data from the client to the bus.

TCP client:
 * Open can/vcan.
 * Connect to server.
 * On success:
   - Set up a callback to forward data from the bus to the server.
   - Set up a callback to forward data from the server to the bus.

The data is sent over as packets of "struct can_frame" with "can_id" in network
byte-order.

My LXC instance is already bridged to the network, so getting the TCP through is
no problem.

This sort of thing is probably not very nice with regard to real-time
performance but it's good enough when you're developing a CAN application on a
linux container.

Now, you might ask why I'm developing applications in an LXC instance, but
that's a whole different story. ;)

Cheers,
Andri
