From: Francesco Giovannini <francesco.giovannini@iit.it>
Subject: RE: Can't start ESD CAN-USB/2
Date: Mon, 17 Feb 2014 17:13:56 +0100
Message-ID: <53023544.2010509@iit.it>
References: <52EBCACD.9080906@iit.it> <52EBCBFA.2090205@pengutronix.de> <52EBD794.3020503@iit.it> <52EBDCD2.6000301@pengutronix.de>,<52EBDD1D.4060503@pengutronix.de> <B83FB8757830C3428B64299F968D0F68034C56FE@IITMXWGE012.iit.local> <52EBE0D4.2060907@pengutronix.de> <52EBE25E.40707@iit.it> <52EBE3EA.6030706@pengutronix.de>,<5302108E.7080209@esd.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx.iit.it ([90.147.26.161]:14947 "EHLO es400ra01.iit.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750958AbaBQQN6 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 17 Feb 2014 11:13:58 -0500
Received: from es400ra01.iit.it (127.0.0.1) id h08qkc0171s0 for <linux-can@vger.kernel.org>; Mon, 17 Feb 2014 17:13:56 +0100 (envelope-from <prvs=1125384180=Francesco.Giovannini@iit.it>)
In-Reply-To: <5302108E.7080209@esd.eu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Matthias Fuchs <matthias.fuchs@esd.eu>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Matthias,

I am running a 64bit system, using the "desktop" kernel package from 
OpenSuSe.
I used the linux-source package provided in OpenSuSe 12.2, copied the 
.config, added the module via menuconfig and then ran
     make M=./drivers/net/can/usb in the kernel source tree

to build the module.

Used packages:

     kernel-desktop
     kernel-desktop-devel
     kernel-default-devel
     kernel-devel
     kernel-source
     kernel-syms


Below are the output of uname and lsb_release:

     fgiovannini@oSuseBox-IIT:~> uname -a
     Linux oSuseBox-IIT 3.4.63-2.44-desktop #1 SMP PREEMPT Wed Oct 2 
11:18:32 UTC 2013 (d91a619) i686 i686 i386 GNU/Linux

     fgiovannini@oSuseBox-IIT:~> lsb_release
     LSB Version:    n/a
     fgiovannini@oSuseBox-IIT:~> lsb_release -a
     LSB Version:    n/a
     Distributor ID:    SUSE LINUX
     Description:    openSUSE 12.2 (i586)
     Release:    12.2
     Codename:    Mantis


Francesco
--
Francesco Giovannini
Research Fellow
iCub Facility
Istituto Italiano di Tecnologia
Via Morego, 30 16163 Genova
email: francesco.giovannini@iit.it
web: www.iit.it



________________________________________
From: Matthias Fuchs [matthias.fuchs@esd.eu]
Sent: Monday, February 17, 2014 2:37 PM
To: Marc Kleine-Budde; Francesco Giovannini
Cc: linux-can@vger.kernel.org
Subject: Re: Can't start ESD CAN-USB/2

Hi Francesco,

On 01/31/2014 06:56 PM, Marc Kleine-Budde wrote:
> On 01/31/2014 06:50 PM, Francesco Giovannini wrote:
>> Yes I had to compile it myself because OpenSuse does not include it. I
>> first added it to the kernel config as a module and then ran make
>> M=./drivers/net/can/usb in the kernel source tree.
>
> Please don't top post.
>
> Have you used the kernel sources provided by suse? If not, try these.
> Try a different USB port on the machine, if the CAN adapter has a USB
> cable that is removable, swap it too. If it's still failing try a
> different machine.
>
> Marc
>
Can you answer Marc's question about the origin of the kernel module?
Did you built it yourself or are you using SuSE provided modules?
How did you built the module and from what sources?

Are you running on a 32 or 64 bit system?

Matthias

