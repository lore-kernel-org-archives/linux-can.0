From: John Whitmore <arigead@gmail.com>
Subject: Re: SocketCAN on Intel Edison with MCP 2515
Date: Sun, 26 Jul 2015 11:54:50 +0100
Message-ID: <20150726105449.GB12301@bamboo.electronicsoup>
References: <CAKa_yg_Lrpw7J70UzJf5x2EeB6mrmbFarxgbYCf+xHyD8Nb2eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37984 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474AbbGZKzA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 26 Jul 2015 06:55:00 -0400
Received: by wibxm9 with SMTP id xm9so81952363wib.1
        for <linux-can@vger.kernel.org>; Sun, 26 Jul 2015 03:54:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAKa_yg_Lrpw7J70UzJf5x2EeB6mrmbFarxgbYCf+xHyD8Nb2eQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Gallagher <mjg@isomorphdevelopment.com>
Cc: linux-can@vger.kernel.org

On Wed, May 27, 2015 at 11:18:54AM -0400, Michael Gallagher wrote:
> Hello,
> 
> I am new to SocketCAN and have some basic questions, I'm hoping that
> someone might be able to point me in the right direction.
> 
> I have recompiled Yocto (uname - r returns 3.10.17-yocoto standard)
> and included the SocketCAN module as well as the drivers for the MCP
> 2515. I can see that the module has been installed, as dmesg | grep
> can returns:
> 
> [    0.754296] vcan: Virtual CAN interface driver
> [    2.033276] can: controller area network core (rev 20120528 abi 9)
> [    2.033429] can: raw protocol (rev 20120528)
> [    2.033447] can: broadcast manager protocol (rev 20120528 t)
> [    2.033476] can: netlink gateway (rev 20130117) max_hops=1
> 

Hi Mike,

Just looked at my RPi system and dmesg | grep can does mention can0
interface. That interface is brought up during power up by the kernel on my
system so that it's there ready for me to do ifconfig can0 up

I do have to have baud rate settings in place ready to go before I bring it
up.

Looks like your kernel is never bringing up that interface. Have you edited
the Board file for your device to add the Hardware, or used Device Tree if
your bootloader and Kernel can use Device Tree?

John
