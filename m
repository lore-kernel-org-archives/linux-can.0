From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Fwd: problem to using CAN on beaglebone black A5A
Date: Mon, 03 Jun 2013 20:41:58 +0200
Message-ID: <51ACE376.1040807@grandegger.com>
References: <CABMxt4idBKa8tH4b4T4Z5AQir3UOOjvR1ocTv3OAN6Aqqtccpw@mail.gmail.com> <51A0A264.9060505@hartkopp.net> <CABMxt4hj-tqRD_aDk6QNMNyNiAjt9vNzb=4ziTpB28ZYAgH08A@mail.gmail.com> <51A1E56B.4010604@hartkopp.net> <CABMxt4h-0zYYBvjUqBdf=eChKXxJv77OPhQmh_y7rkwj18mdcQ@mail.gmail.com> <CABMxt4jMmBeMqFeyRMQ=5PtQtt6SHDGNGXUGm-WzPsW6Er9+SQ@mail.gmail.com> <51A4E30E.1080504@hartkopp.net> <51A4F0D0.3080107@grandegger.com> <CABMxt4gO+mQR3JshUDUztKC7oPt3zXcyZ-1Hp4dn7Wy7=CEhAQ@mail.gmail.com> <CABMxt4gBjFZnWCx-dY=PpnbQ7P96ZhXAeJQ71c34J3jtTKV_1A@mail.gmail.com> <51AC7C49.7070700@grandegger.com> <CABMxt4jcBXyJDs6D7N5SM7iBLvZGxk0geougX3u=Kf4_=74E2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:42253 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754544Ab3FCSmB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Jun 2013 14:42:01 -0400
In-Reply-To: <CABMxt4jcBXyJDs6D7N5SM7iBLvZGxk0geougX3u=Kf4_=74E2g@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mohamed HAMZAOUI <requinham@gmail.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

On 06/03/2013 08:03 PM, Mohamed HAMZAOUI wrote:
> I can't find DTS file, so can you give me more information about this file ?

DTS stands for "Device Tree Source"...

> there is the kernel output when I change the device tree to get can channels :

... so how do you change the device tree?

> [  113.083038] bone-capemgr bone_capemgr.9: part_number
> 'BB-BONE-SERL-01', version 'N/A'
> [  113.093905] bone-capemgr bone_capemgr.9: slot #7: generic override
> [  113.101776] bone-capemgr bone_capemgr.9: bone: Using override
> eeprom data at slot 7
> [  113.110931] bone-capemgr bone_capemgr.9: slot #7: 'Override Board
> Name,00A0,Override Manuf,BB-BONE-SERL-01'
> [  113.122488] bone-capemgr bone_capemgr.9: slot #7: Requesting part
> number/version based 'BB-BONE-SERL-01-00A0.dtbo
> [  113.134366] bone-capemgr bone_capemgr.9: slot #7: Requesting
> firmware 'BB-BONE-SERL-01-00A0.dtbo' for board-name 'Override Board
> Name', version '00A0'
> [  113.150154] bone-capemgr bone_capemgr.9: slot #7: dtbo
> 'BB-BONE-SERL-01-00A0.dtbo' loaded; converting to live tree
> [  113.162739] bone-capemgr bone_capemgr.9: slot #7: #2 overlays
> [  113.171190] platform 481d0000.d_can: alias fck already exists

You seem to use the alias twice.

> [  113.184668] c_can_platform 481d0000.d_can: invalid resource
> [  113.201248] c_can_platform 481d0000.d_can: control memory is not
> used for raminit
> [  113.218966] c_can_platform 481d0000.d_can: c_can_platform device
> registered (regs=fa1d0000, irq=71)
> [  113.243172] bone-capemgr bone_capemgr.9: slot #7: Applied #2 overlays.
> 
> I can't get the second CAN channel !

Some doc of the CAN device tree bindings can be found here:

-
http://lxr.linux.no/#linux+v3.8.6/Documentation/devicetree/bindings/net/can/c_can.txt

In a recent kernel tree, there seem to be support for two D_CAN devices
on the AM33xx SOCs:

-
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/am33xx.dtsi

I can not tell you more details because I'm not familiar with that CPU.
Hope it helps anyway.

Wolfgang.





Wolfgang.
