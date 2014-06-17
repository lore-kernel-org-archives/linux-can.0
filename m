From: Alexander GQ Gerasiov <gq@cs.msu.su>
Subject: Re: SJA1000 loopback feature
Date: Tue, 17 Jun 2014 16:13:47 +0400
Message-ID: <20140617161347.25cb639e@snail>
References: <CAEJ7JO2ejHBVANYWXxXe_DstXCW-hm9xzJYXifiU+RwYNS3M1A@mail.gmail.com>
	<539F3DDF.70007@hartkopp.net>
	<CAEJ7JO1a_5Z2yKYDw30XjXh3qt4Qr-yRUVMUkz9s3MRv=zLWhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from eol.lvk.cs.msu.su ([158.250.17.73]:44698 "EHLO
	eol.lvk.cs.msu.su" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932455AbaFQMWH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Jun 2014 08:22:07 -0400
Received: from snail (unknown [192.168.131.93])
	by eol.lvk.cs.msu.su (Postfix) with ESMTPSA id 48B84140077
	for <linux-can@vger.kernel.org>; Tue, 17 Jun 2014 16:13:05 +0400 (MSK)
In-Reply-To: <CAEJ7JO1a_5Z2yKYDw30XjXh3qt4Qr-yRUVMUkz9s3MRv=zLWhA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Tue, 17 Jun 2014 15:41:14 +0400
Nikita Edward Baruzdin <nebaruzdin@gmail.com> wrote:

> 
> You see, we, for instance, don't really need hardware loopback for
> our case. What we need is to have software loopback working. And for
> that STM is necessary. If we enable SRR feature as well, we'll have
> each message loopbacked twice: once by software
> (can_{put|get}_echo_skb() functions) and once by hardware (message in
> controller's RX buffer). Thus we'll probably have to disable the
> software loopback per socket (CAN_RAW_LOOPBACK option) which is not
> really convenient.

Just to clarify situation, Nikita is working on distributed system,
where N components are working on M physical hosts (N >> M) and should
be able to intercommunicate with each other via can bus even if M==1.
In such case, ACKs are absent on the bus, but frames are transmited
between several components within one host.

So we want to be able to tune CAN subsystem to ignore ACK absence.
As we understand, SJA1000 has the mode we are looking for (but lacks
support in driver/subsystem).

As LOOPBACK option for interface means that TX should be passed to RX,
thats not exactly what we need. (As for loopback we already have it
on the socket with CAN_RAW_LOOPBACK and CAN_RAW_RECV_OWN_MSGS.) I think
we could add one more interface mode "ignore-no-ack", but we'd like to
stay as much closer to vanilla kernel as possible and contribute our
modifications, so we need your opinion on

Is this the common situation? Do you interested in such mode and our
modifications? How should we realize thees modifications?

-- 
Alexander.
