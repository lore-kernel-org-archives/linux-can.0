From: Hannes Frederic Sowa <hannes@stressinduktion.org>
Subject: [ANNOUNCE] libsocket-can-java: library for CAN sockets
Date: Thu, 1 Nov 2012 00:59:23 +0100
Message-ID: <20121031235923.GC3912@order.stressinduktion.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from order.stressinduktion.org ([87.106.68.36]:54824 "EHLO
	order.stressinduktion.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755315Ab2KAAEe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 31 Oct 2012 20:04:34 -0400
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi all!

I just published a small java wrapper library around CAN sockets under
the MIT license:

  https://github.com/entropia/libsocket-can-java

It does not yet support all features offered by SocketCAN and is not
really tested at all (I just transferred some bytes over a slcan adapter
and tested it a bit with vcan and it seemed to work).

I will implement more features as our CAN-based home automation network
is growing.

I would be happy to hear your feedback. Of course, I will accept patches,
too.

Greetings,

  Hannes

