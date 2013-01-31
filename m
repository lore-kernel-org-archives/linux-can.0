From: =?iso-8859-1?Q?Heinz-J=FCrgen_Oertel?= <oe@port.de>
Subject: Re: [Socketcan-users] beginner question: can more than one
 application use one SocketCAN CAN Interface at the same time??
Date: Thu, 31 Jan 2013 10:38:37 +0000
Message-ID: <18893683.nzeVR25GSH@uschi>
References: <2B7735628AAB044EBC7362D10ED87CE2C850BA11F9@haex.Hamm.lokal>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from host24.networkinvest.de ([46.4.85.104]:54004 "EHLO
	host24.networkinvest.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754283Ab3AaKim convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 31 Jan 2013 05:38:42 -0500
In-Reply-To: <2B7735628AAB044EBC7362D10ED87CE2C850BA11F9@haex.Hamm.lokal>
Content-Language: de-DE
Content-ID: <0686FC2C63DB944D80955B465218BC58@portgmbh.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "Markus.Golbs@hamm.eu" <Markus.Golbs@hamm.eu>

Hello Markus;
(forgot cc: list)
Am Donnerstag, 31. Januar 2013, 09:45:47 schrieben Sie:
> Hello,
>=20
> I'm new by using SocketCAN. The shell communication on an arm board w=
ith
> SocketCAN works well, but I'm only use one access task/program to one=
 CAN
> Interface.
>=20
> My question is, can I use the SocketCAN network Interface from more a=
s on
> application on the same time? I want create two ANCI-C application on=
 this
> board for different functions. The two applications to integrate in o=
ne, is
> it not possible. If it possible that both applications use the same C=
AN
> Interface at the same time? About information I'm very happy.
>=20
> thanks and greetings

Short answer:
YES, two or more applications can share one physical interface,
using the same network interface, whether it is can0 or vcan0.

 Best regards
   Heinz-J=FCrgen Oertel