From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: adding can4linux to drivers/char
Date: Sat, 21 Sep 2013 21:55:45 +0200
Message-ID: <523DF9C1.30300@grandegger.com>
References: <1881932.U1kQQJkqCz@heinz.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:33157 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190Ab3IUTzt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 21 Sep 2013 15:55:49 -0400
In-Reply-To: <1881932.U1kQQJkqCz@heinz.site>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Heinz-J=FCrgen_Oertel?= <hj.oertel@t-online.de>, linux-can@vger.kernel.org

On 09/21/2013 01:03 AM, Heinz-J=FCrgen Oertel wrote:
> Hello Linux CAN community,
>=20
> long before SocketCAN, which now is part of the Linux kernel drivers,=
 can4linux was available as the CAN device driver for Linux.
>=20
> I now like to add it to the kernel source tree as well. What to you t=
hink about it. And how should I start and proceed?
> I would like to start with the Xilinx XCANPS as can be found on the Z=
ynq processor. Maybe also with one PCI board, the CPC-PCI (EMS W=FCnsch=
e).
>=20
> What is the best way? My current development for the PC is based on O=
penSuse with kernel 3.7.10. for Xilinx it is kernel 3.10. Can I send a =
patch against 3.7 and to whom can I send it?
>=20
> Hope to get some answers helping me with the project. Thanks.

I fully share Marc's opinion. There is a working and portable driver
interface for the CAN bus. Why adding another one to the Linux kernel? =
I
think you need *strong* arguments to get it accepted. There might be
some CAN controllers not yet supported in Linux-CAN but I think it's
better (for the community) to invest in providing and posting Linux-CAN
patches for those devices instead. Porting can4linux applications to
Linux-CAN should be straight-forward and not a big deal.

Wolfgang.

