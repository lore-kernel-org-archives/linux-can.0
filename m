From: Mike Purvis <mpurvis@clearpathrobotics.com>
Subject: Re: Standard CAN over IP
Date: Thu, 5 Feb 2015 08:15:25 -0500
Message-ID: <CACsJT9NQGFKMBNjqh+C7pAAt=bcM4U4PL72sQYphAEPyeAxj8g@mail.gmail.com>
References: <CACsJT9Nxv2Vuq92nnOw4eN6j-RycpqGRErsjp5R_LiMwdS13aQ@mail.gmail.com>
 <54D284B4.5050501@uni-bremen.de> <CACsJT9NuErtQOxTXffx=WYS5j6u8A-mv1XuA6Jxusn+tcDSRrw@mail.gmail.com>
 <54D2BE4E.7090202@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:59762 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757511AbbBENPr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Feb 2015 08:15:47 -0500
Received: by mail-ig0-f169.google.com with SMTP id hl2so2130637igb.0
        for <linux-can@vger.kernel.org>; Thu, 05 Feb 2015 05:15:47 -0800 (PST)
In-Reply-To: <54D2BE4E.7090202@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: tom_usenet@optusnet.com.au
Cc: Armin Burchardt <armin@uni-bremen.de>, linux-can@vger.kernel.org

Hi Tom,

Yes, thanks=E2=80=94 in the short term, I'm going to prototype using an=
 off
the shelf USB-based device. In the fullness of time, I'll probably
either implement the protocol myself as part of a larger MCU also
doing some other stuff, or bring a BSD-licensed implementation of the
protocol, if such a thing exists.

Looks like you might be able to get CAN over TCP/UDP in two steps, by
using socat to link a pty to the network socket, and then running
slcand (or the guts of it) against the pty. Does anyone know what the
efficiency story is with socat? Does it copy back and forth between
between userspace and kernelspace, or is it able to operate fully in
kernel-land the way slcand does?

On 4 February 2015 at 19:50, Tom Evans <tom_usenet@optusnet.com.au> wro=
te:
> On 05/02/15 08:38, Mike Purvis wrote:
>>
>> Armin=E2=80=94
>>
>> Fantastic, thanks for the pointer, this is just what I was looking
>> for. I've given it a quick try, and the binary in Ubuntu 14.04's
>> can-utils package appears to do what I want in terms of creating a n=
et
>> device.
>>
>> For future travellers, the protocol is documented in the slcan.c
>> source file, from the kernel tree:
>
>
> That Kconfig in drivers/net/can also has the following in it:
>
>       config CAN_SLCAN
>       As only the sending and receiving of CAN frames is implemented,
>       this driver should work with the (serial/USB) CAN hardware from=
:
>       www.canusb.com / www.can232.com / www.mictronics.de /
>       www.canhack.de
>
> If your PC has spare serial ports, or if you want to buy some reliabl=
e
> USB-to-serial converters, then you might want to consider the
> above-mentioned serial-to-can devices:
>
> http://www.can232.com/?page_id=3D14
>
> Or the normal USB ones on the above site. They might be cheap enough =
for
> you. Or you could start here:
>
> http://www.mictronics.de/projects/usb-can-bus/
>
> Tom
>
