From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: cansniffer loop time
Date: Tue, 24 Jun 2014 17:44:26 +0200
Message-ID: <53A99CDA.9090906@hartkopp.net>
References: <53A99784.5020609@thm-motorsport.de> <53A99ABD.7020407@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:11973 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754650AbaFXPo2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Jun 2014 11:44:28 -0400
In-Reply-To: <53A99ABD.7020407@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Felix Seitz <felix.seitz@thm-motorsport.de>, linux-can@vger.kernel.org

Hi Marc,

the cansniffer (from can-utils) opens a CAN_BCM socket and configures filter
jobs to get updates on every data change (content change in the payload).

There's a loop parameter that can be tuned to ensure a proper (cyclic) update
on the screen, which can be set in x100ms steps.

Indeed I did not look into this (useful) tool since 2007 :-)

Still looks like a good coding style - but I really did not get behind it's
functionality in two minutes to answer Felix' question.

Obviously some comments would enhance the coding style then :-)

Cheers,
Oliver

On 24.06.2014 17:35, Marc Kleine-Budde wrote:
> Hey Felix,
> 
> On 06/24/2014 05:21 PM, Felix Seitz wrote:
>> we from THM Motorsport are using the cansniffer running on a Raspberry
> 
> What is "the cansniffer"?
> 
>> Pi to read out sensor data traffic on the CANbus in our car.
>> I would like to set the cansniffer's loop time lower than 100ms. I tried
>> to changing the source code but apparently I don't fully understand
>> where the loop delay comes from.
>> Could you give me some tips on how to set a lower delay for the
>> cansniffer? 20ms delay would be perfect.
> 
> Despite the fact, that the rpi is not the best hardware/software for
> doing CAN under Linux, there is no delay within the Linux Kernel that
> would cause a loop delay.
> 
> If you see such a delay it's probably in the application of "the
> cansniffer". The rpi has no CAN controller on the board, there are
> several possibilities to upgrade CAN support. The worst solution is to
> attach an mcp2515 via SPI, USB based CAN dongles give much better
> performance. However USB on the rpi is quite bad, too...
> 
> Marc
> 
