From: Brian Silverman <brian@peloton-tech.com>
Subject: Re: socket can receive order
Date: Tue, 8 Sep 2015 23:10:09 -0400
Message-ID: <CAGt3f4nRhtx=W_2NWErmoS=o4x0qu89VzkfgLvsJ1=+WLYyJTw@mail.gmail.com>
References: <55EEAD8D.3070603@engineeredarts.co.uk> <55EEB217.3080706@pengutronix.de>
 <55EEBB4E.6080104@engineeredarts.co.uk> <55EEC2BD.6010302@pengutronix.de>
 <55EEC3C0.1010002@engineeredarts.co.uk> <55EF133E.8070105@hartkopp.net> <CANGgnMZMRMtpugbN4x9Dh0v3i7zaAXRYfk+C1qhx1Nre=6WtEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:33420 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754665AbbIIDKj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Sep 2015 23:10:39 -0400
Received: by igbkq10 with SMTP id kq10so94698013igb.0
        for <linux-can@vger.kernel.org>; Tue, 08 Sep 2015 20:10:39 -0700 (PDT)
In-Reply-To: <CANGgnMZMRMtpugbN4x9Dh0v3i7zaAXRYfk+C1qhx1Nre=6WtEg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Schuh <austin@peloton-tech.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Daniel Squires <dan@engineeredarts.co.uk>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Another thing Austin and I do is set up RPS (receive packet steering)
for the Ethernet interfaces so the hardware sends the physical
Ethernet interrupts to that same core which isn't involved in
servicing the CAN interfaces at all.

On Tue, Sep 8, 2015 at 10:30 PM, Austin Schuh <austin@peloton-tech.com> wrote:
>
> On our boxes, I've been setting the affinity for both the IRQ thread
> (we are running a RT kernel), and the interrupt to the same single
> core.  Would that help here?
>
> We've seen CAN packets get significantly delayed causing overruns due
> to Ethernet load and both CAN and ethernet sharing the same softirq.
> Our solution has been to set the affinity for each of those to
> different cores to keep them isolated.
>
> Austin
