From: Olivier Sobrie <olivier@sobrie.be>
Subject: Re: Kvaser socketCAN support
Date: Sun, 11 May 2014 22:34:09 +0200
Message-ID: <CAEM=fMo2w-mJZLuOKm9QD9T7fJzbXJ-JCBoSGAda3-iFAtCkUw@mail.gmail.com>
References: <f0331cq3H1VPknv.RZmta@smtp.rzone.de> <535559FC.70506@hartkopp.net>
 <r049e3q3UHfiSQJ.RZmta@smtp.rzone.de> <53620C3B.9080402@hartkopp.net>
 <R0595dq41EVg2BS.RZmta@smtp.rzone.de> <53627522.7000106@hartkopp.net>
 <53628879.751e8c0a.6be4.ffffc061SMTPIN_ADDED_MISSING@mx.google.com>
 <20140501204609.GA25569@thinkoso.home> <5363a95a.e3208c0a.bc54.574dSMTPIN_ADDED_MISSING@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:45773 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757481AbaEKUea (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 11 May 2014 16:34:30 -0400
Received: by mail-lb0-f174.google.com with SMTP id n15so6807093lbi.19
        for <linux-can@vger.kernel.org>; Sun, 11 May 2014 13:34:29 -0700 (PDT)
In-Reply-To: <5363a95a.e3208c0a.bc54.574dSMTPIN_ADDED_MISSING@mx.google.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Smith, Christopher - 0999 - MITLL" <chris.smith@ll.mit.edu>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, "Adams, Shawn - 0999 - MITLL" <shawn.adams@ll.mit.edu>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Kvaser Support (support@kvaser.com)" <support@kvaser.com>

Hello Christopher,

On 2 May 2014 16:19, Smith, Christopher - 0999 - MITLL
<chris.smith@ll.mit.edu> wrote:
> Sorry for the mix up to the Olivers.  I should have paid closer attention!
> The only thing I can figure at this point is something about the new
> firmware breaks the driver.  We've tried on a few machines and get the same
> error.  I also upgraded to device firmware 3.2.302 and see the same thing.
> I'm not sure how to downgrade the firmware as kvaser doesn't post those
> binaries.
>
> As for the kernel version, we're running 3.12.0 so I believe you're saying
> that does include the fix?

I found a Windows PC and upgraded the firmware of my kvaser Memorator
Professional. I just did a test with firmware 3.2.302 on linux v3.13. and didn't
see any problem in the probe function...
[554511.827130] usb 2-2: new high-speed USB device number 8 using ehci-pci
[554511.942497] usb 2-2: New USB device found, idVendor=0bfd, idProduct=0017
[554511.942502] usb 2-2: New USB device strings: Mfr=0, Product=2,
SerialNumber=0
[554511.942505] usb 2-2: Product: Kvaser Memorator Professional
[554511.947739] kvaser_usb 2-2:1.0: Firmware version: 3.2.302
[554511.954752] kvaser_usb 2-2:1.0 can0: device registered
[554511.971808] kvaser_usb 2-2:1.0 can1: device registered

Let me know if you still have an issue.
If so, try to take a wireshark capture.

Kind regards,

-- 
Olivier
