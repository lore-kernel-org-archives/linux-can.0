From: John Whitmore <arigead@gmail.com>
Subject: Re: SocketCAN on Intel Edison with MCP 2515
Date: Sun, 26 Jul 2015 11:05:44 +0100
Message-ID: <20150726100542.GC11080@bamboo.electronicsoup>
References: <CAKa_yg_Lrpw7J70UzJf5x2EeB6mrmbFarxgbYCf+xHyD8Nb2eQ@mail.gmail.com>
 <5566CF9C.4040302@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36867 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074AbbGZKFu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 26 Jul 2015 06:05:50 -0400
Received: by wibud3 with SMTP id ud3so80600769wib.0
        for <linux-can@vger.kernel.org>; Sun, 26 Jul 2015 03:05:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5566CF9C.4040302@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Tom Evans <tom_usenet@optusnet.com.au>
Cc: Michael Gallagher <mjg@isomorphdevelopment.com>, linux-can@vger.kernel.org

On Thu, May 28, 2015 at 06:19:40PM +1000, Tom Evans wrote:
> On 28/05/15 01:18, Michael Gallagher wrote:
> >Hello,
> >
> >I am new to SocketCAN and have some basic questions, I'm hoping that
> >someone might be able to point me in the right direction.
> >
> >I have recompiled Yocto (uname - r returns 3.10.17-yocoto standard)
> 
> That's pretty new. Newer linux versions rely more and more on the
> Device Tree. If the devices aren't enumerated in the Device Tree
> (meaning that you have an MCP2515 and it is at a specific
> address/chip-select on a particular SPI bus) then it won't enable
> it.
> 
> Linux used to be "Plug and Play", but they've fixed that bug...
> 
> Device Tree problems are really hard. The "language" and its
> "keywords" depend on every driver and every driver-writer, and they
> make different choices, and then change them when a new kernel comes
> out.
>

I'm certainly no expert but have to say that the Device Tree stuff is great,
from my point of view. I'm using RPi so previously had to edit a "C" board
file for my hardware and create structures to explain to the kernel what SPI
interface the MCP2515 was connected to, What SPI Clock Freq to use, and what
Chip Select pin to use. Then rebuild the kernel with that board file. Not
really Plug and Play.

With the later RPi kernels all I have to do is make sure MCP2515 driver is
included in the build and edit NO C files at all. Basically I then have a
device tree file that tells the RPi kernel you've got an MCP2515 connected on
Chip Select 1 and a RTC on Chip select 2. It does the rest. 

One point on the original question is that when you executed "dmesg | grep
can" there was no mention of "can0" at all. It looked like the kernel didn't
recognise the chip was there. I'll try to check this for you but I think when
my system boots it recognises the device and instantiates can0 device.

I might be wrong but I'll check.

John


> Check in the Documentation/devicetree/Bindings to see if it says what to do.
> 
> Tom
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
