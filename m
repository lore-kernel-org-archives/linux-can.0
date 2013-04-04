From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Losing CAN messages with socket-CAN
Date: Thu, 04 Apr 2013 17:11:47 +0200
Message-ID: <515D9833.3030405@grandegger.com>
References: <20130404144412.8D1AC7DAB3329@bmail06.one.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:34883 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762091Ab3DDPLu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 4 Apr 2013 11:11:50 -0400
In-Reply-To: <20130404144412.8D1AC7DAB3329@bmail06.one.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "j.p.lammertink" <j.p.lammertink@kubicas.com>
Cc: linux-can@vger.kernel.org

On 04/04/2013 04:44 PM, j.p.lammertink wrote:
> Hi Marc,
>=20
> Thanks for the fast response. I've collected answers to your question=
s and=20
> pasted them below.
>=20
> Best Regards,
>=20
> Jeroen Lammertink
>=20
> ---------------------------------------------------------------------=
-----
>=20
> <> We are sending batches of 80 CAN messages using socket CAN to tran=
sfer an
> <> image for download. After the 80 messages we wait for a response
>=20
> <Are you evaluating the return value of the write() or sendmsg() syst=
emcall?
>=20
> We do evaluate the write call to the socket with an assert. I=92ve in=
cluded
> the code below. (See CCanPort::Write()). I=92ve also included the cod=
e in
> which the socket is created, just to be complete. When the problem (o=
f
> losing CAN messages) happens, the Assert is not triggered. So I deduc=
e
> that the socket remains unaware of the losing of messages.
>=20
> <> consisting of a single CAN message. Within the messages we have co=
ded a
> <> sequence number, so that we can detect lost messages. Besides the =
CAN
> <> device that is subject of download, we have also a (hardware) CAN =
sniffer
> <> on the CAN bus. We typically log CAN messages when we put them in =
the
> <> socket. With this set-up we typically detect losing a short series=
 of
> <> (mostly 5) CAN messages, somewhere halfway the batch of 80. No oth=
er
> <> devices are present on the CAN bus.
>=20
> <> I've dumped below some version and set-up info of Ubuntu, socket-c=
an and
> <> ifconfig.
>=20
> <> Is this problem known?
> <> May this problem be related to using an old version of socket can?
>=20
> < This is either a userspace problem or a buggy driver. The driver pr=
oblem
> < may have been fixed in the meantime.
>=20
> <> How can I upgrade Ubuntu to the latest versions of socket-can?
>=20
> < First we have to figure out what's broken.
>=20
> <> ------------------------------------------------------------------=
--------
> <> bmterra@q7buntu:~/user/jla$ uname -a
> <> Linux q7buntu 3.5.0-26-generic #42~precise1-Ubuntu SMP Mon Mar 11 =
22:19:42
> <> UTC 2013 i686 i686 i386 GNU/Linux
> <> bmterra@q7buntu:~/user/jla$ cat /proc/net/can/version
> <> rev 20090105 abi 8
> <> bmterra@q7buntu:~/user/jla$ ifconfig can0
> <> can0      Link encap:UNSPEC  HWaddr
> <> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
> <>           UP RUNNING NOARP  MTU:16  Metric:1
> <>           RX packets:1128 errors:0 dropped:0 overruns:0 frame:0
> <>           TX packets:4400 errors:0 dropped:0 overruns:0 carrier:0
> <>           collisions:0 txqueuelen:1024
> <>           RX bytes:9024 (9.0 KB)  TX bytes:34176 (34.1 KB)
> <>           Interrupt:18
> <> ------------------------------------------------------------------=
--------
>=20
> < Which CAN hardware are you using?
>=20
> Qseven module PQ7-M105IT
> with Intel Platform Controller HUB EG20T IOH
> with a =93BOSCH CAN Protocol Version 2.0B Active=20
>     (ISO 11519, ISO 11898, and SAEJ2411)=94 CAN controller

Which driver do you use? (check "ip -d -s link show can0").

> This CAN controller identifies itself (according to data sheet) as fo=
llows:
>     Vendor Identification Register    8086h
>     Device Identification Register    8818h
>     Revision Identification Register  00h
>     Class Code Register               0C0900h

Ah, the "pch_can" driver does have known issues. End of last year I sen=
t
some patches to improve the "pch_can" or, even better, make the "c_can"
driver work on the EG20T as well. See:

  http://marc.info/?l=3Dlinux-can&m=3D135531975013055&w=3D2

Are you able to build and use a recent mainline kernel? I need to figur=
e
out how to help you best.

Wolfgang.



