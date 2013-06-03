From: Mohamed HAMZAOUI <requinham@gmail.com>
Subject: Re: Fwd: problem to using CAN on beaglebone black A5A
Date: Mon, 3 Jun 2013 20:03:37 +0200
Message-ID: <CABMxt4jcBXyJDs6D7N5SM7iBLvZGxk0geougX3u=Kf4_=74E2g@mail.gmail.com>
References: <CABMxt4idBKa8tH4b4T4Z5AQir3UOOjvR1ocTv3OAN6Aqqtccpw@mail.gmail.com>
	<51A0A264.9060505@hartkopp.net>
	<CABMxt4hj-tqRD_aDk6QNMNyNiAjt9vNzb=4ziTpB28ZYAgH08A@mail.gmail.com>
	<51A1E56B.4010604@hartkopp.net>
	<CABMxt4h-0zYYBvjUqBdf=eChKXxJv77OPhQmh_y7rkwj18mdcQ@mail.gmail.com>
	<CABMxt4jMmBeMqFeyRMQ=5PtQtt6SHDGNGXUGm-WzPsW6Er9+SQ@mail.gmail.com>
	<51A4E30E.1080504@hartkopp.net>
	<51A4F0D0.3080107@grandegger.com>
	<CABMxt4gO+mQR3JshUDUztKC7oPt3zXcyZ-1Hp4dn7Wy7=CEhAQ@mail.gmail.com>
	<CABMxt4gBjFZnWCx-dY=PpnbQ7P96ZhXAeJQ71c34J3jtTKV_1A@mail.gmail.com>
	<51AC7C49.7070700@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:57014 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757050Ab3FCSDj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Jun 2013 14:03:39 -0400
Received: by mail-lb0-f170.google.com with SMTP id t11so1420588lbd.15
        for <linux-can@vger.kernel.org>; Mon, 03 Jun 2013 11:03:37 -0700 (PDT)
In-Reply-To: <51AC7C49.7070700@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

I can't find DTS file, so can you give me more information about this file ?

there is the kernel output when I change the device tree to get can channels :
[  113.083038] bone-capemgr bone_capemgr.9: part_number
'BB-BONE-SERL-01', version 'N/A'
[  113.093905] bone-capemgr bone_capemgr.9: slot #7: generic override
[  113.101776] bone-capemgr bone_capemgr.9: bone: Using override
eeprom data at slot 7
[  113.110931] bone-capemgr bone_capemgr.9: slot #7: 'Override Board
Name,00A0,Override Manuf,BB-BONE-SERL-01'
[  113.122488] bone-capemgr bone_capemgr.9: slot #7: Requesting part
number/version based 'BB-BONE-SERL-01-00A0.dtbo
[  113.134366] bone-capemgr bone_capemgr.9: slot #7: Requesting
firmware 'BB-BONE-SERL-01-00A0.dtbo' for board-name 'Override Board
Name', version '00A0'
[  113.150154] bone-capemgr bone_capemgr.9: slot #7: dtbo
'BB-BONE-SERL-01-00A0.dtbo' loaded; converting to live tree
[  113.162739] bone-capemgr bone_capemgr.9: slot #7: #2 overlays
[  113.171190] platform 481d0000.d_can: alias fck already exists
[  113.184668] c_can_platform 481d0000.d_can: invalid resource
[  113.201248] c_can_platform 481d0000.d_can: control memory is not
used for raminit
[  113.218966] c_can_platform 481d0000.d_can: c_can_platform device
registered (regs=fa1d0000, irq=71)
[  113.243172] bone-capemgr bone_capemgr.9: slot #7: Applied #2 overlays.

I can't get the second CAN channel !

Regards,
Mohamed

On Mon, Jun 3, 2013 at 1:21 PM, Wolfgang Grandegger <wg@grandegger.com> wrote:
> On 06/03/2013 01:09 PM, Mohamed HAMZAOUI wrote:
>> Hi,
>>
>> Hardware : BeagleBone Black version A5A
>> (http://beagleboard.org/Products/BeagleBone%20Black )
>> Linux distribution : Angstrom
>> Linux kernel : 3.8.13
>> the driver for the can is C_CAN
>>
>> I can solve this issue by loading the correct cape firmware for my
>> BeagleBone Black with :
>> echo BB-BONE-SERL-01 > /sys/devices/bone_capemgr.9/slots
>> we need to have the related firmware in /lib/firmware and
>> bone_capemgr.9 have not always the same name (example bone_capemgr.7,
>> ...)
>>
>> The problem actually is that is not possible to load the second CAN
>> channel like mentionned by Olivier :
>> "A Problem of this board
>>
>> http://circuitco.com/support/index.php?title=TT3201_CAN_Cape#EEPROM
>>
>> is, that the pins for the second D_CAN are assigned to the I2C to read the
>> EEPROM. I have no idea how to solve this right now."
>
> OK, I see.
>
>> Any idea ?
>
> Maybe it could be done by just modifying the DTS file. Could you show
> that DTS file?
>
> Wolfgang.
>
>
