From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: [PATCH] Add TX limit for SocketCAN.
Date: Fri, 1 Sep 2017 09:52:43 +0200
Message-ID: <20170901075243.GA30725@airbook.vandijck-laurijssen.be>
References: <1504232079-2583-1-git-send-email-zhongjie.shi@intel.com>
 <CANGgnMb5-cKT=PjxEF6yYAcUkcP29BRnHU+_xY3ASsT-GQ6qzQ@mail.gmail.com>
 <106C4230743D00439F3B474E2F2FC8CD53885BF7@SHSMSX101.ccr.corp.intel.com>
 <CANUzxrqNGZ7A_S=L66kZF_LVrkwks3jYjL0tYP173HRC8EnR4w@mail.gmail.com>
 <106C4230743D00439F3B474E2F2FC8CD53885C62@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b03.edpnet.be ([212.71.1.220]:51160 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbdIAHxC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 1 Sep 2017 03:53:02 -0400
Content-Disposition: inline
In-Reply-To: <106C4230743D00439F3B474E2F2FC8CD53885C62@SHSMSX101.ccr.corp.intel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Shi, Zhongjie" <zhongjie.shi@intel.com>
Cc: Justin Delegard <justin@samsara.com>, Austin Schuh <austin@peloton-tech.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can <linux-can@vger.kernel.org>

Hey,

I don't like the approach either.
See my comments below.

> Hi Justin,
> 
> Sorry for my late response. 
> First, I need to clarify that this limit is just for user space programs.
> And please let me try to clarify the requirement in more details on our side:
> 
> (1) The change will be used for some IVI product.

That's a choice, not a justification for the patch.

> (2) In IVI, there are hundreds of use space processes running which has network access which has more risk to be compromised.
> (3) And for the IVI system, the TX rate isn't (or shouldn't be) that high as you mentioned. Only possible trigger of TX is from human: the user of IVI.
> Please consider #2 and #3, once there are some malicious/buggy program send CAN messages frequently, then it will be harmful to the whole CAN network.

Do you consider your IVI product having this patch as a safe ECU then?
It's a very rough method, since packets are considered good or bad based
on the number of recent packets.
That's like protecting your email server by rate-limiting ethernet packets.
It doesn't protect against spam, does it? It's just a rate limiter.

> 
> And by this logic in my patch, I'm trying to just to prevent the abnormal TX rate from user space on IVI product in the worst case:
> either some bug in the user space programs;
> or some compromised program by some hackers with certain zero day attack.

It's up to userspace to decide when a tx rate is abnormal.

> 
> For the ECUs on the CAN bus, I'm not sure why is it not possible to set different config for their case.
> I mean, e.g. 
> (a) On the bus, for IVI, I can use it as 5/s,
> (b) For the cases mentioned by Austin, the config could be 10M for their saturation work.
> It's just configurable for every nodes on the bus.

I looks like you set up a simple 'firewall' to CAN, with 1 hardcoded
rule in kernel code.

Kind regards,
Kurt
