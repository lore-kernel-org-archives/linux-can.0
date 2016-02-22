From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: RFC: can-j1939
Date: Mon, 22 Feb 2016 06:22:31 +0100
Message-ID: <20160222052231.GA2022@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b02.edpnet.be ([212.71.1.222]:47189 "EHLO
	relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975AbcBVFXI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 22 Feb 2016 00:23:08 -0500
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yang Wang <wang701@purdue.edu>, Alex Layton <alex@layton.in>, David Jander <david@protonic.nl>, laurent vaudoit <laurent.vaudoit@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can <linux-can@vger.kernel.org>

Hey,

Last November, we had some discussion on how to improve the can-j1939
API in order to suit more users.
I had some delays for finding stupid bugs (@Laurent, I backporte to an iMX6
with v3.10 kernel with can-j1939 for finding some of them), now it's
ready to share.

I had assembled a quick starter guide long time ago already in markdown.
I didn't feel like translating it to elinux.org's mediawiki, so I put it
https://github.com/kurt-vd/test-can-j1939/blob/master/can-j1939-kickstart.md

During my development, I tested can-j1939 on 3 linux kernel versions:
v3.10, v3.15 and v4.3. I later found that the small changes for v4.3
actually were introduced in v4.1, so I backported j1939d-v4.3 to
j1939d-v4.1.

On https://github.com/kurt-vd/linux, you will find 4 additional
branches: j1939d-v3.10, j1939d-v3.15, ...
The 'd' suffix as distinction, means 'direct', however that is less important.

I will in short highlight some aspects of the new stack, most of which
were raised in past discussions on this list:

* it is stable, works with the latest kernels.
* does not need or use netlink. You don't need a modified iproute2 anymore
* when a can-j1939 socket binds to an interface, can-j1939 starts
  processing on this interface: address claim tracking + transport
  protocol assembly.
  when the last such socket closes, can-j1939 stops for that interface.
  This also means that a transport protocol session that _started_ before
  the first socket opens will not be seen by can-j1939. This conforms to
  datagram communication.
* when a socket binds to an address or name, the kernel starts treating
  that address/name as a local one.
* The new stack takes less measures to detect address collisions
  for static addresses, and keeps more responsibility to the user.
* non-root users can start can-j1939 on an interface, add addresses, ...
* a list of current local addresses is available in /proc
* add transport protocol parameter, to control outgoing inter-packet delays.
* add parameter to pad all packets to 8 bytes.

I hope you will find time to take a look at it.
We could possibly agree on the API?

Kind regards,
Kurt
