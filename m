From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Fwd: problem to using CAN on beaglebone black A5A
Date: Mon, 03 Jun 2013 13:21:45 +0200
Message-ID: <51AC7C49.7070700@grandegger.com>
References: <CABMxt4idBKa8tH4b4T4Z5AQir3UOOjvR1ocTv3OAN6Aqqtccpw@mail.gmail.com> <51A0A264.9060505@hartkopp.net> <CABMxt4hj-tqRD_aDk6QNMNyNiAjt9vNzb=4ziTpB28ZYAgH08A@mail.gmail.com> <51A1E56B.4010604@hartkopp.net> <CABMxt4h-0zYYBvjUqBdf=eChKXxJv77OPhQmh_y7rkwj18mdcQ@mail.gmail.com> <CABMxt4jMmBeMqFeyRMQ=5PtQtt6SHDGNGXUGm-WzPsW6Er9+SQ@mail.gmail.com> <51A4E30E.1080504@hartkopp.net> <51A4F0D0.3080107@grandegger.com> <CABMxt4gO+mQR3JshUDUztKC7oPt3zXcyZ-1Hp4dn7Wy7=CEhAQ@mail.gmail.com> <CABMxt4gBjFZnWCx-dY=PpnbQ7P96ZhXAeJQ71c34J3jtTKV_1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:37263 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755905Ab3FCLVs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Jun 2013 07:21:48 -0400
In-Reply-To: <CABMxt4gBjFZnWCx-dY=PpnbQ7P96ZhXAeJQ71c34J3jtTKV_1A@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mohamed HAMZAOUI <requinham@gmail.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>, Oliver Hartkopp <oliver.hartkopp@volkswagen.de>

On 06/03/2013 01:09 PM, Mohamed HAMZAOUI wrote:
> Hi,
> 
> Hardware : BeagleBone Black version A5A
> (http://beagleboard.org/Products/BeagleBone%20Black )
> Linux distribution : Angstrom
> Linux kernel : 3.8.13
> the driver for the can is C_CAN
> 
> I can solve this issue by loading the correct cape firmware for my
> BeagleBone Black with :
> echo BB-BONE-SERL-01 > /sys/devices/bone_capemgr.9/slots
> we need to have the related firmware in /lib/firmware and
> bone_capemgr.9 have not always the same name (example bone_capemgr.7,
> ...)
> 
> The problem actually is that is not possible to load the second CAN
> channel like mentionned by Olivier :
> "A Problem of this board
> 
> http://circuitco.com/support/index.php?title=TT3201_CAN_Cape#EEPROM
> 
> is, that the pins for the second D_CAN are assigned to the I2C to read the
> EEPROM. I have no idea how to solve this right now."

OK, I see.

> Any idea ?

Maybe it could be done by just modifying the DTS file. Could you show
that DTS file?

Wolfgang.


