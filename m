From: Mirza Krak <mirza.krak@hostmobility.com>
Subject: Re: [PATCH 1/1] net: can: sja1000: Validate initialization state
 in start method
Date: Thu, 21 Aug 2014 10:44:52 +0200
Message-ID: <53F5B184.4050907@hostmobility.com>
References: <1407501050-16156-1-git-send-email-mirza.krak@hostmobility.com> <53EC8CD8.2040703@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:45021 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753468AbaHUIo6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 21 Aug 2014 04:44:58 -0400
Received: by mail-wg0-f42.google.com with SMTP id l18so8659359wgh.13
        for <linux-can@vger.kernel.org>; Thu, 21 Aug 2014 01:44:56 -0700 (PDT)
In-Reply-To: <53EC8CD8.2040703@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org


On 2014-08-14 12:18, Marc Kleine-Budde wrote:
> On 08/08/2014 02:30 PM, Mirza Krak wrote:
>> When sja1000 is not compiled as module the SJA1000 chip is only
>> initialized during device registration on kernel boot. Should the ch=
ip
>> get a hardware reset there is no way to reinitialize it without re-
>> booting the Linux kernel.
> Not good. :/
>
> However, you can manually unbind the device from the driver:
>
>> =E2=9E=9C (pts/0) mkl@hermippe:drivers/sja1000_plx_pci ll
>> total 0
>> lrwxrwxrwx 1 root root    0 Aug 14 12:15 0000:01:02.0 -> ../../../..=
/devices/pci0000:00/0000:00:1e.0/0000:01:02.0
>> --w------- 1 root root 4096 Aug 14 12:15 bind
>> lrwxrwxrwx 1 root root    0 Aug 14 12:15 module -> ../../../../modul=
e/plx_pci
>> --w------- 1 root root 4096 Aug 14 12:15 new_id
>> --w------- 1 root root 4096 Aug 14 12:15 remove_id
>> --w------- 1 root root 4096 Aug 14 12:15 uevent
>> --w------- 1 root root 4096 Aug 14 12:15 unbind
>> =E2=9E=9C (pts/0) mkl@hermippe:drivers/sja1000_plx_pci echo 0000:01:=
02.0 | sudo tee unbind
> And then rebind it:
>
>> =E2=9E=9C (pts/0) mkl@hermippe:drivers/sja1000_plx_pci echo 0000:01:=
02.0 | sudo tee bind
Aah I see. You learn something new everyday.
>> This patch adds a check in sja1000_start if the chip is initialized,=
 if
>> not we initialize it.
> Applied to can.
I am sorry but applied to what? I haven't seen it been applied anywhere=
=20
when browsing linux-can on gitorious.
>
> Thanks,
> Marc
>

--=20
Med V=C3=A4nliga H=C3=A4lsningar / Best Regards

*******************************************************************
Mirza Krak
Host Mobility AB
mirza.krak@hostmobility.com
Anders Personsgatan 12, 416 64 G=C3=B6teborg
Sweden
http://www.hostmobility.com
Direct: +46 31 31 32 704
Phone: +46 31 31 32 700
=46ax: +46 31 80 67 51
Mobile: +46 730 28 06 22
*******************************************************************

