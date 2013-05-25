From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: problem to using CAN on beaglebone black A5A
Date: Sat, 25 May 2013 13:37:08 +0200
Message-ID: <51A0A264.9060505@hartkopp.net>
References: <CABMxt4idBKa8tH4b4T4Z5AQir3UOOjvR1ocTv3OAN6Aqqtccpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:9326 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204Ab3EYLhN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 25 May 2013 07:37:13 -0400
In-Reply-To: <CABMxt4idBKa8tH4b4T4Z5AQir3UOOjvR1ocTv3OAN6Aqqtccpw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mohamed HAMZAOUI <requinham@gmail.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

On 25.05.2013 00:56, Mohamed HAMZAOUI wrote:

> I started with beaglebone black A5A, i installed on it the latest
> Angstrom image with : Linux beaglebone 3.8.13 #1 SMP Mon May 20
> 17:07:58 CEST 2013 armv7l GNU/Linux
> 
> I have a problem when I try to add a can device, i load with modprobe
> all necessary kernel module (can, ti_hecc, c_can, c_can_platform,
> can-raw, can-bcm) but when i execute
>> ip link add can0 type can
> I have : RTNETLINK answers: Operation not supported
> I used a recent version of iproute2.

You can NOT add real hardware devices with "ip link add ...".
This only works to create virtual CAN devices (vcan).

If you have a working CAN hardware in your system a 'can0' should already be
created by the CAN driver.

Please send the output of

cat /proc/net/dev

to see if there's a CAN device.

Or you might check the content of 'dmesg' output for CAN devices.

Regards,
Oliver

