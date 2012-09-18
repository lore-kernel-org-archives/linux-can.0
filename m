From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: What are you doing if the TX buffer overflows?
Date: Tue, 18 Sep 2012 13:44:03 +0200
Message-ID: <20120918114403.GA77823@macbook.local>
References: <2478881.znSzbTXnK5@uschi>
 <505777BC.3000705@hartkopp.net>
 <4283CE44E963D741A50240F32D185B9F109AA1@SBSPORT3.portgmbh.local>
 <3033577.LU3ttOr8xL@linux-edhj>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay002.isp.belgacom.be ([195.238.6.175]:33487 "EHLO
	mailrelay002.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932711Ab2IRLoH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 18 Sep 2012 07:44:07 -0400
Content-Disposition: inline
In-Reply-To: <3033577.LU3ttOr8xL@linux-edhj>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?utf-8?Q?Heinz-J=C3=BCrgen?= Oertel <oe@port.de>
Cc: Oliver Hartkopp =?utf-8?B?4oCO?= <socketcan@hartkopp.net>, linux-can@vger.kernel.org

On Mon, Sep 17, 2012 at 09:40:41PM +0200, Heinz-J=C3=BCrgen Oertel wrot=
e:
>=20
[...]
> >=20
> > > Or read out the occupied size of it
> > > to get the mumber of CAN frames waiting for transmission?
> >=20
> >=20
> > I'll take a look, if there's a programming interface to get this va=
lue.
> > Or is this request obsolete now after my answer above?
>=20
> No. This is still of interest.
> Knowing if the transmit queue is mostly empty is a good thing.
> Otherwise the application is sending to fast,

I distinguish 2 use cases there:
1. repeating a limited set of identical frames endlessly (eg. grabbing =
a bootloader)
2. burst a lot of data on the bus.

Case 1 can be solved by setting CAN_RAW_RECV_OWN_MSGS. If you don't
see your transmitted frames, it makes no sense to repeat it, since
they're still queued.

Case 2 is solved by waiting a little while when you get ENOBUFS. This
way, you will not need to track the buffer's status.
Throttling messages based on buffer fill status is a bit difficult
in a multi-user environment. You may know the buffer max. size,
but not the number of applications using it.

Can your issue be categorized under one of these 2 cases?
If not, I'd like to learn the use case :-)

Kurt
