From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: CAN firewall
Date: Fri, 30 Oct 2015 15:38:54 +0100
Message-ID: <563380FE.9090207@hartkopp.net>
References: <5633659E.3010008@probestar.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:17012 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752197AbbJ3Oi6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 30 Oct 2015 10:38:58 -0400
In-Reply-To: <5633659E.3010008@probestar.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Neal Probert <nprobert@probestar.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Neal,

long time no see :-)

On 10/30/2015 01:42 PM, Neal Probert wrote:
> Is there any sort of CAN firewall/gateway capability like
> ipfilter/iptables available?

First thing is to use the CAN filters provided by CAN_RAW sockets:

https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tree/Documentation/networking/can.txt?h=linux-4.2.y#n436

which provides a 'private' view to the CAN interface for each socket.
These filters are provided by the candump commandline options too.

In the case you don't trust the CAN application(??), you might try to limit
your untrusted application to use a virtual CAN (e.g. vcan0) and forward the
traffic from/to the 'real' can0 via can-gw rules.

Try 'cangw -?' from the can-utils package for a full feature description.
You can route and modify CAN frames from one CAN interface to another.

(But don't forget to modprobe can-gw before as it doesn't autoload)

The can-gw is a netlink configuration based routing an modifying functionality
for CAN frames.

Hope that helps so far - can you tell more about your use-case?

Regards,
Oliver
