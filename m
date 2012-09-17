From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: What are you doing if the TX buffer overflows?
Date: Mon, 17 Sep 2012 21:19:24 +0200
Message-ID: <505777BC.3000705@hartkopp.net>
References: <2478881.znSzbTXnK5@uschi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:56902 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932417Ab2IQTT2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 17 Sep 2012 15:19:28 -0400
In-Reply-To: <2478881.znSzbTXnK5@uschi>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Heinz-J=FCrgen_Oertel?= <oe@port.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Heinz,

On 17.09.2012 15:58, Heinz-J=FCrgen Oertel wrote:

>=20
> is there a way to empty the tx buffer ?


Usually the buffer does not get empty due to a problem of the CAN contr=
oller
and/or the CAN network.

So even if you could flush the queue the CAN controller is probably sti=
ll
stuck with his processed frame.

Setting the interface to DOWN and UP again re-initializes the CAN contr=
oller
and flushes all the queues.

This would work - but all open sockets would get a notification of the
interface went down.

Btw. IIRC there's a IFLA_CAN_RESTART functionality to kick the CAN cont=
roller
if it got stuck. It can by triggered by a netlink message. This is the =
same
configuration interface that's used to set the bittiming:

http://lxr.linux.no/#linux+v3.5.4/include/linux/can/netlink.h#L103

But i have currently no source code example as i always use the 'ip' to=
ol from
the iproute2 package to configure my CAN interfaces:

http://lxr.linux.no/#linux+v3.5.4/Documentation/networking/can.txt#L646

=46ollowing that documentation

	ip link set can0 type can restart

should do it for 'can0'.

> Or read out the occupied size of it
> to get the mumber of CAN frames waiting for transmission?


I'll take a look, if there's a programming interface to get this value.
Or is this request obsolete now after my answer above?

Regards,
Oliver

