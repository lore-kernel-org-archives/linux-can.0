From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Strange error with jspy utility: solved?
Date: Tue, 29 May 2012 09:37:04 +0200
Message-ID: <20120529073704.GA437@vandijck-laurijssen.be>
References: <CA+cPUuTWRQQ0qBnP1pE34wbMHF1OqXoBq5LkwQzkMgWFOyuzrA@mail.gmail.com>
 <20120519051517.GA416@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:22016 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752706Ab2E2HhH (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 29 May 2012 03:37:07 -0400
Content-Disposition: inline
In-Reply-To: <20120519051517.GA416@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Abdul Khan <akhan@symboticware.com>, linux-can@vger.kernel.org

> Hi Kurt
> 
> Thanks for your response, I was away for few days. Please see below my
> findings in-line.
> 
> > From your story, I assume you connected can0 & can1 together?
> 
> Yes, can0 and can1 are connected together.
> can0 hi   <--> can1 hi
> can0 lo   <--> can1 lo
> can0 grd <--> can1 grd

Very well.
> 
> > I cannot look on your CAN bus. I'd need a raw CAN dump too
> > if I want to really debug this remotely.
> 
> ./cansend can0 123#1122334455667788
> 
> ./candump can1
> 
> Output:
> =====
> can1 123 [8] 11 22 33 44 55 66 77 88

You proved the CAN bus is working with 11bit identifiers.
I meant to do candump in parallel with the j1939 tests.

> 
> > $ ./jsr can0:20,feda &
> > $ echo "hello" | ./jsr can1:40,feda
> 
> I did try with this.
> 
> > Then, you will see the seond instance of jsr terminating
> > quite soon, after having sent 1 packet.
> 
> Yes, second instance of jsr terminating, after having sent 1 packet.
> 
> > The first instance of jsr will receive that (via CAN) and print
> > on stdout.
> >
> > $ jspy
> > should then show 1 packet.
> >
> 
> ./jspy -P -v
> 
> Output:
> =====
> can0:40, 0feda - !6 [6] 68656c6c 6f0a
>                       - !6 [6] 68656c6c 6f0a
I believe the output of
	$ candump can0
would have been:
can0 18feda40 [6] 68 65 6c 6c 6f 0a

I think your system is working fine.
The problem you faced is that 'jsr's use is not very wel documented :-)

Regards,
Kurt
> 
> Thanks
> Abdul.
