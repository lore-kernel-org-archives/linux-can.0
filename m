From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: Re: SocketCAN over Ethernet
Date: Fri, 04 Apr 2014 21:17:32 +0200
Message-ID: <87lhvkhpkj.fsf@steelpick.2x.cz>
References: <loom.20140403T134741-892@post.gmane.org> <1396543883.12659.25.camel@blackbox>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from max.feld.cvut.cz ([147.32.192.36]:34065 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753844AbaDDT0W (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 4 Apr 2014 15:26:22 -0400
In-Reply-To: <1396543883.12659.25.camel@blackbox>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Max S." <max@schneidersoft.net>, Daniel =?utf-8?Q?Bostr=C3=B6m?= <daniel.bostrom@maximatecc.com>
Cc: linux-can@vger.kernel.org

Hi,

On Thu, Apr 03 2014, Max S. wrote:
> I don't know of a direct way of hooking up two socket can interfaces
> over eth.

This won't probably help Daniel, but some time ago, we implemented
an in-kernel CAN-UDP gateway.

Kernel patch is available at
https://rtime.felk.cvut.cz/gitweb/can-eth-gw-linux.git/commit/3f7fc0265e9555dea75cef7709720e62d8da37d8

The commit message says:
> CAN-Ethernet gateway - kernel part
>  
> This patch implements CAN-Ethernet (or more precisely CAN-UDP) gateway.
> The code here is only responsible for routing the messages in kernel
> space. Initial configuration and setup of the involved sockets is done
> in user space with cegw utility.
>  
> Currently, the gateway support IPv4 and IPv6.  CAN_FD frames are note
> supported.

The user-space counterpart is at
https://rtime.felk.cvut.cz/gitweb/can-utils.git/blob/refs/heads/cegw:/cegw.c

Probably, the only reason, why the gateway should be implemented in the
kernel is performance. We measured that the kernel gateway is 12% faster
than an user space one (which is not much).

If somebody is interested in more details, let me know.

-Michal
