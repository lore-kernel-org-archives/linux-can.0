From: ajneu <ajneu1@gmail.com>
Subject: Re: programatically determine netlink-type: can or vcan ...
Date: Tue, 21 Jun 2016 15:26:03 +0000 (UTC)
Message-ID: <loom.20160621T171750-409@post.gmane.org>
References: <loom.20160621T163010-819@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:47590 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750731AbcFUPm1 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 21 Jun 2016 11:42:27 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1bFNZ7-0002ax-Oi
	for linux-can@vger.kernel.org; Tue, 21 Jun 2016 17:26:14 +0200
Received: from 195.50.142.51 ([195.50.142.51])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 21 Jun 2016 17:26:13 +0200
Received: from ajneu1 by 195.50.142.51 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 21 Jun 2016 17:26:13 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

ajneu <ajneu1 <at> gmail.com> writes:

> 
> Hi,
> 
> how can one determine the netlink-type (can or vcan, ...) of an
> interface-name (e.g. can1), from a C program?
> 
> It would be great if I can e.g. get that from /sys/class/net/can1 somehow.
> 
> What would work, but is NOT nice (because of portability problems), is to
> use the C-function system:
> 
> if (system("test \"$(ip link show can1 type vcan)\" !=  \"\"")) {
>    printf("can1 is not vcan\n");
> } else {
>    printf("can1 is vcan\n");
> }
(on command line: 
   test "$(ip link show can1 type vcan)" !=  "" )

This would be nice in libsocketcan, but it's not in there. Somewhat limited...

Missing also, from libsocketcan, is the ability to determine if a device
such as can1 exists.
(What I do now, is to just check if /sys/class/net/can1 exists.)

