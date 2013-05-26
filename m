From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: problem to using CAN on beaglebone black A5A
Date: Sun, 26 May 2013 12:35:23 +0200
Message-ID: <51A1E56B.4010604@hartkopp.net>
References: <CABMxt4idBKa8tH4b4T4Z5AQir3UOOjvR1ocTv3OAN6Aqqtccpw@mail.gmail.com> <51A0A264.9060505@hartkopp.net> <CABMxt4hj-tqRD_aDk6QNMNyNiAjt9vNzb=4ziTpB28ZYAgH08A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:30560 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299Ab3EZKf0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 26 May 2013 06:35:26 -0400
In-Reply-To: <CABMxt4hj-tqRD_aDk6QNMNyNiAjt9vNzb=4ziTpB28ZYAgH08A@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mohamed HAMZAOUI <requinham@gmail.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

Hi Mohamed,

obviously your kernel does not detect the hardware.

AFAIK the beaglebone black has two D_CAN controllers onboard.

So the c_can driver (which supports the d_can hardware too) should work.
But i don't know how the platform data has to be configured to make your
kernel detect the CAN controllers and attach them to the correct pins.

What kind of CAN hardware (add-on board) do you use with your beaglebone black?

Regards,
Oliver

On 25.05.2013 13:55, Mohamed HAMZAOUI wrote:
> I run this command because i can't found any can device :
> root@beaglebone:~# cat /proc/net/dev
> Inter-|   Receive                                                |  Transmit
>  face |bytes    packets errs drop fifo frame compressed
> multicast|bytes    packets errs drop fifo colls carrier compressed
>     lo:     280       4    0    0    0     0          0         0
> 280       4    0    0    0     0       0          0
>   eth0:       0       0    0    0    0     0          0         0
>   0       0    0    0    0     0       0          0
>   usb0:   11042      79    0    0    0     0          0         0
> 13479      59    0    0    0     0       0          0
> 
> Any Idea ?
> 
> Regards,
> Mohamed
> 
> On Sat, May 25, 2013 at 1:37 PM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>> On 25.05.2013 00:56, Mohamed HAMZAOUI wrote:
>>
>>> I started with beaglebone black A5A, i installed on it the latest
>>> Angstrom image with : Linux beaglebone 3.8.13 #1 SMP Mon May 20
>>> 17:07:58 CEST 2013 armv7l GNU/Linux
>>>
>>> I have a problem when I try to add a can device, i load with modprobe
>>> all necessary kernel module (can, ti_hecc, c_can, c_can_platform,
>>> can-raw, can-bcm) but when i execute
>>>> ip link add can0 type can
>>> I have : RTNETLINK answers: Operation not supported
>>> I used a recent version of iproute2.
>>
>> You can NOT add real hardware devices with "ip link add ...".
>> This only works to create virtual CAN devices (vcan).
>>
>> If you have a working CAN hardware in your system a 'can0' should already be
>> created by the CAN driver.
>>
>> Please send the output of
>>
>> cat /proc/net/dev
>>
>> to see if there's a CAN device.
>>
>> Or you might check the content of 'dmesg' output for CAN devices.
>>
>> Regards,
>> Oliver
>>

