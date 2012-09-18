From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: What are you doing if the TX buffer overflows?
Date: Tue, 18 Sep 2012 14:37:08 +0200
Message-ID: <50586AF4.2080205@grandegger.com>
References: <2478881.znSzbTXnK5@uschi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:48299 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932928Ab2IRMhL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Sep 2012 08:37:11 -0400
In-Reply-To: <2478881.znSzbTXnK5@uschi>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Heinz-J=FCrgen_Oertel?= <oe@port.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 09/17/2012 03:58 PM, Heinz-J=FCrgen Oertel wrote:
>=20
> Hello,
> is there a way to empty the tx buffer ?
> Or read out the occupied size of it
> to get the mumber of CAN frames waiting for transmission?

As we usally get a TX done interrupt we in principle know how much
messages are still pending in the software and hardware queue but we
will only be able to flush the messages in the software queue because
aborting of messages in the device TX queue is not supported (even if
most controllers can do it). Therefore the only clean way to get rid of
all pending messages is to stop and restart the device (ifconfig down -=
>
up).

Other protocols seem to provide the ioctl request SIOCINQ to query the
number of untransmitted messages, e.g.:

 http://lxr.linux.no/#linux+v3.5.4/net/packet/af_packet.c#L3385

Should not be a big deal to add it to the CAN ioctl requests.

Wolfgang.

