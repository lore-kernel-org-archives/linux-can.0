From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: Standard CAN over IP
Date: Thu, 05 Feb 2015 11:50:22 +1100
Message-ID: <54D2BE4E.7090202@optusnet.com.au>
References: <CACsJT9Nxv2Vuq92nnOw4eN6j-RycpqGRErsjp5R_LiMwdS13aQ@mail.gmail.com> <54D284B4.5050501@uni-bremen.de> <CACsJT9NuErtQOxTXffx=WYS5j6u8A-mv1XuA6Jxusn+tcDSRrw@mail.gmail.com>
Reply-To: tom_usenet@optusnet.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:53588 "EHLO
	mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966372AbbBEAuZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 4 Feb 2015 19:50:25 -0500
In-Reply-To: <CACsJT9NuErtQOxTXffx=WYS5j6u8A-mv1XuA6Jxusn+tcDSRrw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mike Purvis <mpurvis@clearpathrobotics.com>, Armin Burchardt <armin@uni-bremen.de>
Cc: linux-can@vger.kernel.org

On 05/02/15 08:38, Mike Purvis wrote:
> Armin=E2=80=94
>
> Fantastic, thanks for the pointer, this is just what I was looking
> for. I've given it a quick try, and the binary in Ubuntu 14.04's
> can-utils package appears to do what I want in terms of creating a ne=
t
> device.
>
> For future travellers, the protocol is documented in the slcan.c
> source file, from the kernel tree:

That Kconfig in drivers/net/can also has the following in it:

       config CAN_SLCAN
       As only the sending and receiving of CAN frames is implemented,
       this driver should work with the (serial/USB) CAN hardware from:
       www.canusb.com / www.can232.com / www.mictronics.de /
       www.canhack.de

If your PC has spare serial ports, or if you want to buy some reliable=20
USB-to-serial converters, then you might want to consider the above-men=
tioned=20
serial-to-can devices:

http://www.can232.com/?page_id=3D14

Or the normal USB ones on the above site. They might be cheap enough fo=
r you.=20
Or you could start here:

http://www.mictronics.de/projects/usb-can-bus/

Tom

