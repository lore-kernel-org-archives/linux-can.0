From: Olivier Sobrie <olivier@sobrie.be>
Subject: Re: Kvaser socketCAN support
Date: Thu, 1 May 2014 22:46:09 +0200
Message-ID: <20140501204609.GA25569@thinkoso.home>
References: <f0331cq3H1VPknv.RZmta@smtp.rzone.de>
 <535559FC.70506@hartkopp.net>
 <r049e3q3UHfiSQJ.RZmta@smtp.rzone.de>
 <53620C3B.9080402@hartkopp.net>
 <R0595dq41EVg2BS.RZmta@smtp.rzone.de>
 <53627522.7000106@hartkopp.net>
 <53628879.751e8c0a.6be4.ffffc061SMTPIN_ADDED_MISSING@mx.google.com>
Reply-To: Olivier Sobrie <olivier@sobrie.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:52292 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154AbaEAUp7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 1 May 2014 16:45:59 -0400
Received: by mail-ee0-f49.google.com with SMTP id e53so2515223eek.22
        for <linux-can@vger.kernel.org>; Thu, 01 May 2014 13:45:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <53628879.751e8c0a.6be4.ffffc061SMTPIN_ADDED_MISSING@mx.google.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Smith, Christopher - 0999 - MITLL" <chris.smith@ll.mit.edu>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, "Adams, Shawn - 0999 - MITLL" <shawn.adams@ll.mit.edu>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Kvaser Support (support@kvaser.com)" <support@kvaser.com>

Hi Christopher,

On Thu, May 01, 2014 at 01:46:25PM -0400, Smith, Christopher - 0999 - MITLL wrote:
> Oliver, thank you for taking a look at this.  I'm guessing that other
> testing you did used that same USB command and did not have any problem?  If
> so perhaps it's an issue of firmware on our device or perhaps a slightly
> different version of hardware.  The device is the Kvaser Memorator with
> firmware 2.2.600.

I just plugged a Kvaser Memorator Professionnal and don't see any probe
error. My device is running firmware v2.0.50.

> > root@localhost:~# lsusb
> > Bus 001 Device 002: ID 0bfd:0017 Kvaser AB
> 
> Looks like a
> #define USB_LEAF_PRO_LIN_PRODUCT_ID	17
> 
> > root@localhost:~# dmesg |grep -i can
> > [    4.231784] CAN device driver interface
> > [    5.233369] kvaser_usb 1-1:1.0: Cannot get software infos, error -110

A probe problem has been fixed for this hardware. See the following commit
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=a90f13b24fb40d02d11496cce6a10ae8d4b319b2
This problem is present in version 3.8.
The patch has been included in linux 3.12 and backported in stable branches
of v3.10 and v3.11. So please upgrade :-)

Let us know if it solves your problem.

Kind regards,

-- 
Olivier
