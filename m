From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: [PATCH 09/14] can: raw: use struct sock::sk_bound_dev_if instead
 of struct raw_sock::ifindex
Date: Fri, 25 Aug 2017 20:46:44 +0200
Message-ID: <20170825184644.GB6602@airbook.vandijck-laurijssen.be>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-10-mkl@pengutronix.de>
 <da0c99fe-16ca-6e3a-0249-663b0691c850@hartkopp.net>
 <20170824141126.GD21548@airbook.vandijck-laurijssen.be>
 <e1a150f8-7a0b-b327-86ac-e66cf3d817ef@hartkopp.net>
 <20170825093410.GC18332@airbook.vandijck-laurijssen.be>
 <f739fc65-5f17-532c-a635-0cc2fe8e2382@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b03.edpnet.be ([212.71.1.220]:58775 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755001AbdHYSqt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 25 Aug 2017 14:46:49 -0400
Content-Disposition: inline
In-Reply-To: <f739fc65-5f17-532c-a635-0cc2fe8e2382@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, kernel@pengutronix.de

Hey Oliver,

> On 08/25/2017 11:34 AM, Kurt Van Dijck wrote:
> >>On 08/24/2017 04:11 PM, Kurt Van Dijck wrote:
> >>>>>This patch removes the struct raw_sock::ifindex from the CAN raw socket
> >>>>>and uses the already existing sock::sk_bound_dev_if instead.
> >>>>
> >>>>I would like to omit this patch.
> >>>>
> >>>>1. It does NOT increase the readability ;-)
> >>>>
> >>>>ifindex points out that we are handling an interface index.
> >>>>sk_bound_dev_if could be anything.
> >>>
> >>>See http://elixir.free-electrons.com/linux/v4.12.8/source/net/core/sock.c#L617
> >>>sk_bound_dev_if may be a difficult name, but could not be anything.
> >>>It allow to use SO_BINDTODEVICE (man 7 socket) to work properly for can raw sockets too.
> >>
> >>When ro->ifindex = 0 it can still be bound in the case of CAN sockets.
> >>There is a different semantic as ifindex = zero means 'all CAN interfaces'
> >>and not 'no interface'.
> >
> >ro->ifindex = 0: accept traffic from all interfaces
> >ro->ifindex != 0: accept traffic only from 1 iface
> >
> >sk_bound_dev_if = 0: accept traffic from all interfaces
> >sk_bound_dev_if != 0: accept traffic only from 1 iface
> >
> >What is the semantic difference?
> 
> man 7 socket
> 
> SO_BINDTODEVICE
> 
> Bind this socket to a particular device like “eth0”, as specified in the
> passed interface name.  If the name  is  an empty  string  or the option
> length is zero, the socket device binding is removed.  The passed option is
> a variable-length null-terminated interface name string with the maximum
> size of IFNAMSIZ.  If a socket is bound to  an  interface,  only  packets
> received from that particular interface are processed by the socket. Note
> that this works only for some socket types, particularly AF_INET sockets.
> It is not supported for packet  sockets  (use  normal bind(2) there).

A verbatim copy of the man page isn't helping. I have read it.

> 
> Especially "If the name  is  an empty  string  or the option length is zero,
> the socket device binding is removed." is wrong.

Do you mean the man page is wrong?
Or do you mean that the semantic difference is wrong?
Or ?

> 
> A bound CAN_RAW socket can have ifindex = 0.

I see no reason why a bound UDP socket can not have sk_bound_dev_if = 0.
I see no reason why a bound CAN_RAW socket can not either.
I start to think here that the word 'device binding' confuses you with
bind(2), but I have not seen any reference that SO_BINDTODEVICE
conflicts/interacts with bind() so far.

> 
> And "It is not supported for packet  sockets  (use  normal  bind(2) there)"
> - the CAN_RAW socket is based on PF_PACKET sockets with the device binding
> and addressing concept.
> 
> The more I look into this, the more I'm sure that we should leave it as-is.

> >>>>I would like to omit this patch.

Well, I feel it may block the others, so indeed, omitting may be the
best by lack of consensus.

Regards,
Kurt
