From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Flexcan - timestamp from message buffer to userspace
Date: Tue, 22 Oct 2013 21:36:40 +0200
Message-ID: <5266D3C8.90304@hartkopp.net>
References: <l3r0ki$hde$1@ger.gmane.org> <526113A1.8020403@kkmicro.cz> <526148E9.4040406@hartkopp.net> <5264CFA6.9050805@kkmicro.cz> <07b96b822a3778b2279d78b90cda3908@grandegger.com> <9d0a209e86731f7a68f84dbdc52124cc@grandegger.com> <5264EBB9.3010803@kkmicro.cz> <5264F918.1050408@kkmicro.cz> <df0fb8a7e99577852c73a96a605465c5@grandegger.com> <52655660.30100@hartkopp.net> <52666E0A.6000100@kkmicro.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:47267 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753971Ab3JVTgn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 22 Oct 2013 15:36:43 -0400
In-Reply-To: <52666E0A.6000100@kkmicro.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Martin Kozusky <mkozusky@kkmicro.cz>
Cc: linux-can@vger.kernel.org

On 22.10.2013 14:22, Martin Kozusky wrote:

> Then I noticed, that I have ctrmsg used in recvmsg
> msg.msg_control = &ctrlmsg
> msg.msg_controllen = sizeof(ctrlmsg);
> 
> defined as
> char ctrlmsg[CMSG_SPACE(sizeof(struct timeval)) + CMSG_SPACE(sizeof(__u32))];
> (yes, copied from candump when I was starting :)
> 

OMG!

What a shame. It's the classic situation not seeing a bug and a guy passing by
your place is pointing at the problem on the monitor :-)


> I tried to use definition from
> http://lxr.free-electrons.com/source/Documentation/networking/timestamping/timestamping.c
> 
> 
> struct {
>     struct cmsghdr cm;
>     char control[512];
> } ctrlmsg;
> 
> and wow,  it's working now :)

   \o/

> I have all 3 timestamps available and correct. And I can also use
> SO_TIMESTAMPING and SO_TIMESTAMP together

Me too.

> 
> I also added support for the call of ioctl/SIOCSHWTSTAMP to the flexcan driver
> (although it does nothing and later I removed this call from the program and
> just use setsockopt/SO_TIMESTAMPING)

Yes. I can see the HW timestamp from the PCAN USB driver directly now - after
enabling the HW timestamping flags in the TIMESTAMPING sockopt().

> 
> this is my patch for flexcan.c, I could also add support for hwtstamp to error
> frames, but I don't need that now.

This would be a good idea to implement this for error messages too.
I assume this was the reason to implement the ioctl() to configure if the
driver should do the work of evaluating the extra timestamps.

Btw. we know how to deal with the API for now. I was searching for a monotonic
SW timestamp that is not affected by any system time adjustments.
Maybe SOF_TIMESTAMPING_SYS_HARDWARE could be used for this, when a HW
timestamp is not available anyway.

Alternatively a fourth element could be added to the existing timestamps in

struct scm_timestamping {
        struct timespec systime;
        struct timespec hwtimetrans;
        struct timespec hwtimeraw;
        struct timespec monotonic; /* ??? */
};

Let's see ...

Thanks,
Oliver


