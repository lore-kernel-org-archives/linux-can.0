From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: SocketCAN version numbering
Date: Fri, 27 Apr 2012 11:46:50 +0200
Message-ID: <4F9A6B0A.4090504@grandegger.com>
References: <201204271125.43138.oe@port.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:32797 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760015Ab2D0Jqw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 27 Apr 2012 05:46:52 -0400
In-Reply-To: <201204271125.43138.oe@port.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Heinz-J=FCrgen_Oertel?= <oe@port.de>
Cc: linux-can@vger.kernel.org

Hello Heinz,

On 04/27/2012 11:25 AM, Heinz-J=FCrgen Oertel wrote:
>=20
> Hello,
>=20
> What is the suggested way to get the SocketCAN version number?
> On my two systems, according to Documentation/networking/can.txt, I a=
lways get=20
>=20
>  $ cat /proc/net/can/version
>  rev 20090105 abi 8

This is for the CAN protocol implementation but I'm not sure if it's
well maintained...

> on different systems.
> But one has support for error counters the other not with the same in=
terface board

=2E.. and for CAN drives we do not maintain extra version number. Usual=
ly,
the kernel version is used to understand if a feature exists or is
supported. For the bus error counter and such features, capability flag=
s
would be a nice to have, though Anyway, what would you like to use the
berr_counters for? If they are not available, a netlink request will
return an error.

Wolfgang.
