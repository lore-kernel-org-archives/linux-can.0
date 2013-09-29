From: "Max S." <max@schneidersoft.net>
Subject: Re: adding can4linux to drivers/char
Date: Sun, 29 Sep 2013 19:23:42 +0000
Message-ID: <1380482622.14050.15.camel@blackbox>
References: <1881932.U1kQQJkqCz@heinz.site> <523DF9C1.30300@grandegger.com>
	 <2109885.0l6dWmo4a5@heinz.site>
	 <CADGMhsXTbEc5ifQEbNM=dS3OP6uwGrvGfZ3OCvWJ=aXJyzGs+A@mail.gmail.com>
	 <52487518.80008@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.schneidersoft.net ([173.45.248.65]:34624 "EHLO
	mail.schneidersoft.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754334Ab3I2TWY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 29 Sep 2013 15:22:24 -0400
In-Reply-To: <52487518.80008@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Sebastian Haas <dev@sebastianhaas.info>, =?ISO-8859-1?Q?Heinz-J=FCrgen?= Oertel <hj.oertel@t-online.de>, linux-can@vger.kernel.org

This isn't on topic to this thread...
Just thought I'd note:

On Sun, 2013-09-29 at 20:44 +0200, Marc Kleine-Budde wrote:
> If there is a need for bitrate detection, feel free request it here. I
> think there are some controllers that support this in hardware, while
> others don't. Is there a known working algorithm for bitrate detection?

Most controllers have listen only mode, in which the error counters are
frozen. It is then possible to systematically try all common bit-rate
configurations, and listen for good frames. works best when you start
with high speeds and work your way down. Listen only mode baud sniffing
will require at least two other nodes (one to send, one to ack..)

Some controllers also have a mode similar to listen only, but that also
internally connect the TX signal to the RX signal. this way you only
need 1 other node to send non acked frames. the autobauding node will
then ack those frames for itself only. Atmel calls this mode LOOPBACK...
even though its not a typical "LOOPBACK".

Additionally when using micros with on-board CAN controllers the RX pin
can be temporarily reprogrammed to an input. With a pin change interrupt
and a timer it is then possible to measure the TQ used by other nodes.


