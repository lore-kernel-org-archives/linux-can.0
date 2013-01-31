From: Willy Lambert <lambert.willy@gmail.com>
Subject: Re: [Socketcan-users] beginner question: can more than one
 application use one SocketCAN CAN Interface at the same time??
Date: Thu, 31 Jan 2013 11:27:42 +0100
Message-ID: <CAKvQZ_0KaYUrz553jDzzM7Qe49LfZR26qo3eOzRJSg_MtU5+yQ@mail.gmail.com>
References: <2B7735628AAB044EBC7362D10ED87CE2C850BA11F9@haex.Hamm.lokal>
	<510A4449.2000706@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:47534 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941Ab3AaK1n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 31 Jan 2013 05:27:43 -0500
Received: by mail-ie0-f179.google.com with SMTP id k11so909606iea.24
        for <linux-can@vger.kernel.org>; Thu, 31 Jan 2013 02:27:42 -0800 (PST)
In-Reply-To: <510A4449.2000706@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Markus.Golbs@hamm.eu, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

2013/1/31 Marc Kleine-Budde <mkl@pengutronix.de>:
> Hello Markus,
>
> please use linux-can@vger.kernel.org (Cc'ed), as the berlios list is
> outdated.
>
> On 01/31/2013 09:45 AM, Markus.Golbs@hamm.eu wrote:
>> I=92m new by using SocketCAN. The shell communication on an arm boar=
d with
>> SocketCAN works well, but I=92m only use one access task/program to =
one
>> CAN Interface.
>>
>> My question is, can I use the SocketCAN network Interface from more =
as
>> on application on the same time? I want create two ANCI-C applicatio=
n on
>> this board for different functions. The two applications to integrat=
e in
>> one, is it not possible. If it possible that both applications use t=
he
>> same CAN Interface at the same time? About information I=92m very ha=
ppy.
>
> You can open as many sockets from as many applications to CAN as you
> want (until you memory runs out) and send and receive CAN messages.
>
> Marc

The first exemple would be the shell introspection tools to see what's
going in and out when your application will be running.

>
>
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>
>
>
