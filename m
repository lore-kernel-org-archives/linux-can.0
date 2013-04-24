From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Is there any way of getting the CAN interfaces list, from any C
 program?
Date: Wed, 24 Apr 2013 11:06:24 +0200
Message-ID: <5177A090.6010904@peak-system.com>
References: <5169B395.2070703@hartkopp.net> <516D2ABB.4000300@pengutronix.de>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:35470 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758076Ab3DXJSp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 24 Apr 2013 05:18:45 -0400
In-Reply-To: <516D2ABB.4000300@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi linux-can members,

I currently wonder whether it exists any way of getting the list of the=
=20
installed CAN interfaces, from a C program?
I mean, getting the network interfaces list is available using=20
ioctl(SIOCGIFCONF).
But AFAIK, this (only) returns the IP interfaces found in the system,=20
even using a socket CAN file descriptor.
And, I would also like to avoid some pipe/fork/grep/sed in this C=20
program too ;-)

Thanks for your help and best regards,

St=E9phane
--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
