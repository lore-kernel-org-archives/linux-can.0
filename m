From: Daniel =?utf-8?b?Qm9zdHLDtm0=?= <daniel.bostrom@maximatecc.com>
Subject: Re: SocketCAN over Ethernet
Date: Fri, 4 Apr 2014 07:08:12 +0000 (UTC)
Message-ID: <loom.20140404T084336-169@post.gmane.org>
References: <loom.20140403T134741-892@post.gmane.org> <533DB9A6.6030605@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:32773 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752003AbaDDHIZ (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 4 Apr 2014 03:08:25 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1WVyEg-0000Lo-NQ
	for linux-can@vger.kernel.org; Fri, 04 Apr 2014 09:08:22 +0200
Received: from 193.15.169.28 ([193.15.169.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 04 Apr 2014 09:08:22 +0200
Received: from daniel.bostrom by 193.15.169.28 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 04 Apr 2014 09:08:22 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Oliver Hartkopp <socketcan <at> hartkopp.net> writes:

>=20
> Hello Daniel,
>=20
> On 03.04.2014 13:52, Daniel Bostr=C3=B6m wrote:
>=20
> > Currently we are running Ubuntu in a virtual machine using=20
> > VirtualBox on a Windows host. In Ubuntu we use SocketCAN and we wou=
ld=20
like=20
> > to continue to do so but instead of using real CAN hardware somehow=
=20
setup=20
> > CAN communication over Ethernet to the Windows host.
>=20
> Don't know if I understand you correctly:
>=20
> Do you want the CAN interfaces to be attached to the Windows host and=
=20
access
> these interfaces from Linux ... or the other way around?
>=20
> Maybe a look at the JAVA tool Kayak (http://kayak.2codeornot2code.org=
/)=20
might
> be interesting for you.
>=20
> Kayak uses the socketcand (https://github.com/dschanoeh/socketcand/)=20
which
> runs on Linux and provides the CAN interfaces via IP-sockets (to=20
whatever client).
>=20
> Regards,
> Oliver
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20

Thank you everyone for the replies.

I will try to explain a bit more what we are trying to do.

Our simulation software (used for testing our system without real=20
hardware) on Windows listens for incoming TCP connections
from our system to test (using SocketCAN) running on the Ubuntu VM. So =
we=20
would like a way to setup CAN communication over Ethernet (TCP) between=
=20
the Windows and Ubuntu VM. In other words we want to send and receive c=
an=20
messages on both Windows and Ubuntu. socketcand sounds very interesting=
 I=20
will have a look at it.

We have run a similar simulation before but on Windows only and would l=
ike=20
to be able to include an ubuntu machine in the simulation as well.

/Daniel

