From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Is there any way of getting the CAN interfaces list, from any
 C program?
Date: Thu, 25 Apr 2013 09:24:29 +0200
Message-ID: <20130425072429.GA448@vandijck-laurijssen.be>
References: <5169B395.2070703@hartkopp.net>
 <516D2ABB.4000300@pengutronix.de>
 <5177A090.6010904@peak-system.com>
 <20130424144929.GA2077@vandijck-laurijssen.be>
 <5178D00C.70507@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay010.isp.belgacom.be ([195.238.6.177]:42540 "EHLO
	mailrelay010.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754869Ab3DYHYg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 25 Apr 2013 03:24:36 -0400
Content-Disposition: inline
In-Reply-To: <5178D00C.70507@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Thu, Apr 25, 2013 at 08:41:16AM +0200, Wolfgang Grandegger wrote:
> Hi Kurt,
>=20
> On 04/24/2013 04:49 PM, Kurt Van Dijck wrote:
> > Hi Stephane,
> >=20
> > I have written this some time ago, not using it actually.
> > I tried a modular approach, don't know if its usefull.
> >=20
> > PS: I used attachments.
>=20
> ~/enumif$ ./enumif
> 1: lo	{loopback} <LOOPBACK,UP,LOWER_UP> UNKNOWN
> 2: eth0	{ether} <BROADCAST,MULTICAST> DOWN
> 3: eth1	{ether} <BROADCAST,MULTICAST,UP,LOWER_UP> UNKNOWN
> 4: eth3	{ether} <NO-CARRIER,BROADCAST,MULTICAST,UP> DOWN
> 5: can0	{can} <NOARP,UP,LOWER_UP,ECHO> UNKNOWN
> 6: can1	{can} <NOARP,ECHO> DOWN
> 7: can2	{can} <NOARP,ECHO> DOWN
> 8: can3	{can} <NOARP,ECHO> DOWN
> 9: pan0	{ether} <BROADCAST,MULTICAST> DOWN
>=20
> Cool! We know that "ip link" does list all network interfaces but the
> code doing the job is not really strength-forward. I think this would=
 be
> a nice enhancement of the can-utils.

would it make sense to maintain the split into enumif-test.c and enumif=
=2Ec,
so for example Stephane could just link to libenumif.a?

Kurt
>=20
> Wolfgang.
>=20
> >=20
> > Kurt
> >=20
> > On Wed, Apr 24, 2013 at 11:06:24AM +0200, Stephane Grosjean wrote:
> >> Hi linux-can members,
> >>
> >> I currently wonder whether it exists any way of getting the list o=
f
> >> the installed CAN interfaces, from a C program?
> >> I mean, getting the network interfaces list is available using
> >> ioctl(SIOCGIFCONF).
> >> But AFAIK, this (only) returns the IP interfaces found in the
> >> system, even using a socket CAN file descriptor.
> >> And, I would also like to avoid some pipe/fork/grep/sed in this C
> >> program too ;-)
> >>
> >> Thanks for your help and best regards,
> >>
> >> St=C3=A9phane
> >> --
> >> PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt
> >> Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA
> >> Darmstadt HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.=
:
> >> DE39305391 Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329,
> >> info@peak-system.com
> >> ----
> >> To unsubscribe from this list: send the line "unsubscribe linux-ca=
n" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Kurt Van Dijck
GRAMMER EiA ELECTRONICS
http://www.eia.be
kurt.van.dijck@eia.be
+32-38708534
