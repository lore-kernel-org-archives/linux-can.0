From: "Osborne, Paul" <Paul.Osborne@digi.com>
Subject: Expose filtered CAN interface to processes
Date: Fri, 29 Jan 2016 19:06:58 +0000
Message-ID: <EB7F4954055D8D47BE2774BFC0597392301E1285@MTK-SMS-XCH02.digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail1.bemta8.messagelabs.com ([216.82.243.196]:14257 "EHLO
	mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751124AbcA2TOO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 29 Jan 2016 14:14:14 -0500
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello,

I am currently trying to figure out the best way to present a couple
CAN devices to a process in such a way that will allow for filtering
rules for sends on the exposed interface to be filtered according to
some set of rules.

cangw works great for the basic parts of this use case.  That is, I
have traffic coming from vcan<x> to can<x> after filtering and it
works as expected.  The problem I have now is that for the user
process can see both CAN buses.  I would only like them to see the
vcan devices.

Is there a solution for this available in the kernel today or would
this only work with network namespaces (which are not supported for
can right now)?

More accurately, it appears that network namespaces work on CAN
interfaces but there does not appear to be the required support
present for bridging vcan devices as can be done with veth devices
(i.e. ip link add veth0 type veth peer name veth1).

I am new to network namespaces; Am I missing something?  Is this a
real use case for network namespace support?  It sounded like there
was uncertainty on this point with the RFC that was posted back in
September by Andri: http://comments.gmane.org/gmane.linux.can/8589.

Thanks,
Paul
