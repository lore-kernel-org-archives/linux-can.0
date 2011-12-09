From: <kime@ixxat.de>
Subject: RE: CAN State Information
Date: Fri, 9 Dec 2011 14:41:30 +0100
Message-ID: <166589D0B9DD2547A1319599B9BADA1FC19A38@vsv-exchange.ixxat.intranet.priv>
References: <166589D0B9DD2547A1319599B9BADA1FC1960C@vsv-exchange.ixxat.intranet.priv> <4EDE342E.8030102@grandegger.com> <166589D0B9DD2547A1319599B9BADA1FC1981F@vsv-exchange.ixxat.intranet.priv> <4EE10CB4.2090604@grandegger.com> <166589D0B9DD2547A1319599B9BADA1FC19968@vsv-exchange.ixxat.intranet.priv> <4EE1C3BF.70104@grandegger.com> <4EE1C47A.7080507@grandegger.com> <166589D0B9DD2547A1319599B9BADA1FC1998A@vsv-exchange.ixxat.intranet.priv> <4EE1CE2B.6090909@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.ixxat.net ([145.253.106.66]:56866 "EHLO mail.ixxat.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753607Ab1LINll convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 9 Dec 2011 08:41:41 -0500
Content-class: urn:content-classes:message
In-Reply-To: <4EE1CE2B.6090909@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com
Cc: socketcan-core@lists.berlios.de, linux-can@vger.kernel.org

I noticed that when libsocketcan calls send_dump_request() it returns a=
 message for me that has a length of 3424 with recvmsg().  This is not =
the full message, if I add a loop into the routine to again receive, I =
receive a second message this time with a length of 1424.  I added some=
 prints into the routine to output strings and sizes:

=46irst read:
nl_msg:-1073753668  u_msglen:3424
lo
nl_msg:-1073752676  u_msglen:2432
eth0
nl_msg:-1073751668  u_msglen:1424
can0
nl_msg:-1073750956  u_msglen:712
can1

Second read:
nl_msg:-1073753668  u_msglen:1424
can2
nl_msg:-1073752956  u_msglen:712
can3

With this loop, it seems to work.  Does this make sense?

Mit freundlichen Gr=FCssen / Yours sincerely,

James Kime
Entwicklung / Development
--------------------------------------------
IXXAT Automation GmbH
Leibnizstr. 15, 88250 Weingarten, Germany
Phone +49-751-56146-181
=46ax   +49-751-56146-29
mailto:kime@ixxat.de
http://www.ixxat.de
--------------------------------------------
PRIVILEGED AND CONFIDENTIAL.
Any unauthorized use or disclosure
is strictly prohibited.
--------------------------------------------
Sitz der Gesellschaft: Weingarten
Handelsregister Ulm HRB 551905
Gesch=E4ftsf=FChrer:
Dipl.-Ing. Christian Schlegel
--------------------------------------------


-----Original Message-----
=46rom: Wolfgang Grandegger [mailto:wg@grandegger.com]=20
Sent: Friday, December 09, 2011 10:00 AM
To: Kime, James
Cc: socketcan-core@lists.berlios.de; linux-can@vger.kernel.org
Subject: Re: CAN State Information

On 12/09/2011 09:45 AM, kime@ixxat.de wrote:
> I am new to using trace, but I think this is the output you are looki=
ng for:=20
>=20
=2E..
>        canconfig-3288  [000]  3756.163033: can_fill_xstats <-rtnl_lin=
k_fill
>        canconfig-3288  [000]  3756.163034: can_fill_info <-rtnl_link_=
fill
>        canconfig-3288  [000]  3756.163041: can_fill_xstats <-rtnl_lin=
k_fill
>        canconfig-3288  [000]  3756.163042: can_fill_info <-rtnl_link_=
fill
>        canconfig-3288  [000]  3756.163047: can_fill_xstats <-rtnl_lin=
k_fill
>        canconfig-3288  [000]  3756.163048: can_fill_info <-rtnl_link_=
fill
>        canconfig-3288  [000]  3756.163066: can_fill_xstats <-rtnl_lin=
k_fill
>        canconfig-3288  [000]  3756.163067: can_fill_info <-rtnl_link_=
fill
>        canconfig-3288  [000]  3756.163073: can_fill_xstats <-rtnl_lin=
k_fill
>        canconfig-3288  [000]  3756.163073: can_fill_info <-rtnl_link_=
fill

Yep, I wanted to check if can_fill_info() is called at all. Actually,
can_fill_info() does not return an error code so what I can think off i=
s
a mismatch in the data structure. What kernel CAN header files did you
use when building libsocketcan?

Next step would be to use "gdb" to find out where the error happend in
the code. Most errors while print an error message, though.

Wolfgang.

