From: Chris Morgan <chmorgan@gmail.com>
Subject: Re: canfd through slcan via SocketCAN
Date: Mon, 17 Feb 2020 19:01:42 -0500
Message-ID: <81FEDC66-54A7-4B53-911E-80122446A453@gmail.com>
References: <B1BB0B55-5478-4C06-AAC2-B27AB986755B@gmail.com>
 <ca7db9dc-991e-e2f7-a3a7-dc13a0880581@hartkopp.net>
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qv1-f42.google.com ([209.85.219.42]:34741 "EHLO
        mail-qv1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgBRABp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Feb 2020 19:01:45 -0500
Received: by mail-qv1-f42.google.com with SMTP id o18so8371449qvf.1
        for <linux-can@vger.kernel.org>; Mon, 17 Feb 2020 16:01:45 -0800 (PST)
In-Reply-To: <ca7db9dc-991e-e2f7-a3a7-dc13a0880581@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

HI Oliver.

> On Feb 17, 2020, at 3:16 PM, Oliver Hartkopp <socketcan@hartkopp.net> =
wrote:
>=20
> Hi Chris,
>=20
> On 16/02/2020 14.43, Chris Morgan wrote:
>=20
>> I=E2=80=99m looking at options to add canfd support to embedded =
processors via serial using slcan. I=E2=80=99d like the devices to be =
available via socketcan. Looking at the slcan driver it looks like the =
MTU is something around 30 bytes and there isn=E2=80=99t any mention of =
canfd in the driver or in the userspace utilities. Am I missing =
something with this support? If slcan doesn=E2=80=99t support canfd yet =
is anyone working to add any?
>=20
> The slcan driver implements the SLCAN aka Lawicel protocol, originally =
provided by http://www.can232.com/
>=20
> See documentation at:
> http://www.can232.com/docs/can232_v3.pdf
>=20

This is super helpful, thanks for the pointer there. I didn=E2=80=99t =
realize so many letters were already in use but it looks like there are =
some openings in the protocol.


> Other low cost serial CAN adapters adopted this simple protocol, see =
this overview:
>=20
> https://github.com/linux-can/can-misc/blob/master/docs/SLCAN-API.pdf
>=20
> By today there is no CAN FD capable CAN interface using the SLCAN =
protocol on the market!!
>=20
> You would need to set a second bitrate (data bitrate) and you would =
need a separated data frame identifier for CAN FD frames.
>=20
> Today:
>=20
> t/T -> Classic CAN data frame
> r/R -> Classic CAN rtr frame (not in CAN FD)
>=20
> According to the above documents we would been able to use:
>=20
> d/D -> CAN FD data frame (with BRS/ESI flags!)
> k/K -> set FD data bitrates (analogue to s/S)
>=20
> The biggest problem with defining these values/characters and adding =
them to the slcan driver in the Linux kernel, is that WE DO NOT KNOW =
whether future serial CAN FD interfaces will follow our suggestion.
>=20
> Usually you have a hardware providing an API/protocol and THEN the =
driver developers write the driver - and not the other way around ;-)
>=20

Heh. I can appreciate that.

I=E2=80=99m working with a MT7688 platform that only supports half =
duplex spi and looking for a low cost canfd solution for that platform. =
I=E2=80=99m not sure exactly if that prevents me from using an existing =
MCP251x driver or not but I=E2=80=99ve heard this is the case. There is =
also a software spi driver, spi-gpio-custom in openwrt that is an =
option.

The idea with slcan would be to use a SAM21 microcontroller with dual =
canfd controllers to provide canfd functionality, implementing the slcan =
client in the SAM21 firmware.

I=E2=80=99m still not sure what the best approach might be. I am =
hesitating to use a usb based adapter but that=E2=80=99s another option =
as well.

Thoughts?

Regards,
Chris
