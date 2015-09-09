From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: socket can receive order
Date: Wed, 09 Sep 2015 18:23:32 +0200
Message-ID: <55F05D04.6090908@hartkopp.net>
References: <55EEAD8D.3070603@engineeredarts.co.uk> <55EEB217.3080706@pengutronix.de> <55EEBB4E.6080104@engineeredarts.co.uk> <55EEC2BD.6010302@pengutronix.de> <55EEC3C0.1010002@engineeredarts.co.uk> <55EF133E.8070105@hartkopp.net> <CANGgnMZMRMtpugbN4x9Dh0v3i7zaAXRYfk+C1qhx1Nre=6WtEg@mail.gmail.com> <CAGt3f4nRhtx=W_2NWErmoS=o4x0qu89VzkfgLvsJ1=+WLYyJTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:39642 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbbIIQXl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 9 Sep 2015 12:23:41 -0400
In-Reply-To: <CAGt3f4nRhtx=W_2NWErmoS=o4x0qu89VzkfgLvsJ1=+WLYyJTw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Brian Silverman <brian@peloton-tech.com>, Austin Schuh <austin@peloton-tech.com>, Daniel Squires <dan@engineeredarts.co.uk>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 09.09.2015 05:10, Brian Silverman wrote:
> Another thing Austin and I do is set up RPS (receive packet steering)
> for the Ethernet interfaces so the hardware sends the physical
> Ethernet interrupts to that same core which isn't involved in
> servicing the CAN interfaces at all.
>
> On Tue, Sep 8, 2015 at 10:30 PM, Austin Schuh <austin@peloton-tech.com> wrote:
>>
>> On our boxes, I've been setting the affinity for both the IRQ thread
>> (we are running a RT kernel), and the interrupt to the same single
>> core.  Would that help here?

Yes it does.

Nailing the interrupts from ethernet and CAN interfaces to different CPUs by 
setting irq_affinity is a valid but pretty hard solution.

Therefore I was trying to use hash based RPS to fix the out-of-order problem 
and let the kernel networking do the (hopefully optimal) rest.

>> We've seen CAN packets get significantly delayed causing overruns due
>> to Ethernet load and both CAN and ethernet sharing the same softirq.
>> Our solution has been to set the affinity for each of those to
>> different cores to keep them isolated.

Yes. That's a good point. Due to the fact that you split up ethernet and CAN 
on different CPUs the softirq is also running on different CPUs.

This could also be the solution for Daniels problem!

My suggested solution (aka 'hack' 
http://marc.info/?l=linux-netdev&m=143689694125450&w=2 ) with the hash based 
RPS does not split the ethernet/CAN traffic among CPUs as - depending on the 
IP hashes - some of the ethernet traffic can be pushed into the same CPU we 
use for the CAN interface.

So it's a softer solution which at least fixes out-of-order for CAN interfaces.

Regards,
Oliver

ps. There were some performance tests (vanilla and RT kernel) from the 
University of Prague where you can see the impact of additional ethernet load:

http://rtime.felk.cvut.cz/can/

http://rtime.felk.cvut.cz/can/benchmark/3.0/
