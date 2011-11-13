From: Willy Lambert <lambert.willy@gmail.com>
Subject: Re: [Socketcan-users] Using sja1000_isa on a 64b system
Date: Sun, 13 Nov 2011 09:42:54 +0100
Message-ID: <CAKvQZ_1QmJAPUZAEvV-2FSo2HR4byApoEqWPnOts9up90U4BVg@mail.gmail.com>
References: <CAKvQZ_3HSdfOn4xGq7j8GsWJ+iHVan0Ygr=tR+cQm-tpQQWV2A@mail.gmail.com>
	<4E4CA945.7080504@hartkopp.net>
	<4E4CC9D5.6040708@pengutronix.de>
	<CAKvQZ_0raVFUsCFYA2FVH_138DCMw6ipKHdz=Dh62K4YpM5o=Q@mail.gmail.com>
	<4E5CCAA5.4030009@grandegger.com>
	<CAKvQZ_0TFUd4FwOvr4AXArviMYPGHH6Xex4Cjy7LxYoEuBUpxA@mail.gmail.com>
	<4E6271CD.6040407@grandegger.com>
	<CAKvQZ_2PyM5zo5-4PtrMGjMEML3j02MKCCJU=zpnkSK2N_XUjg@mail.gmail.com>
	<4E64B6CB.8010505@grandegger.com>
	<CAKvQZ_1gp9XvVmh+ZEUdEVz2TrvkhHtVKc20ViNgSx=uuPWajQ@mail.gmail.com>
	<4E653775.4030503@grandegger.com>
	<CAKvQZ_28skey9u+rDXi8mkrYiuhTQwnUAAhNMsPNqT-ZP3VNkg@mail.gmail.com>
	<4EBB8CFD.3050602@grandegger.com>
	<CAKvQZ_3d=2-0+RrxkjCe7Nxvtgn42uYOS4f4B7_6TmaxEji7UQ@mail.gmail.com>
	<CAKvQZ_0Ymdy1f6oUPHVxqEVp42z+OcfygQL1z_FR1aQ5Cwwmbw@mail.gmail.com>
	<4EBEE043.6070601@grandegger.com>
	<4EBEE1D8.7040407@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33952 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344Ab1KMImz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 13 Nov 2011 03:42:55 -0500
Received: by wyh15 with SMTP id 15so5007977wyh.19
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2011 00:42:54 -0800 (PST)
In-Reply-To: <4EBEE1D8.7040407@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: "socketcan-users@lists.berlios.de" <socketcan-users@lists.berlios.de>, linux-can@vger.kernel.org

2011/11/12 Wolfgang Grandegger <wg@grandegger.com>:
> On 11/12/2011 10:08 PM, Wolfgang Grandegger wrote:
>> On 11/12/2011 10:55 AM, Willy Lambert wrote:
> ...
>>>> I failed to apply the patch, is it for 2.6.38.8 kernels ?
>>
>> No, it's for up-to-date *mainline* linux version 3.1.x. Any chance to
>> switch to David Miller's "net-nex-2.6" tree?. Otherwise I'm going to
>> adapt the patch to 2.6.38.8.
>
> Well, the patch also applies to 2.6.38.8. Maybe you have some problems
> extracting the patch. Therefore I have attached it as attachment this
> time. Good luck.

It's ok now :
ard@ard-host:~/src/linux-2.6.38.8$ patch -p1 < wg_platform.patch
patching file drivers/net/can/sja1000/Kconfig
patching file drivers/net/can/sja1000/sja1000_isa.c

I must have done something wrong. I am going to test it now


>
> Wolfgang.
>
