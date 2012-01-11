From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Softing Firmware on gitorious
Date: Wed, 11 Jan 2012 19:06:49 +0100
Message-ID: <4F0DCFB9.7060901@hartkopp.net>
References: <4F0DB66F.50509@hartkopp.net> <3458527.PgLK1e9PLF@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:17508 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932432Ab2AKSG7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Jan 2012 13:06:59 -0500
In-Reply-To: <3458527.PgLK1e9PLF@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Kurt Van Dijck <kurt.van.dijck@eia.be>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 11.01.2012 17:57, Alexander Stein wrote:

> Hello,
> 
> On Wednesday 11 January 2012 17:18:55 Oliver Hartkopp wrote:
>> The question is now:
>>
>> 1. change the link in the Kconfig
>> 2. Add the PCMCIA firmware to the Linux Kernel (linux/firmware/*.ihex)
>> 3. 1 & 2
> 
> According to firmware/README.AddingFirmware new firmware files should go to 
> git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
> For more details see the mentioned readme file.


Hello Alexander,

thanks for the hint!

As already written to Marc, i'll search for some license info in the 2008
driver package. Looking into the firmware git repo and especially into the
file WHENCE

http://git.kernel.org/?p=linux/kernel/git/firmware/linux-firmware.git;a=blob;f=WHENCE

we have a wide variance between 'no license' and detailed license information.

Let's see :-)

Best regards,
Oliver
