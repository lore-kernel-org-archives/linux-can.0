From: Paarvai Naai <opensource3141@gmail.com>
Subject: Re: getifaddrs and SocketCAN interfaces
Date: Mon, 30 Mar 2015 14:46:49 -0700
Message-ID: <CAE+ymrttLPXNAkiqe0FiX38EASFXpdyBs_EWEmE+8AXEg9S1Bg@mail.gmail.com>
References: <CAE+ymrs_yWEgR6OVP8rCiqCr4wJtXUGkYVJNMbgZxufTROeZ4Q@mail.gmail.com>
	<55184640.8030900@hartkopp.net>
	<2923D548-AE6E-4B5F-A5DD-A8F8E6570890@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:33737 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752AbbC3Vqt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 30 Mar 2015 17:46:49 -0400
Received: by obvd1 with SMTP id d1so76547742obv.0
        for <linux-can@vger.kernel.org>; Mon, 30 Mar 2015 14:46:49 -0700 (PDT)
In-Reply-To: <2923D548-AE6E-4B5F-A5DD-A8F8E6570890@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: dev.kurt@vandijck-laurijssen.be
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Hi Kurt,

Thanks for that pointer!  It's exactly what I'm looking for as it is
less complicated than libnetlink from iproute2.

(I see there was an earlier post about enumif too, but I missed it
during my earlier search:
http://permalink.gmane.org/gmane.linux.can/3351)

I see that your libenumif.cc has the following includes:
#include <linux/rtnetlink.h>
#include <linux/netlink.h>

Not being super familiar with netlink, what would you say are the
forward/backward compatibility guarantees for these kernel-level
includes?  I'm assuming the dependance on these kernel-level includes
is pretty stable?

Regarding, the other suggestions, these are good options too, but I'd
prefer not to use the /sys filesystem if possible.  Relying on /sys
can be brittle.

Thanks!
Paarvai

On Sun, Mar 29, 2015 at 12:40 PM,  <dev.kurt@vandijck-laurijssen.be> wrote:
> I created
> https://github.com/kurt-vd/enumif
> for this reason.
> I'd explain if I was using my own computer
>
> Kurt
