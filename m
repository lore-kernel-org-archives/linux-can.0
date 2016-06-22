From: ajneu <ajneu1@gmail.com>
Subject: want blocking writes, but eventually get: errno 105 (No buffer space available)
Date: Wed, 22 Jun 2016 14:39:52 +0000 (UTC)
Message-ID: <loom.20160622T163626-806@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:41597 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751789AbcFVOlX (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 22 Jun 2016 10:41:23 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1bFjK8-0004QW-Tr
	for linux-can@vger.kernel.org; Wed, 22 Jun 2016 16:40:13 +0200
Received: from 195.50.142.51 ([195.50.142.51])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 22 Jun 2016 16:40:12 +0200
Received: from ajneu1 by 195.50.142.51 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 22 Jun 2016 16:40:12 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,

I'm trying to figure out how the blocking behaviour of socketcan works.

My test-program blocks (in write) in the beginning (the 1st few
program-runs), but then after a number of program-restarts I eventually get:
   errno 105 (No buffer space available)
which is not acceptable, since I want to block (in the write), and not get
any error!!

* What does the program do?
It does continuous blocking writes in a loop.
To get it to block, I'm have no other participants on the bus! (so I'm in
Error-Passive).


* My config:
  sudo ip link set can0 down
  sudo ip link set can0 txqueuelen 10
  sudo ip link set can0 up type can bitrate 250000


1st program run:
~> block on 33'rd write (32 frames queued)

2nd program run:
~> block on 7'th write (6 frames queued)

3rd program run:
~> block on 7'th write (6 frames queued)

4rd program run:
~> when trying 3'rd write: errno 105 (No buffer space available)
   (so 2 frames queued)

PLEASE: could sombody explain these numbers !
They don't make sense to me.


Details:
=========

I'm using PEAK USB Adapter (PCAN-USB FD) for normal CAN Frames (standard
format), and lsmod shows peak_usb as it should.

I'm using this setting:

// Write should block, when socketcan's own queue is full.
// To have this behaviour (and not get error ENOBUFS) set SO_SNDBUF to its
minimum value.
// See https://rtime.felk.cvut.cz/can/socketcan-qdisc-final.pdf#page=21
const int sndbuf = 0;
if (setsockopt(sock_fd, SOL_SOCKET, SO_SNDBUF, &sndbuf, sizeof(sndbuf)) < 0) {
 std::cerr << "Error setting SO_SNDBUF in setsockopt" <<
std::strerror(errno) << '\n';
 return -1;
}


Do I have to set txqueuelen to something else, in order to avoid getting
errno 105 (No buffer space available)?

Thanks.
ajneu

