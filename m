From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [Socketcan-users] Message stalls in SocketCan Layer?
Date: Fri, 03 Feb 2012 20:41:56 +0100
Message-ID: <4F2C3884.2000808@grandegger.com>
References: <4F29091F.4010908@in.tum.de> <4F2AA5DF.9080304@grandegger.com> <4F2C0675.1050808@in.tum.de> <4F2C11DF.7010707@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:47508 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372Ab2BCTl7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 3 Feb 2012 14:41:59 -0500
In-Reply-To: <4F2C11DF.7010707@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: =?ISO-8859-1?Q?Michael_J=E4ntsch?= <michael.jaentsch@in.tum.de>, linux-can@vger.kernel.org

On 02/03/2012 05:57 PM, Oliver Hartkopp wrote:
> Hi Michael,
>=20
> On 03.02.2012 17:08, Michael J=E4ntsch wrote:
>=20
>=20
>> yes, it all started when I switched to kernel 3.0.0-15-generic. Howe=
ver,
>> weirdly enough there is one computer with this kernel where the prob=
lem
>> doesn't appear and two where it does. I think I will confirm this by
>> going back to an older kernel and seeing if the problem disappears.
>=20
>=20
> please consider that if it works on other machines with the same kern=
el that
> there could be some changes within the USB subsystem or some interrup=
t or
> ACPI/powersaving issues too.
>=20
> Going back to an older Kernel is a good check - don't know, if you al=
so can go
> further (3.1, 3.2) with Ubuntu 11.10 too ?!?
>=20
> Maybe there's some USB debugging available to check whether the URB h=
as been
> sent properly to the USB wire and if the interrupt of the USB control=
ler
> reached the system after sending.

IIUC, he said that the time stamps indicated that the USB transfers hav=
e
happened in time. The delays occured later. That's wired, indeed.

Wolfgang.
