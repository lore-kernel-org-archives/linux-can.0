From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: iso-tp: timeout handling for unknown packet size
Date: Wed, 23 Oct 2013 18:00:57 +0200
Message-ID: <5267F2B9.2000704@hartkopp.net>
References: <CAJA4uhcj+ySw1j64vz4Ao1t62YzYcZfoNLkjsmFg-Pqf+mjy4g@mail.gmail.com> <CABLFF-=Rxi7Gtpr+OD5q5QsjD5fnrcZQaTJFoeT9a8UzuMbSEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:32478 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416Ab3JWQBE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 23 Oct 2013 12:01:04 -0400
In-Reply-To: <CABLFF-=Rxi7Gtpr+OD5q5QsjD5fnrcZQaTJFoeT9a8UzuMbSEA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Nathan Conrad <nconrad.mlock@gmail.com>
Cc: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>, linux-can <linux-can@vger.kernel.org>, Yannick Bedhomme <yannick.bedhomme@mobile-devices.fr>

On 23.10.2013 16:40, Nathan Conrad wrote:
> You could also add a filter for the ISO-TP reception ID to a raw
> protocol socket and monitor the reception of packets that way.  Non
> ISO-TP packets shouldn't be on that ID.
> 
> Nathan Conrad

Yes. This would be an idea.

You could also create a CAN_BCM socket to detect a timeout on a given CAN-ID.

See the BCM documentation(s) at

	http://marc.info/?l=linux-can&m=138217795117288&w=2

or the tst-bcm-*.c examples at

	https://gitorious.org/linux-can/can-tests/

With the BCM you can put the timeout handling completely into the kernel.

Regards,
Oliver



> 
> On Wed, Oct 23, 2013 at 8:32 AM, Josselin Costanzi
> <josselin.costanzi@mobile-devices.fr> wrote:
>> Hello,
>>
>> We are working with the current implementation of ISO-TP from Oliver
>> Hartkopp available on github. The implementation works well for us
>> with a slight limitation that we would like to discuss here.
>>
>> We use ISO-TP to talk to OBD ECUs. In this context, our userspace
>> opens an ISO-TP socket and sends an OBD-CAN request to the ECU and
>> waits for a response over ISO-TP. To be able to receive large frames
>> over ISO-TP or to account for transmitter having a large inter frame
>> delay, we have to use large timeout values so we don't close the
>> socket while the packet is still being received.
>>
>> We would like to know if an ECU is responding or not without having to
>> wait several seconds for a hypotetical packet to be received, do you
>> have any idea how we could do that?
>>
>> Thanks,
>>
>> --
>> Josselin Costanzi
>>   Embedded Linux System Engineer


