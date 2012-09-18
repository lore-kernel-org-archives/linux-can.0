From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: What are you doing if the TX buffer overflows?
Date: Tue, 18 Sep 2012 14:49:40 +0200
Message-ID: <50586DE4.9020707@grandegger.com>
References: <2478881.znSzbTXnK5@uschi> <505777BC.3000705@hartkopp.net> <5058659E.2010804@grandegger.com> <50586A50.5060300@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:48846 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933014Ab2IRMtt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Sep 2012 08:49:49 -0400
In-Reply-To: <50586A50.5060300@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, =?ISO-8859-1?Q?Heinz-J=FCrg?= =?ISO-8859-1?Q?en_Oertel?= <oe@port.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 09/18/2012 02:34 PM, Marc Kleine-Budde wrote:
> On 09/18/2012 02:14 PM, Wolfgang Grandegger wrote:
>> On 09/17/2012 09:19 PM, Oliver Hartkopp wrote:
>>> Hello Heinz,
>>>
>>> On 17.09.2012 15:58, Heinz-J=FCrgen Oertel wrote:
>>>
>>>>
>>>> is there a way to empty the tx buffer ?
>>>
>>>
>>> Usually the buffer does not get empty due to a problem of the CAN c=
ontroller
>>> and/or the CAN network.
>>>
>>> So even if you could flush the queue the CAN controller is probably=
 still
>>> stuck with his processed frame.
>>>
>>> Setting the interface to DOWN and UP again re-initializes the CAN c=
ontroller
>>> and flushes all the queues.
>>>
>>> This would work - but all open sockets would get a notification of =
the
>>> interface went down.
>>>
>>> Btw. IIRC there's a IFLA_CAN_RESTART functionality to kick the CAN =
controller
>>> if it got stuck. It can by triggered by a netlink message. This is =
the same
>>> configuration interface that's used to set the bittiming:
>>>
>>> http://lxr.linux.no/#linux+v3.5.4/include/linux/can/netlink.h#L103
>>>
>>> But i have currently no source code example as i always use the 'ip=
' tool from
>>> the iproute2 package to configure my CAN interfaces:
>>>
>>> http://lxr.linux.no/#linux+v3.5.4/Documentation/networking/can.txt#=
L646
>>>
>>> Following that documentation
>>>
>>> 	ip link set can0 type can restart
>>>
>>> should do it for 'can0'.
>>
>> No, this does only works if a bus-off is pending. See:
>>
>> http://lxr.linux.no/#linux+v3.5.4/drivers/net/can/dev.c#L413
>>
>> Well, the name IFLA_CAN_RESTART is not really well chosen.
>=20
> Hmmm, it corresponds somewhat to the restart-ms property.

Yes, for automatic restart after bus-off.

> We have several customers who asked how to abort pending TX messages,
> too. Which involves:
> a) clear the TX-queue in Linux
> b) clear queue in hardware
> c) abort currently transmitting CAN frame
>=20
> I think c) would be a usecase of its own, too.

I think you need c) for b), at least for some controllers. These
features, especially b) and c), are not yet available because they are
not easy to implement (hardware-dependent) and there was no request so
far. Anyway, clearing the TX queue should be rather common and might
already be available for other protocols.

Wolfgang.


