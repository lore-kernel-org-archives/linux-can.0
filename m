From: Felix Obenhuber <felix@obenhuber.de>
Subject: Re: [RFC] CAN FD support part 2 - ideas and commented source
Date: Mon, 7 May 2012 13:51:28 +0200
Message-ID: <CAJsOQGNcdSyMjyH3XxZjhcmnZBKY_vBsb3+tEyxcuyxF7kJk1A@mail.gmail.com>
References: <4FA242D0.2070604@hartkopp.net>
	<4FA268B2.8030109@hartkopp.net>
	<20120503123755.GD416@vandijck-laurijssen.be>
	<4FA27F18.9080106@hartkopp.net>
	<20120503132209.GB2846@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:46608 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754612Ab2EGLva (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 May 2012 07:51:30 -0400
Received: by wgbdr13 with SMTP id dr13so4777801wgb.1
        for <linux-can@vger.kernel.org>; Mon, 07 May 2012 04:51:29 -0700 (PDT)
In-Reply-To: <20120503132209.GB2846@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Thu, May 3, 2012 at 3:22 PM, Kurt Van Dijck <kurt.van.dijck@eia.be> wrote:
>> This has a big advantage when thinking about wireshark & friends.
> I must have missed something here. ETH_P_CANFD value somewhere in struct skb
> is something kernel specific. Does wireshark look inside kernel?

No, it doesn't. The detection of a SocketCAN socket/interface is done
very hacky with the interface name in pcap.

pcap-linux.c:432:

#ifdef PCAP_SUPPORT_CAN
	if (strstr(device, "can") || strstr(device, "vcan")) {
		return can_create(device, ebuf);
	}
#endif

Felix
