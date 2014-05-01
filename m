From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Kvaser socketCAN support
Date: Thu, 01 May 2014 20:46:22 +0200
Message-ID: <5362967E.4040302@hartkopp.net>
References: <f0331cq3H1VPknv.RZmta@smtp.rzone.de> <535559FC.70506@hartkopp.net> <r049e3q3UHfiSQJ.RZmta@smtp.rzone.de>,<53620C3B.9080402@hartkopp.net> <R0595dq41EVg2BS.RZmta@smtp.rzone.de> <53627522.7000106@hartkopp.net> <6073ccq41HkW3ar.RZmta@smtp.rzone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:56167 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856AbaEASqa (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 1 May 2014 14:46:30 -0400
In-Reply-To: <6073ccq41HkW3ar.RZmta@smtp.rzone.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Smith, Christopher - 0999 - MITLL" <chris.smith@ll.mit.edu>, "Adams, Shawn - 0999 - MITLL" <shawn.adams@ll.mit.edu>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Olivier Sobrie <olivier@sobrie.be>, "Kvaser Support (support@kvaser.com)" <support@kvaser.com>

Hi Chris,

On 01.05.2014 19:46, Smith, Christopher - 0999 - MITLL wrote:
> Oliver, thank you for taking a look at this.  I'm guessing that other
> testing you did used that same USB command and did not have any problem? 

Just to make it clear:
I did no testing with Kvaser USB hardware as I do not have any of it here.
Don't mix me up with Olivier Sobrie (who wrote the Kvaser USB driver).

Regards,
Oliver (Hartkopp)

> If
> so perhaps it's an issue of firmware on our device or perhaps a slightly
> different version of hardware.  The device is the Kvaser Memorator with
> firmware 2.2.600.
> 
> Thanks,
> 
> Chris
> 
> -----Original Message-----
> From: Oliver Hartkopp [mailto:socketcan@hartkopp.net] 
> Sent: Thursday, May 01, 2014 12:24 PM
> To: Adams, Shawn - 0999 - MITLL
> Cc: Smith, Christopher - 0999 - MITLL; linux-can@vger.kernel.org; Olivier
> Sobrie; Kvaser Support (support@kvaser.com)
> Subject: Re: Kvaser socketCAN support
> 
> On 01.05.2014 16:31, Adams, Shawn - 0999 - MITLL wrote:
>> On boot, with the kvaser device attached we see a vcan0 Please find 
>> the output of lsusb and dmesg as well as the contents of /proc/net/dev
>>
>> root@localhost:~# cat /proc/net/dev
>> Inter-|   Receive                                                |
> Transmit
>>  face |bytes    packets errs drop fifo frame compressed multicast|bytes
> packets errs drop fifo colls carrier compressed
>>  vcan0:       0       0    0    0    0     0          0         0        0
> 0    0    0    0     0       0          0
>>     lo:    3432      40    0    0    0     0          0         0     3432
> 40    0    0    0     0       0          0
>>   eth0:       0       0    0    0    0     0          0         0     1646
> 11    0    0    0     0       0          0
> 
> Ok - you have a vcan0 (which is implemented by the virtual CAN 'vcan'
> driver).
> Nothing like "can0" we would expect from a *real* CAN interface :-(
> 
>>
>> root@localhost:~# lsusb
>> Bus 001 Device 002: ID 0bfd:0017 Kvaser AB
> 
> Looks like a
> #define USB_LEAF_PRO_LIN_PRODUCT_ID	17
> 
>> root@localhost:~# dmesg |grep -i can
>> [    4.231784] CAN device driver interface
>> [    5.233369] kvaser_usb 1-1:1.0: Cannot get software infos, error -110
> 
> Ugh!
> The driver fails to retrieve the firmware information. Therefore no 'can0'
> is created by the driver.
> 
> The return code '-110' is a timeout, see
> linux/include/uapi/asm-generic/errno.h:
> 
> #define ETIMEDOUT       110     /* Connection timed out */
> 
> So it looks like an USB communication problem - or the hardware does not
> know about the firmware information command.
> 
> Besides trying another PC with a different USB host adapter the only guys
> that might help in this situation are Olivier or Troy - I put them in CC.
> 
> Regards,
> Oliver
> 
