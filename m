From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC] CAN FD support part 2 - ideas and commented source
Date: Mon, 07 May 2012 20:03:06 +0200
Message-ID: <4FA80E5A.7070805@hartkopp.net>
References: <4FA242D0.2070604@hartkopp.net> <4FA268B2.8030109@hartkopp.net> <20120503123755.GD416@vandijck-laurijssen.be> <4FA27F18.9080106@hartkopp.net> <20120503132209.GB2846@vandijck-laurijssen.be> <CAJsOQGNcdSyMjyH3XxZjhcmnZBKY_vBsb3+tEyxcuyxF7kJk1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:48189 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185Ab2EGSDJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 May 2012 14:03:09 -0400
In-Reply-To: <CAJsOQGNcdSyMjyH3XxZjhcmnZBKY_vBsb3+tEyxcuyxF7kJk1A@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Felix Obenhuber <felix@obenhuber.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 07.05.2012 13:51, Felix Obenhuber wrote:

> On Thu, May 3, 2012 at 3:22 PM, Kurt Van Dijck <kurt.van.dijck@eia.be> wrote:
>>> This has a big advantage when thinking about wireshark & friends.
>> I must have missed something here. ETH_P_CANFD value somewhere in struct skb
>> is something kernel specific. Does wireshark look inside kernel?
> 
> No, it doesn't. The detection of a SocketCAN socket/interface is done
> very hacky with the interface name in pcap.
> 
> pcap-linux.c:432:
> 
> #ifdef PCAP_SUPPORT_CAN
> 	if (strstr(device, "can") || strstr(device, "vcan")) {
> 		return can_create(device, ebuf);
> 	}
> #endif


Oh, oh.

I like to have at least one vcan interface named 'helga' on my system.

Obviously i won't have fun with pcap %-/

Regards,
Oliver
