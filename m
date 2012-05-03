From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Wireshark / libpcap - was Re: [RFC] CAN FD support part 2 - ideas
 and commented source
Date: Thu, 03 May 2012 20:01:32 +0200
Message-ID: <4FA2C7FC.9070103@hartkopp.net>
References: <4FA242D0.2070604@hartkopp.net> <4FA268B2.8030109@hartkopp.net> <20120503123755.GD416@vandijck-laurijssen.be> <4FA27F18.9080106@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:33036 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757965Ab2ECSBf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 May 2012 14:01:35 -0400
In-Reply-To: <4FA27F18.9080106@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <kurt.van.dijck@eia.be>, Felix Obenhuber <felix@obenhuber.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 03.05.2012 14:50, Oliver Hartkopp wrote:

> On 03.05.2012 14:37, Kurt Van Dijck wrote:


>> I don't see benefit in introducing ETH_P_CANFD.
>> Using the skb's payload length differentiates enough between CAN_MTU & CANFD_MTU.
>> Why not using that info. IMHO, ETH_P_CANFD duplicates the info.
> 
> 
> This has a big advantage when thinking about wireshark & friends.
> 
> You can look into the eth protocol and know the skb data layout.
> The length information is some kind of implicit knowledge.


Hi Kurt,

i just wanted to pick up the ETH_P_CANFD topic you asked for.

As you can see in packet_sendmsg_spkt() here

http://lxr.linux.no/#linux+v3.3.4/net/packet/af_packet.c#L1447

the 'proto' can be set directly when creating a skb with packet sockets:

http://lxr.linux.no/#linux+v3.3.4/net/packet/af_packet.c#L1466

At this point the value is put into the skb:

http://lxr.linux.no/#linux+v3.3.4/net/packet/af_packet.c#L1542


So e.g. the packet socket is definitely aware of the ETH_P_xxx values, try
'man packet' :

(..)
protocol is the IEEE 802.3 protocol number in network order.  See the
<linux/if_ether.h> include file for a list  of allowed  protocols.
When  protocol  is  set  to htons(ETH_P_ALL) then all protocols are received.
All incoming packets of that protocol type will be passed to the packet socket
before they are passed to the protocols implemented in the kernel.
(..)

For that reason and because of the reference to <linux/if_ether.h> i think
it's pretty relevant to wireshark and libpcap - that's why i added Felix in CC.

http://sourceforge.net/tracker/?func=detail&aid=2872132&group_id=53067&atid=469579

Regards,
Oliver

