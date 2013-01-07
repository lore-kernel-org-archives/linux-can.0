From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: exclusive access to can interface
Date: Mon, 07 Jan 2013 19:37:44 +0100
Message-ID: <50EB15F8.4090700@hartkopp.net>
References: <2412937.XVpYjfC7zz@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:16063 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523Ab3AGShq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Jan 2013 13:37:46 -0500
In-Reply-To: <2412937.XVpYjfC7zz@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org

On 07.01.2013 17:52, Alexander Stein wrote:

> is there a way to get exclusive (write) access to a CAN interface, so that only one bound socket can write CAN frames on the bus?
> 


Not really.

In a very early SocketCAN implementation we had the possibility to define the capabilities to access CAN sockets. See

http://svn.berlios.de/wsvn/socketcan/trunk/kernel/2.6/net/can/raw.c?op=log&op=log&peg=1258&page=2

We removed it in:

http://svn.berlios.de/wsvn/socketcan/trunk/kernel/2.6/net/can/raw.c?op=revision&rev=489&peg=1258

http://svn.berlios.de/wsvn/socketcan/trunk/kernel/2.6/net/can/raw.c?op=revision&rev=490&peg=1258

You might think about re-introducing some capability checking, e.g. that only root or some other special user may write on CAN RAW sockets.

E.g. see "if (!capable(CAP_NET_RAW))"

http://lxr.linux.no/#linux+v3.7.1/net/packet/af_packet.c#L2480

in packet_create() ...

Regards,
Oliver
