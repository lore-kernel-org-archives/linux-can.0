From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: vcan to can0 bridging
Date: Thu, 19 Jun 2014 22:32:39 +0200
Message-ID: <20140619203239.GB12476@vandijck-laurijssen.be>
References: <CAEJ7JO2ejHBVANYWXxXe_DstXCW-hm9xzJYXifiU+RwYNS3M1A@mail.gmail.com>
 <539F3DDF.70007@hartkopp.net>
 <CAEJ7JO1a_5Z2yKYDw30XjXh3qt4Qr-yRUVMUkz9s3MRv=zLWhA@mail.gmail.com>
 <20140617161347.25cb639e@snail>
 <53A1EDA7.7040504@hartkopp.net>
 <20140619164424.244e5634@snail>
 <53A2F9EC.4060107@hartkopp.net>
 <20140619200110.7427bdfe@snail>
 <53A32133.7050300@hartkopp.net>
 <20140619220710.580a0879@snail>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay003.isp.belgacom.be ([195.238.6.53]:46145 "EHLO
	mailrelay003.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932071AbaFSUc6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 19 Jun 2014 16:32:58 -0400
Content-Disposition: inline
In-Reply-To: <20140619220710.580a0879@snail>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander GQ Gerasiov <gq@cs.msu.su>
Cc: linux-can@vger.kernel.org

Hey,

This idea just crossed my mind.

You have 2 orthogonal requirements for, I suppose, different applications.
Both requirement conflict when you're alone on the bus.
The key to success is to have each application require only 1 thing:
or you are able to communicate always,
or you receive exactly what is on physical CAN.

You can setup vcan & can0, as Oliver explained.
* applications that require permanent communication connect to vcan
* applications that require strict ordering connect to can0

If you're alone on the bus, your 'strict ordering' applications will
receive nothing, and that exactly what appears on the physical bus.
Your 'permanent communication' cannot receive strict ordering,
since nothing can be communicated then.

Kurt

On Thu, Jun 19, 2014 at 10:07:10PM +0400, Alexander GQ Gerasiov wrote:
> Thu, 19 Jun 2014 19:43:15 +0200
> Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> > So your hosts are absolutely synchronized (via ntp)??
> Offtopic: yes, ntp for dirty synchronization and then LinuxPPS
> for +/-5 microseconds precision.
> 
> > > On vcan you will see A (on T+dt1), B (on T+dt1+dt2).
> > 
> > How do you get the timestamp information then?
> 
> I put timestamps here just for example.
> 
> I just need that events traced by testbench software (on vcan in your
> example) should go in the same order as events real hardware (we are
> testing) will see on its interface.
> 
> > E.g. you can configute the routing rule with '-t' option to preserve
> > the src_dev rx timestamp. You would see the timestamp from the real
> > CAN tnen.
> > 
> > > On bus you will see B (on T+dt3), A (on T+dt3+dt4).
> > 
> > Hm - i wonder if you would really see a difference as the networking
> > stack is not real-time anyway.
> 
> Timestamps are not a problem (in real life they are :) ). I'm speaking
> about event's order 
> 
> > When sending on vcan (which has no
> > receive queue) the rx is performed instantly which leads to en-queue
> > the frame into the real CAN interface immediately.
> 
> Yes, after frame will be transmitted via vcan our soft will trace
> successfull send, but then this frame will go into tx-queue and here it
> could stuck because another (e.g. high prio) frame is transmitted by
> other host (real hardware) the same time.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
