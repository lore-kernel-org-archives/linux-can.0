From: "R U Local" <roystonvasey@slingshot.co.nz>
Subject: RE: RFC can-j1939
Date: Tue, 23 Feb 2016 10:36:36 +1300
Message-ID: <006b01d16db9$1b9e94d0$52dbbe70$@slingshot.co.nz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mta3.flip.co.nz ([103.9.40.9]:45266 "EHLO mta3.flip.co.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755797AbcBVVnM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 22 Feb 2016 16:43:12 -0500
Received: from fortimail1.tranzpeer.net (mx222.tranzpeer.net [202.180.66.222])
	by mta3.flip.co.nz (8.14.4/8.14.4) with ESMTP id u1MLacAj005364
	for <linux-can@vger.kernel.org>; Tue, 23 Feb 2016 10:36:38 +1300
Received: from wrinklednose (13.55.69.111.static.snap.net.nz [111.69.55.13] (may be forged))
	(user=roystonvasey@slingshot.co.nz mech=LOGIN bits=0)
	by fortimail1.tranzpeer.net  with ESMTP id u1MLaa4D018645-u1MLaa4F018645
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-can@vger.kernel.org>; Tue, 23 Feb 2016 10:36:36 +1300
Content-Language: en-nz
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: 'linux-can' <linux-can@vger.kernel.org>

Dear Kurt,
Thanks for your great work.
I'm just bringing up the J1939 stack on a TI OMAP4 based system.
I'm locked to a custom kernel 3.19 due to media drivers and codecs.
I followed your guide and pulled code from 4.1 and 3.15 branches.
I also patched and built can-utils and iproute2.
I can't get the Transport Protocol to work send only sends the first packet and receive hangs on reception of the first packet.

It may be that mixing iproute2 and mixing branches has broken the TP.
Which branch should I use as a reference? I'll re-patch and re-test with unpatched iproute2.

As far as your RFC your implementation looks to be ideal for our applications.
For user space applications where should the headers (<linux/can/can.h> & <linux/can/j1939/j1939.h>) be taken from or provided by?

Cheers Mike.

-----Original Message-----
From: linux-can-owner@vger.kernel.org [mailto:linux-can-owner@vger.kernel.org] On Behalf Of Kurt Van Dijck
Sent: Monday, 22 February 2016 18:23
To: Yang Wang <wang701@purdue.edu>; Alex Layton <alex@layton.in>; David Jander <david@protonic.nl>; laurent vaudoit <laurent.vaudoit@gmail.com>; Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can <linux-can@vger.kernel.org>
Subject: RFC: can-j1939

Hey,

Last November, we had some discussion on how to improve the can-j1939 API in order to suit more users.
I had some delays for finding stupid bugs (@Laurent, I backporte to an iMX6 with v3.10 kernel with can-j1939 for finding some of them), now it's ready to share.

I had assembled a quick starter guide long time ago already in markdown.
I didn't feel like translating it to elinux.org's mediawiki, so I put it https://github.com/kurt-vd/test-can-j1939/blob/master/can-j1939-kickstart.md

During my development, I tested can-j1939 on 3 linux kernel versions:
v3.10, v3.15 and v4.3. I later found that the small changes for v4.3 actually were introduced in v4.1, so I backported j1939d-v4.3 to j1939d-v4.1.

On https://github.com/kurt-vd/linux, you will find 4 additional
branches: j1939d-v3.10, j1939d-v3.15, ...
The 'd' suffix as distinction, means 'direct', however that is less important.

I will in short highlight some aspects of the new stack, most of which were raised in past discussions on this list:

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
--
To unsubscribe from this list: send the line "unsubscribe linux-can" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html

