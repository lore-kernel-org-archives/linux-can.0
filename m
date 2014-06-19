From: Alexander GQ Gerasiov <gq@cs.msu.su>
Subject: Re: SJA1000 loopback feature
Date: Thu, 19 Jun 2014 16:44:24 +0400
Message-ID: <20140619164424.244e5634@snail>
References: <CAEJ7JO2ejHBVANYWXxXe_DstXCW-hm9xzJYXifiU+RwYNS3M1A@mail.gmail.com>
	<539F3DDF.70007@hartkopp.net>
	<CAEJ7JO1a_5Z2yKYDw30XjXh3qt4Qr-yRUVMUkz9s3MRv=zLWhA@mail.gmail.com>
	<20140617161347.25cb639e@snail>
	<53A1EDA7.7040504@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from eol.lvk.cs.msu.su ([158.250.17.73]:55975 "EHLO
	eol.lvk.cs.msu.su" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbaFSMnq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 19 Jun 2014 08:43:46 -0400
Received: from snail (unknown [192.168.131.93])
	by eol.lvk.cs.msu.su (Postfix) with ESMTPSA id A0EB31407F0
	for <linux-can@vger.kernel.org>; Thu, 19 Jun 2014 16:43:44 +0400 (MSK)
In-Reply-To: <53A1EDA7.7040504@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello, Oliver.

Wed, 18 Jun 2014 21:51:03 +0200
Oliver Hartkopp <socketcan@hartkopp.net> wrote:

> > So we want to be able to tune CAN subsystem to ignore ACK absence.
> > As we understand, SJA1000 has the mode we are looking for (but lacks
> > support in driver/subsystem).
> 
> If we would find a name for it, it could be:
> 
> #define CAN_CTRLMODE_PRESUME_ACK        0x40    /* ignore missing CAN
> ACKs */

Ok, what is the right git repository for linux-can kernel modules?
I can see
linux-can/can-modules
linux-can/linux-can
linux-can/linux-can-next

or may be there is any tree on git.kernel.org?

Where are the actual sources we need to patch?

> > As LOOPBACK option for interface means that TX should be passed to
> > RX, thats not exactly what we need. (As for loopback we already
> > have it on the socket with CAN_RAW_LOOPBACK and
> > CAN_RAW_RECV_OWN_MSGS.) I think we could add one more interface
> > mode "ignore-no-ack", but we'd like to stay as much closer to
> > vanilla kernel as possible and contribute our modifications, so we
> > need your opinion on
> > 
> > Is this the common situation? Do you interested in such mode and our
> > modifications? How should we realize thees modifications?
> > 
> 
> Just to give an example how I dealed with such situation:
> 
> 1. Let all applications run on a virtual CAN interface (e.g. vcan0).
> 2. make a cross routing with can-gw netlink routes

Yes, I was thinking about it. We strictly need the same order of
events on both buses (local/virtual and remote/hardware), but in case of
bridging (userspace, or even in-kernel one) race is possible. So we'd
better use one bus (to rule them all =)) 

-- 
Alexander.
