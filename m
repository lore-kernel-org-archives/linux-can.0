From: Pavel Kirienko <pavel.kirienko.list@gmail.com>
Subject: CAN bus transmission timeout
Date: Mon, 28 Oct 2013 17:59:02 +0400
Message-ID: <CAGfq0uuk-7ihMaYvgEGUvnMaNLcxQc6LrvizuFG2g_KHga7iCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:63914 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756367Ab3J1N7D (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 28 Oct 2013 09:59:03 -0400
Received: by mail-bk0-f52.google.com with SMTP id u13so34513bkz.25
        for <linux-can@vger.kernel.org>; Mon, 28 Oct 2013 06:59:02 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi list,

Consider the following scenario:

There is a Linux-powered device connected to a CAN bus. The device
periodically transmits the CAN message. The nature of the data carried
by this message is like measurement rather than command, i.e. only the
most recent one is actually valid, and if some messages are lost that
is not an issue as long as the latest one was received successfully.

Then the device in question is being disconnected from the CAN bus for
some amount of time that is much longer than the interval between
subsequent message transmissions. The device logic is still trying to
transmit the messages, but since the bus is disconnected the CAN
controller is unable to transmit any of them so the messages are being
accumulated in the TX queue.

Some time later the CAN bus connection is restored, and all the
accumulated messages are being kicked on the bus one by one.

--- Problem ---

1. When the CAN bus connection is restored, undefined amount of
outdated messages will be transmitted from the TX queue.

2. While the CAN bus connection is still not available but TX queue is
already full, transmission of some most recent messages (i.e. the only
valid messages) will be discarded.

3. Once the CAN bus connection is restored, there would be short term
traffic burst while the TX queue is being flushed. This can alter the
Time Triggered Bus Scheduling if one is used (it is in my case).

--- Question ---

My application uses SocketCAN driver, so basically the question should
be applied to SocketCAN, but other options are considered too if there
are any.

I see two possible solutions: define a message transmission timeout
(if a message was not transmitted during some predefined amount if
time, it will be discarded automatically), or abort transmission of
outdated messages manually (though I doubt it is possible at all with
socket API).

Since the first option seems to be most real to me, the questions are:

1. How does one define TX timeout for CAN interface under Linux?

2. Are there other options exist to solve the problems described
above, aside from TX timeouts?

Thanks in advance,
Pavel Kirienko.

P.S. reposted from http://stackoverflow.com/questions/19633015
